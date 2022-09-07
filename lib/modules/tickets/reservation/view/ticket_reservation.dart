import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tickets_review_reservation_click_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tickets_review_reservation_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_timer.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/reservation_error_widget.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/userdetail_view_model.dart';
import 'package:ota/modules/tickets/confirm_booking/helper/ticket_confirm_booking_helper.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_view_model.dart';
import 'package:ota/modules/tickets/reservation/bloc/ticket_review_reservation_bloc.dart';
import 'package:ota/modules/tickets/reservation/bloc/ticket_traveller_detail_controller.dart';
import 'package:ota/modules/tickets/reservation/helper/ticket_reservation_helper.dart';
import 'package:ota/modules/tickets/reservation/view/widget/get_ticket_details_widget.dart';
import 'package:ota/modules/tickets/reservation/view/widget/ticket_detail_widget.dart';
import 'package:ota/modules/tickets/reservation/view/widget/ticket_package_traveller_detail_widget.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_guest_information_argument_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_reservation_view_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_argument.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/top_detail_section.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/confirm_booking_argument.dart';
import 'package:ota/modules/tours/ota_contact_information/view_model/ota_contact_information_argument_model.dart';
import 'package:ota/modules/tours/reservation/bloc/pickup_point_bloc.dart';
import 'package:ota/modules/tours/reservation/bloc/tours_user_detail_bloc.dart';
import 'package:ota/modules/tours/reservation/helper/tour_expandable_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_additional_information_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_booking_terms_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/drop_off_option_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/package_drop_off_location_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_guest_user_widget/package_guest_user_detail_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_guest_user_widget/package_guest_user_details_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_reservation_details_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_user_details_widget.dart';
import 'package:ota/modules/tours/reservation/view_model/pickup_point_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';

const int _kSecondsInMinute = 60;
const double _kAppBarHeight = 89;
const String _kBackButtonKey = 'back_button_icon_key';
const String _kTotalPriceKey = 'total_Price_key';
const String _kBookNowButtonKey = 'book_now_button_key';
const String _kTicketKey = 'ticket';

class TicketReservationScreen extends StatefulWidget {
  const TicketReservationScreen({Key? key}) : super(key: key);

  @override
  TicketReservationScreenState createState() => TicketReservationScreenState();
}

class TicketReservationScreenState extends State<TicketReservationScreen> {
  final TextEditingController _additionalTextController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final PackageGuestUserDetailController _packageGuestUserDetailController =
      PackageGuestUserDetailController();
  final ToursUserDetailBloc _userDetailBloc = ToursUserDetailBloc();
  final TicketReviewReservationBloc _reviewReservationBloc =
      TicketReviewReservationBloc();
  final OtaCancellationPolicyController _controller =
      OtaCancellationPolicyController();
  final TourExpandableController _detailController = TourExpandableController();
  TicketReviewReservationArgument? initiateReservationArguments;
  TicketReviewReservationModel? _ticketReviewReservationModel;
  final DropOffController _dropOffController = DropOffController();
  late OtaCountDownController _otaCountDownController;
  final OtaRadioButtonBloc _otaRadioButtonBloc = OtaRadioButtonBloc();
  final PickUpPointBloc _pickUpPointBloc = PickUpPointBloc();
  final TicketTravellerController _ticketTravellerController =
      TicketTravellerController();
  FocusNode focusNodeGuestFirstName = FocusNode();
  FocusNode focusNodeGuestLastName = FocusNode();
  FocusNode focusNodeGuestMobileNumber = FocusNode();

  @override
  void initState() {
    super.initState();
    resetPromoData();
    focusNodeGuestFirstName.addListener(() {
      if (!focusNodeGuestFirstName.hasFocus) {
        _packageGuestUserDetailController.checkFirstNameValidation();
        _packageGuestUserDetailController.updateTextState();
      }
    });

    focusNodeGuestLastName.addListener(() {
      if (!focusNodeGuestLastName.hasFocus) {
        _packageGuestUserDetailController.checkLastNameValidation();
        _packageGuestUserDetailController.updateTextState();
      }
    });

    focusNodeGuestMobileNumber.addListener(() {
      if (!focusNodeGuestMobileNumber.hasFocus) {
        _packageGuestUserDetailController.checkMobileNumberValidation();
        _packageGuestUserDetailController.updateTextState();
      }
    });
    _otaCountDownController = OtaCountDownController(
        durationInSecond:
            AppConfig().configModel.timerValue * _kSecondsInMinute,
        onComplete: () {
          _showTimeoutAlert();
        });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.ticketReservationEvent);
      AppFlyerHelper.startCapturingEvent(
          AppFlyerEvent.ticketReservationClickEvent);
      _ticketReviewReservationModel = ModalRoute.of(context)?.settings.arguments
          as TicketReviewReservationModel;
      initiateReservationArguments = _ticketReviewReservationModel!.argument;
      _getUserDetail();
      _pickUpPointBloc
          .getPickUpPointDetail(initiateReservationArguments!.zoneId);
      _reviewReservationBloc.initDetails(_ticketReviewReservationModel!.data);
      _userDetailBloc.stream.listen((event) {
        if (_userDetailBloc.state.userDetailViewModelDataState ==
            UserDetailViewModelDataState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        } else {
          validateData();
          _publishAppFlyerData();
        }
      });
      _reviewReservationBloc.stream.listen((event) {
        if (_reviewReservationBloc.state.screenState ==
            TicketReviewReservationScreenState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
        validateData();
        _publishAppFlyerData();
      });
    });
    _handleSomeoneElseInfo();
  }

  void resetPromoData() {
    Provider.of<PromoWidgetViewModel>(context, listen: false)
        .setPromoWidgetViewModelData(PromoWidgetViewModel());
  }

  void validateData() {
    if (_reviewReservationBloc.isValidationRequired &&
        _userDetailBloc.state.userDetailViewModelDataState ==
            UserDetailViewModelDataState.loaded) {
      if (_isTokenExpired()) {
        _showTokenErrorAlert();
      } else if (_isPackageUnAvailable()) {
        _showPackageUnavailableAlert();
      } else if (_isPackagePriceChanged()) {
        _showPriceChangeAlert();
      } else {
        _otaCountDownController.startTimer();
      }
    }
  }

  _getUserDetail({bool isRefresh = false}) async {
    UserDetailViewModel? userInfo =
        await _userDetailBloc.getUserDetails(isRefresh: isRefresh);
    if (userInfo != null) {
      _ticketTravellerController.setFirstGuestInfo(
        TicketGuestInformationData(
          guestFirstName: userInfo.firstName,
          guestLastName: userInfo.secondName,
          guestMobileNumber: userInfo.mobileNumber,
          guestEmail: userInfo.email,
        ),
      );
    }
  }

  void _refreshReviewPage({isRefresh = false}) {
    resetPromoData();
    if (!isRefresh) {
      initiateReservationArguments = TicketReservationHelper.updateArgument(
          initiateReservationArguments,
          _reviewReservationBloc
              .state.reservationViewModel!.ticketPackage!.ticketTypeList!);
      initiateReservationArguments?.price =
          _reviewReservationBloc.state.reservationViewModel!.totalPrice;
    }
    _reviewReservationBloc.initiateTicketBooking(initiateReservationArguments,
        isRefresh: isRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _otaCountDownController.cancelTimer();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.kLight100,
        appBar: OtaAppBar(
          title:
              getTranslated(context, AppLocalizationsStrings.ticketReservation),
          titleColor: AppColors.kGrey70,
          key: const Key(_kBackButtonKey),
        ),
        body: BlocBuilder(
            bloc: _userDetailBloc,
            builder: () {
              switch (_userDetailBloc.state.userDetailViewModelDataState) {
                case UserDetailViewModelDataState.loaded:
                  return getSuccessReviewWidget();
                case UserDetailViewModelDataState.initial:
                  return _defaultWidget();
                case UserDetailViewModelDataState.loading:
                  return _loadIngWidget();
                case UserDetailViewModelDataState.failed:
                case UserDetailViewModelDataState.internetFailure:
                  return _failureState();
              }
            }),
      ),
    );
  }

  @override
  void dispose() {
    _otaCountDownController.dispose();
    _userDetailBloc.dispose();
    _reviewReservationBloc.dispose();
    _additionalTextController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  Widget getSuccessReviewWidget() {
    return BlocBuilder(
        bloc: _reviewReservationBloc,
        builder: () {
          switch (_reviewReservationBloc.state.screenState) {
            case TicketReviewReservationScreenState.success:
              return successWidget();
            case TicketReviewReservationScreenState.none:
              return _defaultWidget();
            case TicketReviewReservationScreenState.loading:
              return _loadIngWidget();
            case TicketReviewReservationScreenState.failure:
            case TicketReviewReservationScreenState.failureToken:
            case TicketReviewReservationScreenState.failureUnavailable:
            case TicketReviewReservationScreenState.internetFailure:
              return _failureReviewState();
          }
        });
  }

  Widget _defaultWidget() {
    return const SizedBox();
  }

  Widget _loadIngWidget() {
    return const OTALoadingIndicator();
  }

  Widget _failureReviewState() {
    return ReservationErrorWidget(
      height: MediaQuery.of(context).size.height - _kAppBarHeight,
      onRefresh: () async => _refreshReviewPage(isRefresh: true),
    );
  }

  Widget _failureState() {
    return ReservationErrorWidget(
        height: MediaQuery.of(context).size.height - _kAppBarHeight,
        onRefresh: () async => _getUserDetail(isRefresh: true));
  }

  Widget successWidget() {
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: (kSize100 + bottomPadding)),
            child: ListView(
              padding: const EdgeInsets.only(top: kSize54),
              children: <Widget>[
                _getReservationTicketInfo(),
                _getExpandTicketDetailSection(),
                _getReservationDetails(),
                _getTicketDetails(),
                _getPromotionTagWidget(),
                _getPackageBookingTerms(),
                _getAdditionalNeedsWidget(),
                _getDropOffLocation(),
                _getUserName(),
                _getGuestUserWidget(),
                if (_reviewReservationBloc.shouldShowTicketHoldersInfoSection())
                  _getTicketTravellersDetails(),
              ],
            ),
          ),
          _getBottomBar(),
          OtaCountDownTimer(
            controller: _otaCountDownController,
          ),
        ],
      ),
    );
  }

  Widget _getReservationTicketInfo() {
    TicketReviewReservationViewModel reservationViewModel =
        _reviewReservationBloc.state.reservationViewModel!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated(context, AppLocalizationsStrings.yourReservation),
            style: AppTheme.kHeading1Medium,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: kSize16),
          OtaTopDetailsSection(
            title: reservationViewModel.ticketName,
            imageUrl: reservationViewModel.ticketImage,
            serviceType: _kTicketKey,
            categoryLocation: reservationViewModel.location,
            categoryName: reservationViewModel.category,
          ),
          const SizedBox(height: kSize8),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ],
      ),
    );
  }

  Widget _getExpandTicketDetailSection() {
    TicketReviewReservationViewModel reservationViewModel =
        _reviewReservationBloc.state.reservationViewModel!;
    return TicketDetailWidget(
      controller: _detailController,
      title: reservationViewModel.ticketPackage!.name,
      facilityMap: reservationViewModel.ticketPackage!.ticketHighlights,
      ticketType: reservationViewModel.ticketPackage!.ticketTypeList!,
    );
  }

  Widget _getReservationDetails() {
    return PackageReservationDetailWidget(
      packageDate: Helpers().parseDateTime(Helpers.getYYYYmmddFromDateTime(
          _ticketReviewReservationModel!.argument.bookingDate)),
      activityDuration: _reviewReservationBloc
          .state.reservationViewModel!.ticketPackage!.durationText,
    );
  }

  Widget _getTicketDetails() {
    return GetTicketDetailsWidget(
      ticketList: _reviewReservationBloc
          .state.reservationViewModel!.ticketPackage!.ticketTypeList!,
    );
  }

  Widget _getPromotionTagWidget() {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList =
        _reviewReservationBloc.state.reservationViewModel?.promotionData ?? [];
    if (freeFoodPromotionList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSize24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kSize24),
            Text(
              getTranslated(
                  context, AppLocalizationsStrings.robinhoodSpecialOffer),
              style: AppTheme.kHeading1Medium,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: kSize16),
            OtaFreeFoodBannerWidget(
                freeFoodPromotionList: freeFoodPromotionList),
            const SizedBox(height: kSize24),
            const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _getPackageBookingTerms() {
    TicketPackageViewModel package =
        _reviewReservationBloc.state.reservationViewModel!.ticketPackage!;
    return PackageBookingTermsWidget(
      controller: _controller,
      cancellationStatus: package.cancellationHeader,
      bookingTermsList: TicketReservationHelper.getCancellationPolicy(
          context,
          package.cancellationPolicy,
          AppConfig().configModel.ticketCancellationPercent),
    );
  }

  Widget _getAdditionalNeedsWidget() {
    return PackageAdditionalInformationWidget(
        placeholder: AppLocalizationsStrings.ticketAdditionalRequestPlaceholder,
        subtitle: AppLocalizationsStrings.ticketAdditionalRequest,
        controller: _additionalTextController);
  }

  Widget _getDropOffLocation() {
    return BlocBuilder(
        bloc: _pickUpPointBloc,
        builder: () {
          if (_pickUpPointBloc.state.pageState != PickupPointState.success) {
            return const SizedBox();
          }
          return PackageDropOffLocationWidget(
            dropOffController: _dropOffController,
            labelList: _pickUpPointBloc.state.pickUpPoints!,
          );
        });
  }

  Widget _getUserName() {
    return BlocBuilder(
        bloc: _otaRadioButtonBloc,
        builder: () {
          return PackageUserDetailsWidget(
            onTitleArrowClick: _openTicketContactInformationPage,
            firstName: _userDetailBloc.state.firstName,
            lastName: _userDetailBloc.state.secondName,
            mobileNumber: _userDetailBloc.state.mobileNumber,
            isBookForSomeoneElse:
                _otaRadioButtonBloc.state.otaRadioButtonState ==
                    OtaRadioButtonState.selected,
          );
        });
  }

  Widget _getGuestUserWidget() {
    return PackageGuestUserDetailWidget(
      firstNameController: _firstNameController,
      lastNameController: _lastNameController,
      mobileNumberController: _mobileNumberController,
      guestFirstName: focusNodeGuestFirstName,
      guestLastName: focusNodeGuestLastName,
      guestMobileNumber: focusNodeGuestMobileNumber,
      packageGuestUserDetailController: _packageGuestUserDetailController,
      onRadioBtnClicked: () {
        if (_otaRadioButtonBloc.state.otaRadioButtonState ==
            OtaRadioButtonState.unselected) {
          _otaRadioButtonBloc.select();
        } else {
          _otaRadioButtonBloc.unSelect();
        }
        _setFirstGuestInfo();
      },
    );
  }

  _handleSomeoneElseInfo() {
    _firstNameController.addListener(() {
      _setFirstGuestInfo();
    });
    _lastNameController.addListener(() {
      _setFirstGuestInfo();
    });
    _mobileNumberController.addListener(() {
      _setFirstGuestInfo();
    });
  }

  _setFirstGuestInfo() {
    if (_otaRadioButtonBloc.state.otaRadioButtonState ==
        OtaRadioButtonState.selected) {
      String firstName = _firstNameController.text.trim();
      String secondName = _lastNameController.text.trim();
      String mobileNumber = _mobileNumberController.text.trim();

      if (firstName.isNotEmpty || secondName.isNotEmpty) {
        TicketGuestInformationData guestInfo = TicketGuestInformationData(
          guestFirstName: firstName,
          guestLastName: secondName,
          guestMobileNumber: mobileNumber,
        );
        _ticketTravellerController.setFirstGuestInfo(guestInfo);
      }
    } else {
      TicketGuestInformationData guestInfo = TicketGuestInformationData(
        guestFirstName: _userDetailBloc.state.firstName,
        guestLastName: _userDetailBloc.state.secondName,
        guestMobileNumber: _userDetailBloc.state.mobileNumber,
        guestEmail: _userDetailBloc.state.email,
      );
      _ticketTravellerController.setFirstGuestInfo(guestInfo);
    }
  }

  Widget _getTicketTravellersDetails() {
    bool isAllNameRequired = _reviewReservationBloc
            .state.reservationViewModel?.ticketPackage?.requireInfo?.allName ??
        false;
    return BlocBuilder(
      bloc: (_otaRadioButtonBloc),
      builder: () {
        return TicketPackageTravellerDetailWidget(
          ticketCount: isAllNameRequired
              ? _reviewReservationBloc
                  .state.reservationViewModel!.totalSelectedTicket
              : 1,
          ticketTravellerController: _ticketTravellerController,
          ticketRequireInfoViewModel: _reviewReservationBloc
              .state.reservationViewModel?.ticketPackage?.requireInfo,
        );
      },
    );
  }

  Widget _getBottomBar() {
    CurrencyUtil currencyUtil = CurrencyUtil(
        currency: _reviewReservationBloc
            .state.reservationViewModel!.ticketPackage?.currency);
    return BlocBuilder(
        bloc: _pickUpPointBloc,
        builder: () {
          return BlocBuilder(
              bloc: _dropOffController,
              builder: () {
                return BlocBuilder(
                  bloc: _otaRadioButtonBloc,
                  builder: () {
                    return BlocBuilder(
                      bloc: _ticketTravellerController,
                      builder: () {
                        return OtaBottomButtonBar(
                          button1: RichText(
                            key: const Key(_kTotalPriceKey),
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyText1,
                              children: <TextSpan>[
                                TextSpan(
                                    text: currencyUtil
                                        .getFormattedPrice(
                                            _reviewReservationBloc
                                                .state
                                                .reservationViewModel!
                                                .totalPrice)
                                        .addNextLine(),
                                    style: AppTheme.kHeading1Medium),
                                TextSpan(
                                  text: getTranslated(
                                      context, AppLocalizationsStrings.total),
                                  style: AppTheme.kSmallRegular
                                      .copyWith(color: AppColors.kGrey50),
                                )
                              ],
                            ),
                          ),
                          button2: Container(
                            constraints: const BoxConstraints(
                                maxWidth: kSize150, minWidth: kSize100),
                            child: OtaTextButton(
                              textHorizontalPadding: kSize10,
                              title: getTranslated(
                                  context, AppLocalizationsStrings.confirm),
                              key: const Key(_kBookNowButtonKey),
                              isDisabled: _checkPayNowButtonValidity(),
                              onPressed: () {
                                if (_packageGuestUserDetailController
                                    .isValidationSuccess()) {
                                  AppFlyerHelper.stopCapturingEvent(
                                      AppFlyerEvent
                                          .ticketReservationClickEvent);
                                  _openTicketPaymentPage();
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              });
        });
  }

  bool _checkPayNowButtonValidity() {
    if (_packageGuestUserDetailController
            .state.otaRadioButtonBloc?.state.otaRadioButtonState ==
        OtaRadioButtonState.selected) {
      bool isSomeoneForElseInfoInvalid =
          _packageGuestUserDetailController.isValidationConfirmed();
      if (!isSomeoneForElseInfoInvalid) {
        return true;
      }
    } else {
      String firstName = _userDetailBloc.state.firstName;
      String secondName = _userDetailBloc.state.secondName;

      bool isGuestInfoInvalid = firstName.isEmpty ||
          secondName.isEmpty ||
          kInvalidNameFormatter.hasMatch(secondName) ||
          kInvalidNameFormatter.hasMatch(firstName);
      if (isGuestInfoInvalid) {
        return true;
      }
    }
    if (_reviewReservationBloc.shouldShowTicketHoldersInfoSection()) {
      bool isAllNameRequired = _reviewReservationBloc.state.reservationViewModel
              ?.ticketPackage?.requireInfo?.allName ??
          false;
      bool isAllTicketHoldersInfoValid =
          _ticketTravellerController.isAllTicketHoldersInfoValid(
        ticketCount: isAllNameRequired
            ? _reviewReservationBloc
                .state.reservationViewModel!.totalSelectedTicket
            : 1,
        ticketRequireInfoViewModel: _reviewReservationBloc
            .state.reservationViewModel?.ticketPackage?.requireInfo,
      );
      if (!isAllTicketHoldersInfoValid) {
        return true;
      }
    }
    if ((_pickUpPointBloc.state.pageState == PickupPointState.success &&
            _dropOffController.state.chosenOption == -1) ||
        _pickUpPointBloc.state.pageState == PickupPointState.none) {
      return true;
    }
    return false;
  }

  void _openTicketContactInformationPage() {
    Navigator.pushNamed(
      context,
      AppRoutes.otaContactInformationFormPage,
      arguments: OtaContactInformationArgumentModel(
          initialContactInformationArgumentData:
              OtaContactInformationArgumentData(
            firstName: _userDetailBloc.state.firstName,
            email: _userDetailBloc.state.email,
            phoneNumber: _userDetailBloc.state.mobileNumber,
            lastName: _userDetailBloc.state.secondName,
          ),
          onOkClicked: (updatedContactInformationArgumentData) {
            _userDetailBloc.updateUserData(
              firstName: updatedContactInformationArgumentData.firstName,
              lastName: updatedContactInformationArgumentData.lastName,
            );
            _setFirstGuestInfo();
          },
          fromScreen: _kTicketKey),
    );
  }

  bool _isTokenExpired() {
    return _reviewReservationBloc.state.screenState ==
        TicketReviewReservationScreenState.failureToken;
  }

  bool _isPackagePriceChanged() {
    return _reviewReservationBloc.state.reservationViewModel!.lastPrice !=
        _reviewReservationBloc.state.reservationViewModel!.totalPrice;
  }

  bool _isPackageUnAvailable() {
    return _reviewReservationBloc.state.screenState ==
        TicketReviewReservationScreenState.failureUnavailable;
  }

  void _showTimeoutAlert() {
    OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.timerTimeOutMessage),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        useRootNavigator: false,
        onPressed: () {
          Navigator.pop(context);
          Navigator.popUntil(
              context,
              (route) =>
                  route.settings.name == AppRoutes.ticketReservationScreen);
          _otaCountDownController.resetTimer();
          _refreshReviewPage();
        }).showAlertDialog(context);
  }

  void _showPackageUnavailableAlert() {
    _otaCountDownController.stopTimer();
    OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.ticketFullyBooked),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.popUntil(context,
              (route) => route.settings.name == AppRoutes.ticketDetailScreen);
        }).showAlertDialog(context);
  }

  void _showPriceChangeAlert() {
    _otaCountDownController.stopTimer();
    OtaAlertDialog(
        errorMessage: getTranslated(
            context, AppLocalizationsStrings.ticketPackagePriceChangeMessage),
        errorTitle: getTranslated(
            context, AppLocalizationsStrings.tourPackagePriceChange),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        onPressed: () {
          Navigator.of(context).pop();
          _otaCountDownController.startTimer();
          //Update price info.
        }).showAlertDialog(context);
  }

  void _showTokenErrorAlert() {
    _otaCountDownController.stopTimer();
    OtaAlertDialog(
        errorMessage: getTranslated(
            context, AppLocalizationsStrings.infoNotAvailableTryAgain),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          //Update price info.
        }).showAlertDialog(context);
  }

  ConfirmBookingArgument _getArguments() {
    ConfirmBookingArgument argument =
        TicketConfirmBookingHelper.getTicketConfirmBookingArgument(
      isAdditionalGuestAvialable:
          _reviewReservationBloc.shouldShowTicketHoldersInfoSection(),
      reservationViewModel: _reviewReservationBloc.state.reservationViewModel!,
      additionalRequest: _additionalTextController.text,
      tourPickup: (_pickUpPointBloc.state.pageState == PickupPointState.success)
          ? Pickup(
              name: _pickUpPointBloc.state
                  .pickUpPoints![_dropOffController.state.chosenOption].name,
              id: _reviewReservationBloc
                  .state.reservationViewModel!.ticketPackage!.zoneId!)
          : null,
      userDetailViewModel: _userDetailBloc.state,
      isBookingForSomeoneElse: _otaRadioButtonBloc.state.otaRadioButtonState ==
          OtaRadioButtonState.selected,
      guestInformationList: TicketConfirmBookingHelper.getGuestInformationList(
        guestDataMap:
            _ticketTravellerController.state.ticketGuestInformationList,
        isMapingForAll:
            _reviewReservationBloc.shouldShowTicketHoldersInfoSection(),
        ticketCount: _reviewReservationBloc
            .state.reservationViewModel!.totalSelectedTicket,
      ),
    );
    return argument;
  }

  void _openTicketPaymentPage() {
    Navigator.pushNamed(
      context,
      AppRoutes.ticketConfirmBookingScreen,
      arguments: TicketConfirmBookingArgumentModel(
          argument: _getArguments(),
          otaCountDownController: _otaCountDownController),
    );
  }

  void _getAppFlyerData() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketReservationEvent,
        key: TicketReservationAppFlyer.ticketPlaceId,
        value: _ticketReviewReservationModel?.argument.ticketId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketReservationEvent,
        key: TicketReservationAppFlyer.ticketActivityId,
        value: _ticketReviewReservationModel?.argument.ticketId);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.ticketReservationEvent,
        key: TicketReservationAppFlyer.ticketCurrency);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.ticketReservationEvent);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketReservationEvent,
        key: TicketReservationAppFlyer.ticketLocation,
        value: _reviewReservationBloc.state.reservationViewModel?.location);
    _getAppFlyerDefaultTicketTypes();
    _getAppFlyerTicketTypes(_reviewReservationBloc
        .state.reservationViewModel?.ticketPackage?.ticketTypeList);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketReservationEvent,
        key: TicketReservationAppFlyer.ticketContentId,
        value: _ticketReviewReservationModel?.argument.ticketId);
    AppFlyerHelper.addContentType(
        eventName: AppFlyerEvent.ticketReservationEvent,
        key: TicketReservationAppFlyer.ticketContentType);

    //adding parameters for the other event
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketReservationClickEvent,
        key: TicketReservationClickAppFlyer.ticketPlaceId,
        value: _ticketReviewReservationModel?.argument.ticketId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketReservationClickEvent,
        key: TicketReservationClickAppFlyer.ticketActivityId,
        value: _ticketReviewReservationModel?.argument.ticketId);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.ticketReservationClickEvent,
        key: TicketReservationClickAppFlyer.ticketCurrency);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.ticketReservationClickEvent);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketReservationClickEvent,
        key: TicketReservationClickAppFlyer.ticketLocation,
        value: _reviewReservationBloc.state.reservationViewModel?.location);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketReservationClickEvent,
        key: TicketReservationClickAppFlyer.ticketContentId,
        value: _ticketReviewReservationModel?.argument.ticketId);
    AppFlyerHelper.addContentType(
        eventName: AppFlyerEvent.ticketReservationClickEvent,
        key: TicketReservationClickAppFlyer.ticketContentType);
  }

  void _getAppFlyerTicketTypes(List<TicketTypeViewModel>? ticketTypeList) {
    int ticketQuantity = 0;
    if (ticketTypeList == null) {
      return;
    } else if (ticketTypeList.isEmpty) {
      return;
    } else {
      for (int i = 0; i < ticketTypeList.length; i++) {
        if (i == 0) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketReservationEvent,
              key: TicketReservationAppFlyer.ticketPaxAQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketReservationEvent,
              key: TicketReservationAppFlyer.ticketPaxAPerPrice,
              value: ticketTypeList[i].price);

          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketReservationClickEvent,
              key: TicketReservationClickAppFlyer.ticketPaxAQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketReservationClickEvent,
              key: TicketReservationClickAppFlyer.ticketPaxAPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        } else if (i == 1) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketReservationEvent,
              key: TicketReservationAppFlyer.ticketPaxBQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketReservationEvent,
              key: TicketReservationAppFlyer.ticketPaxBPerPrice,
              value: ticketTypeList[i].price);

          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketReservationClickEvent,
              key: TicketReservationClickAppFlyer.ticketPaxBQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketReservationClickEvent,
              key: TicketReservationClickAppFlyer.ticketPaxBPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        } else if (i == 2) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketReservationEvent,
              key: TicketReservationAppFlyer.ticketPaxCQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketReservationEvent,
              key: TicketReservationAppFlyer.ticketPaxCPerPrice,
              value: ticketTypeList[i].price);

          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketReservationClickEvent,
              key: TicketReservationClickAppFlyer.ticketPaxCQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketReservationClickEvent,
              key: TicketReservationClickAppFlyer.ticketPaxCPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        } else if (i == 3) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketReservationEvent,
              key: TicketReservationAppFlyer.ticketPaxDQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketReservationEvent,
              key: TicketReservationAppFlyer.ticketPaxDPerPrice,
              value: ticketTypeList[i].price);

          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketReservationClickEvent,
              key: TicketReservationClickAppFlyer.ticketPaxDQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketReservationClickEvent,
              key: TicketReservationClickAppFlyer.ticketPaxDPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        }
      }
      AppFlyerHelper.addIntValue(
          eventName: AppFlyerEvent.ticketReservationEvent,
          key: TicketReservationAppFlyer.ticketTotalQuantity,
          value: ticketQuantity);
      AppFlyerHelper.addIntValue(
          eventName: AppFlyerEvent.ticketReservationClickEvent,
          key: TicketReservationClickAppFlyer.ticketTotalQuantity,
          value: ticketQuantity);
    }
  }

  void _getAppFlyerDefaultTicketTypes() {
    for (int i = 0; i < 4; i++) {
      if (i == 0) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketReservationEvent,
            key: TicketReservationAppFlyer.ticketPaxAQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketReservationEvent,
            key: TicketReservationAppFlyer.ticketPaxAPerPrice,
            value: 0.0);

        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketReservationClickEvent,
            key: TicketReservationClickAppFlyer.ticketPaxAQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketReservationClickEvent,
            key: TicketReservationClickAppFlyer.ticketPaxAPerPrice,
            value: 0.0);
      } else if (i == 1) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketReservationEvent,
            key: TicketReservationAppFlyer.ticketPaxBQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketReservationEvent,
            key: TicketReservationAppFlyer.ticketPaxBPerPrice,
            value: 0.0);

        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketReservationClickEvent,
            key: TicketReservationClickAppFlyer.ticketPaxBQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketReservationClickEvent,
            key: TicketReservationClickAppFlyer.ticketPaxBPerPrice,
            value: 0.0);
      } else if (i == 2) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketReservationEvent,
            key: TicketReservationAppFlyer.ticketPaxCQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketReservationEvent,
            key: TicketReservationAppFlyer.ticketPaxCPerPrice,
            value: 0.0);

        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketReservationClickEvent,
            key: TicketReservationClickAppFlyer.ticketPaxCQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketReservationClickEvent,
            key: TicketReservationClickAppFlyer.ticketPaxCPerPrice,
            value: 0.0);
      } else if (i == 3) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketReservationEvent,
            key: TicketReservationAppFlyer.ticketPaxDQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketReservationEvent,
            key: TicketReservationAppFlyer.ticketPaxDPerPrice,
            value: 0.0);

        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketReservationClickEvent,
            key: TicketReservationClickAppFlyer.ticketPaxDQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketReservationClickEvent,
            key: TicketReservationClickAppFlyer.ticketPaxDPerPrice,
            value: 0.0);
      }
    }
  }

  void _publishAppFlyerData() {
    if (_reviewReservationBloc.state.screenState ==
            TicketReviewReservationScreenState.success &&
        _userDetailBloc.state.userDetailViewModelDataState ==
            UserDetailViewModelDataState.loaded) {
      _getAppFlyerData();
      AppFlyerHelper.stopCapturingEvent(AppFlyerEvent.ticketReservationEvent);
    }
  }
}
