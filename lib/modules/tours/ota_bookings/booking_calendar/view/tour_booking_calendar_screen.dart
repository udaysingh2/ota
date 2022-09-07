import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_cupertino_picker/ota_cupertino_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_date_selector/ota_date_picker.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/bloc/ota_booking_calender_bloc.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_argument.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_view_model.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/widgets/booking_tile_widget.dart';
import 'package:ota/modules/tours/reservation/bloc/tours_review_reservation_bloc.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tours_review_reservation_argument.dart';
import 'package:ota/modules/tours/reservation/view_model/tours_review_reservation_model.dart';

const int _kMaxLimit = 9;
const int _kMinLimit = 1;
const int _kMinChildLimit = 0;
const int _kMaxTravellersAllowedPerReservation = _kMaxLimit;
const int _kChildCounterConstant = 1;
const double _kAppBarHeight = 89;

class TourBookingCalenderScreen extends StatefulWidget {
  const TourBookingCalenderScreen({Key? key}) : super(key: key);

  @override
  State<TourBookingCalenderScreen> createState() =>
      _TourBookingCalenderScreenState();
}

class _TourBookingCalenderScreenState extends State<TourBookingCalenderScreen> {
  final OtaBookingCalendarBloc _bloc = OtaBookingCalendarBloc();
  final TourReviewReservationBloc _reviewReservationBloc =
      TourReviewReservationBloc();
  TourBookingCalendarArgument? bookingArguments;
  TourReviewReservationArgument? initiateReservationArguments;

  void _requestTourPackageDetails() {
    OtaDialogLoader().showLoader(context);
    _bloc.getTourPackageDetails(bookingArguments);
  }

  void _onOkClick(BuildContext context) {
    int minimumAdultsRequired = _bloc.tourPackage.minimumSeats;
    if (_bloc.totalSelectedTravellers > _kMaxTravellersAllowedPerReservation) {
      _showAlertDialog(
          context, AppLocalizationsStrings.maxTravellersExceedPerReservation);
    } else if (_bloc.totalAdultTravellers < minimumAdultsRequired) {
      final String minimumSeatMessage = getTranslated(
              context, AppLocalizationsStrings.addMinTravellersToThePackage)
          .replaceAll('#', minimumAdultsRequired.toString());
      _showAlertDialog(context, minimumSeatMessage);
    } else {
      initiateReservationArguments =
          bookingArguments?.toTourReviewReservationArgument(_bloc.tourPackage);
      OtaDialogLoader().showLoader(context);
      _reviewReservationBloc.initiateTourBooking(initiateReservationArguments,
          isRefresh: true);
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    _reviewReservationBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.initDetails(
          bookingArguments!.packageName,
          bookingArguments!.adultPrice,
          bookingArguments!.childPrice,
          bookingArguments!.availableSeats,
          bookingArguments!.minimumSeats);
      _requestTourPackageDetails();
    });

    _bloc.stream.listen((event) {
      if (_bloc.state.bookingCalendarState ==
          BookingCalendarState.failureNetwork) {
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
      if (_bloc.state.bookingCalendarState != BookingCalendarState.initial) {
        OtaDialogLoader().hideLoader(context);
      }
      if (_bloc.state.bookingCalendarState ==
          BookingCalendarState.packageFullSold) {
        _showAlertDialog(context, AppLocalizationsStrings.tourFullyBooked);
      }
    });

    _reviewReservationBloc.stream.listen(
      (event) {
        OtaDialogLoader().hideLoader(context);
        if (_reviewReservationBloc.state.screenState ==
            TourReviewReservationScreenState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
        if (_reviewReservationBloc.state.screenState ==
                TourReviewReservationScreenState.failureToken ||
            _reviewReservationBloc.state.screenState ==
                TourReviewReservationScreenState.failure) {
          _showTokenErrorAlert();
        } else if (_reviewReservationBloc.state.screenState ==
            TourReviewReservationScreenState.failureUnavailable) {
          _showAlertDialog(context, AppLocalizationsStrings.tourFullyBooked);
        } else if (_reviewReservationBloc.state.screenState ==
            TourReviewReservationScreenState.failureMinimumLimit) {
          final int minimumAdultSeats = _bloc.tourPackage.minimumSeats;
          final String minimumSeatMessage = getTranslated(
                  context, AppLocalizationsStrings.addMinTravellersToThePackage)
              .replaceAll('#', minimumAdultSeats.toString());
          _showAlertDialog(context, minimumSeatMessage);
        } else if (_reviewReservationBloc.state.screenState ==
            TourReviewReservationScreenState.success) {
          OtaDialogLoader().hideLoader(context);
          Navigator.pushNamed(
            context,
            AppRoutes.tourReservationScreen,
            arguments: TourReviewReservationModel(
              adultCount: _bloc.tourPackage.adultCount,
              childCount: _bloc.tourPackage.childCount,
              lastPrice: _bloc.tourPackage.totalPrice,
              argument: initiateReservationArguments!,
              reviewReservationData:
                  _reviewReservationBloc.state.reservationViewModel!,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bookingArguments = ModalRoute.of(context)?.settings.arguments
        as TourBookingCalendarArgument;
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.bookingDetails),
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: true,
        child: Stack(
          children: [
            ListView(
              children: [
                _buildBottomSection(),
              ],
            ),
            _buildPriceFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCalendar(),
        _buildPackageHeader(),
        _buildTitle(),
        _buildNoOfTravelersTicketLabel(),
        _buildAdultTileWidget(),
        if (_bloc.shouldShowChildTileWidget) _buildChildTileWidget(),
        const SizedBox(
          height: kSize100,
        ),
      ],
    );
  }

  Widget _buildNoPackageWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCalendar(),
        _buildPackageHeader(),
        _showNoPackageWidget(),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCalendar(),
        _buildPackageHeader(),
        _showNoPackageWidget(),
      ],
    );
  }

  Widget _showNoPackageWidget() {
    return Padding(
      padding: kPaddingHori24Vert16,
      child: OtaSearchNoResultWidget(
        dividerHeight: kSize0,
        errorTextHeader: getTranslated(context, AppLocalizationsStrings.sorry),
        errorTextFooter: getTranslated(
            context, AppLocalizationsStrings.noTourPackageAvailable),
      ),
    );
  }

  Widget _buildBottomSection() {
    return BlocBuilder(
        bloc: _bloc,
        builder: () {
          switch (_bloc.state.bookingCalendarState) {
            case BookingCalendarState.initial:
            case BookingCalendarState.success:
              return _buildSuccessWidget();
            case BookingCalendarState.packageFullSold:
            case BookingCalendarState.noPackage:
              return _buildNoPackageWidget();
            case BookingCalendarState.failure:
            case BookingCalendarState.failure1899:
            case BookingCalendarState.failure1999:
              return _buildErrorWidget();
            case BookingCalendarState.failureNetwork:
              return _buildNoInternetWidget();
            default:
              return const SizedBox();
          }
        });
  }

  Widget _buildAdultTileWidget() {
    return BookingTileWidget(
      title: getTranslated(context, AppLocalizationsStrings.adults),
      price: _bloc.tourPackage.adultPrice,
      currency: bookingArguments?.currency,
      value: _bloc.tourPackage.adultCount,
      minValue: _kMinLimit,
      maxValue: _kMaxLimit,
      onValueAdded: (value) => _bloc.updateAdults(value),
      onValueRemoved: (value) => _bloc.updateAdults(value),
    );
  }

  Widget _buildChildTileWidget() {
    return BookingTileWidget(
      title: getTranslated(context, AppLocalizationsStrings.children),
      price: _bloc.tourPackage.childPrice,
      currency: bookingArguments?.currency,
      value: _bloc.tourPackage.childCount,
      minValue: _kMinChildLimit,
      maxValue: _kMaxLimit,
      postTitle: getTranslated(context, AppLocalizationsStrings.ages),
      ageRange:
          '${_bloc.tourPackage.childMinAge}-${_bloc.tourPackage.childMaxAge}',
      childAgeList: _bloc.tourPackage.childAgeList,
      onValueAdded: (value) {
        _showAddChildAgeSheet(
            value: _kChildCounterConstant,
            titleValue: _bloc.tourPackage.childCount + _kChildCounterConstant);
      },
      onValueRemoved: (value) => _bloc.removeChild(_kChildCounterConstant),
      onChildAgeUpdate: (index) {
        _showAddChildAgeSheet(
            value: index + _kChildCounterConstant,
            titleValue: index + _kChildCounterConstant,
            oldAge: _bloc.tourPackage.childAgeList[index],
            childIndex: index);
      },
    );
  }

  Widget _buildCalendar() => OTADatePicker(
        selectedDate: bookingArguments?.selectedDate,
        checkinDate: DateTime.now(),
        checkoutDate: DateTime.now()
            .add(Duration(days: AppConfig().configModel.calendarMinDate - 1)),
        preselectedDates: const [],
        isSameDateSelectionDisabled: true,
        onDateChange: (date) {
          bookingArguments?.selectedDate = date;
          _requestTourPackageDetails();
        },
      );

  Widget _buildPackageHeader() {
    return Padding(
      padding: kPaddingHori24Vert16,
      child: Text(
        getTranslated(context, AppLocalizationsStrings.selectedPackage),
        style: AppTheme.kHeading1Medium,
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: kPaddingHori24,
      child: Text(
        _bloc.tourPackage.packageName,
        style: AppTheme.kBodyRegular,
      ),
    );
  }

  Widget _buildNoOfTravelersTicketLabel() {
    final int availableSeats = _bloc.tourPackage.availableSeats;
    final String availableSeatMessage =
        getTranslated(context, AppLocalizationsStrings.tourSeatAvailableMessage)
            .replaceAll('#', availableSeats.toString());
    return Padding(
      padding:
          const EdgeInsets.only(left: kSize24, right: kSize24, top: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated(context, AppLocalizationsStrings.noOfTravelers),
            style: AppTheme.kHeading1Medium,
          ),
          if (availableSeats <=
              AppConfig().configModel.seatAvailabilityThresholdMin)
            const SizedBox(
              height: kSize8,
            ),
          if (availableSeats <=
              AppConfig().configModel.seatAvailabilityThresholdMin)
            Row(
              children: <Widget>[
                const Icon(Icons.info_outlined, color: AppColors.kSystemWrong),
                const SizedBox(width: kSize5),
                Text(
                  availableSeatMessage,
                  style: AppTheme.kBody.copyWith(color: AppColors.kSystemWrong),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPriceFooter(BuildContext context) {
    CurrencyUtil currencyUtil =
        CurrencyUtil(currency: bookingArguments?.currency);
    return BlocBuilder(
      bloc: _bloc,
      builder: () {
        if (_bloc.state.bookingCalendarState == BookingCalendarState.success ||
            _bloc.state.bookingCalendarState == BookingCalendarState.initial) {
          return OtaBottomButtonBar(
            button1: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  TextSpan(
                    text: currencyUtil
                        .getFormattedPrice(_bloc.tourPackage.totalPrice)
                        .addNextLine(),
                    style: AppTheme.kHeading1Medium,
                  ),
                  TextSpan(
                    text: getTranslated(context, AppLocalizationsStrings.total),
                    style: AppTheme.kSmallRegular
                        .copyWith(color: AppColors.kGrey50),
                  )
                ],
              ),
            ),
            button2: SizedBox(
              width: kSize120,
              child: OtaTextButton(
                title: getTranslated(context, AppLocalizationsStrings.ok),
                isDisabled: false,
                onPressed: () => _onOkClick(context),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void _showAddChildAgeSheet(
      {required int value,
      required int titleValue,
      int? childIndex,
      int? oldAge}) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: AppColors.kLight100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kSize24),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: OtaCupertinoWidget(
            title:
                '${getTranslated(context, AppLocalizationsStrings.ageOfChild)} $titleValue',
            maxInputValueLimit: _bloc.tourPackage.childMaxAge,
            minInputValueLimit: _bloc.tourPackage.childMinAge,
            oldAge: oldAge != null
                ? (oldAge + 1) - _bloc.tourPackage.childMinAge
                : 0,
            onAgreeClicked: (index) {
              int newAge = (index - 1) + _bloc.tourPackage.childMinAge;
              if (oldAge == null) {
                _bloc.addChild(value, newAge);
              } else {
                _bloc.updateChild(childIndex!, newAge);
              }
            },
          ),
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context, String messageKey) {
    OtaAlertDialog(
      errorTitle:
          getTranslated(context, AppLocalizationsStrings.unableToProceed),
      errorMessage: getTranslated(context, messageKey),
      buttonTitle: getTranslated(context, AppLocalizationsStrings.ok),
      onPressed: () => Navigator.of(context).pop(),
    ).showAlertDialog(context);
  }

  Widget _buildNoInternetWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _showNoInternetWidget(),
      ],
    );
  }

  Widget _showNoInternetWidget() {
    return Padding(
      padding: kPaddingHori24Vert16,
      child: OtaNetworkErrorWidgetWithRefresh(
        height: MediaQuery.of(context).size.height - _kAppBarHeight,
        onRefresh: () async => _requestTourPackageDetails(),
      ),
    );
  }

  void _showTokenErrorAlert() {
    OtaAlertDialog(
        errorMessage: getTranslated(
            context, AppLocalizationsStrings.infoNotAvailableTryAgain),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        onPressed: () {
          Navigator.of(context).pop();
          //Update price info.
        }).showAlertDialog(context);
  }
}
