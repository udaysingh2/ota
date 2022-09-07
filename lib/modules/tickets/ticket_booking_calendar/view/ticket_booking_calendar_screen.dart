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
import 'package:ota/core_pack/custom_widgets/ota_date_selector/ota_date_picker.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tickets/reservation/bloc/ticket_review_reservation_bloc.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_reservation_view_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_argument.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_model.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/bloc/ticket_booking_calendar_bloc.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_argument.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_view_model.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/widgets/booking_tile_widget.dart';

const int _kMaxLimit = 9;
const int _kMinLimit = 0;
const int _kInitialLimit = 1;
const int _kMaxTicketsAllowedPerReservation = _kMaxLimit;
const double _kAppBarHeight = 89;

class TicketBookingCalenderScreen extends StatefulWidget {
  const TicketBookingCalenderScreen({Key? key}) : super(key: key);

  @override
  State<TicketBookingCalenderScreen> createState() =>
      _TicketBookingCalenderScreenState();
}

class _TicketBookingCalenderScreenState
    extends State<TicketBookingCalenderScreen> {
  final TicketBookingCalendarBloc _bloc = TicketBookingCalendarBloc();
  final TicketReviewReservationBloc _reviewReservationBloc =
      TicketReviewReservationBloc();
  TicketBookingCalendarArgument? bookingArguments;
  TicketReviewReservationArgument? initiateReservationArguments;

  void _requestTicketPackageDetails() {
    OtaDialogLoader().showLoader(context);
    _bloc.getTicketPackageDetails(bookingArguments);
  }

  void _onOkClick(BuildContext context) {
    if (_bloc.totalSelectedTickets > _kMaxTicketsAllowedPerReservation) {
      _showAlertDialog(
          context, AppLocalizationsStrings.maxTicketsExceedPerReservation);
    } else {
      initiateReservationArguments = bookingArguments
          ?.toTicketReviewReservationArgument(_bloc.ticketPackage);
      OtaDialogLoader().showLoader(context);
      _reviewReservationBloc.initiateTicketBooking(initiateReservationArguments,
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
      _bloc.initDetails(bookingArguments!.packageName,
          bookingArguments!.ticketTypes, bookingArguments!.availableSeats);
      _requestTicketPackageDetails();
    });

    _bloc.stream.listen((event) {
      if (_bloc.state.ticketBookingCalendarState ==
          TicketBookingCalendarState.failureNetwork) {
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
      if (_bloc.state.ticketBookingCalendarState !=
          TicketBookingCalendarState.initial) {
        OtaDialogLoader().hideLoader(context);
      }
      if (_bloc.state.ticketBookingCalendarState ==
          TicketBookingCalendarState.ticketsSoldOut) {
        _showAlertDialog(context, AppLocalizationsStrings.ticketFullyBooked);
      }
      if (_bloc.isValidationSuccess) {
        _bloc.resetValidation();
        Navigator.pushNamed(context, AppRoutes.ticketReservationScreen);
      }
    });

    _reviewReservationBloc.stream.listen((event) {
      OtaDialogLoader().hideLoader(context);
      if (_reviewReservationBloc.state.screenState ==
          TicketReviewReservationScreenState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
      if (_reviewReservationBloc.state.screenState ==
              TicketReviewReservationScreenState.failureToken ||
          _reviewReservationBloc.state.screenState ==
              TicketReviewReservationScreenState.failure) {
        _showTokenErrorAlert();
      } else if (_reviewReservationBloc.state.screenState ==
          TicketReviewReservationScreenState.failureUnavailable) {
        _showAlertDialog(context, AppLocalizationsStrings.ticketFullyBooked);
      } else if (_reviewReservationBloc.state.screenState ==
          TicketReviewReservationScreenState.success) {
        OtaDialogLoader().hideLoader(context);
        Navigator.pushNamed(context, AppRoutes.ticketReservationScreen,
            arguments: TicketReviewReservationModel(
                lastPrice: _bloc.ticketPackage.totalPrice,
                argument: initiateReservationArguments!,
                data: _reviewReservationBloc.state.reservationViewModel!,
                ticketTypes: _bloc.ticketPackage.ticketTypes));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bookingArguments = ModalRoute.of(context)?.settings.arguments
        as TicketBookingCalendarArgument;
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.bookingDetails),
      ),
      body: SafeArea(
        top: false,
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
        _buildNoOfTicketLabel(),
        ..._buildTicketTiles(),
        const SizedBox(
          height: kSize100,
        ),
      ],
    );
  }

  Widget _buildNoPackageWidget(String messageKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCalendar(),
        _buildPackageHeader(),
        _showNoPackageWidget(messageKey),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCalendar(),
        _buildPackageHeader(),
        _showNoPackageWidget(AppLocalizationsStrings.noTicketPackageAvailable),
      ],
    );
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
        onRefresh: () async => _requestTicketPackageDetails(),
      ),
    );
  }

  Widget _showNoPackageWidget(String messageKey) {
    return Padding(
      padding: kPaddingHori24Vert16,
      child: OtaSearchNoResultWidget(
        dividerHeight: kSize0,
        errorTextHeader: getTranslated(context, AppLocalizationsStrings.sorry),
        errorTextFooter: getTranslated(context, messageKey),
      ),
    );
  }

  Widget _buildBottomSection() {
    return BlocBuilder(
        bloc: _bloc,
        builder: () {
          switch (_bloc.state.ticketBookingCalendarState) {
            case TicketBookingCalendarState.initial:
            case TicketBookingCalendarState.success:
              return _buildSuccessWidget();
            case TicketBookingCalendarState.ticketsSoldOut:
            case TicketBookingCalendarState.noTickets:
              return _buildNoPackageWidget(
                  AppLocalizationsStrings.noTicketPackageAvailable);
            case TicketBookingCalendarState.failure:
            case TicketBookingCalendarState.failure1899:
            case TicketBookingCalendarState.failure1999:
              return _buildErrorWidget();
            case TicketBookingCalendarState.failureNetwork:
              return _buildNoInternetWidget();
            default:
              return const SizedBox();
          }
        });
  }

  List<Widget> _buildTicketTiles() {
    List<Widget> tiles = List<Widget>.generate(
        _bloc.ticketPackage.ticketTypes.length,
        (index) => _buildTicketTileWidget(index));
    return tiles;
  }

  Widget _buildTicketTileWidget(int index) {
    return BookingTileWidget(
      title: _bloc.ticketPackage.ticketTypes[index].name,
      price: _bloc.ticketPackage.ticketTypes[index].price,
      currency: bookingArguments?.currency,
      value: _bloc.ticketPackage.ticketTypes[index].ticketCount,
      minValue: _kMinLimit,
      maxValue: _kMaxLimit,
      onValueAdded: (value) => _bloc.updateTickets(value, index),
      onValueRemoved: (value) => _bloc.updateTickets(value, index),
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
          _requestTicketPackageDetails();
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
        _bloc.ticketPackage.packageName,
        style: AppTheme.kBodyRegular,
      ),
    );
  }

  Widget _buildNoOfTicketLabel() {
    final int availableSeats = _bloc.ticketPackage.availableSeats;
    final String availableSeatMessage = getTranslated(
            context, AppLocalizationsStrings.ticketSeatAvailableMessage)
        .replaceAll('#', availableSeats.toString());
    return Padding(
      padding:
          const EdgeInsets.only(left: kSize24, right: kSize24, top: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated(context, AppLocalizationsStrings.noOfTickets),
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
        if (_bloc.state.ticketBookingCalendarState ==
                TicketBookingCalendarState.success ||
            _bloc.state.ticketBookingCalendarState ==
                TicketBookingCalendarState.initial) {
          return OtaBottomButtonBar(
            button1: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  TextSpan(
                    text: currencyUtil
                        .getFormattedPrice(_bloc.ticketPackage.totalPrice)
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
                isDisabled: _bloc.totalSelectedTickets < _kInitialLimit,
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

  void _showAlertDialog(BuildContext context, String messageKey) {
    OtaAlertDialog(
      errorTitle:
          getTranslated(context, AppLocalizationsStrings.unableToProceed),
      errorMessage: getTranslated(context, messageKey),
      buttonTitle: getTranslated(context, AppLocalizationsStrings.ok),
      onPressed: () => Navigator.of(context).pop(),
    ).showAlertDialog(context);
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
