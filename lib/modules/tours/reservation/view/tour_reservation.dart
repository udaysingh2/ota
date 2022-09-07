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
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_payment_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_payment_success_first_order_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_payment_success_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_review_reservation_click_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_review_reservation_parameters.dart';
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
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_payment_error_payment_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_payment_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_review_reservation_click_parameters.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/reservation_error_widget.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/userdetail_view_model.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/top_detail_section.dart';
import 'package:ota/modules/tours/confirm_booking/helper/tour_booking_confirm_helper.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/confirm_booking_argument.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_model.dart';
import 'package:ota/modules/tours/ota_contact_information/view_model/ota_contact_information_argument_model.dart';
import 'package:ota/modules/tours/reservation/bloc/pickup_point_bloc.dart';
import 'package:ota/modules/tours/reservation/bloc/tours_review_reservation_bloc.dart';
import 'package:ota/modules/tours/reservation/bloc/tours_user_detail_bloc.dart';
import 'package:ota/modules/tours/reservation/bloc/traveller_detail_controller.dart';
import 'package:ota/modules/tours/reservation/helper/tour_expandable_controller.dart';
import 'package:ota/modules/tours/reservation/helper/tour_reservation_helper.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_additional_information_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_booking_terms_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/drop_off_option_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/package_drop_off_location_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_guest_user_widget/package_guest_user_detail_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_guest_user_widget/package_guest_user_details_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_reservation_details_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_traveller_detail_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_user_details_widget.dart';
import 'package:ota/modules/tours/reservation/view/widget/tour_detail_widget.dart';
import 'package:ota/modules/tours/reservation/view_model/guest_information_argument_model.dart';
import 'package:ota/modules/tours/reservation/view_model/pickup_point_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tours_review_reservation_argument.dart';
import 'package:ota/modules/tours/reservation/view_model/tours_review_reservation_model.dart';
import 'package:provider/provider.dart';

const int _kSecondsInMinute = 60;
const double _kAppBarHeight = 89;
const String _kBackButtonKey = 'back_button_icon_key';
const String _kTotalPriceKey = 'total_Price_key';
const String _kbookNowButtonKey = 'book_now_button_key';
const String _kTourKey = 'tour';
const String _kServiceType = 'Tour';

class TourReservationScreen extends StatefulWidget {
  const TourReservationScreen({Key? key}) : super(key: key);

  @override
  TourReservationScreenState createState() => TourReservationScreenState();
}

class TourReservationScreenState extends State<TourReservationScreen> {
  final TextEditingController _additionalTextController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final OtaCancellationPolicyController _controller =
      OtaCancellationPolicyController();
  final TourExpandableController _detailController = TourExpandableController();
  final PackageGuestUserDetailController _packageGuestUserDetailController =
      PackageGuestUserDetailController();
  final ToursUserDetailBloc _userDetailBloc = ToursUserDetailBloc();
  final TourReviewReservationBloc _reviewReservationBloc =
      TourReviewReservationBloc();
  TourReviewReservationArgument? initiateReservationArguments;
  TourReviewReservationModel? _tourReviewReservationModel;
  final DropOffController _dropOffController = DropOffController();
  late OtaCountDownController _otaCountDownController;
  final OtaRadioButtonBloc _otaRadioButtonBloc = OtaRadioButtonBloc();
  final PickUpPointBloc _pickUpPointBloc = PickUpPointBloc();
  final TravellerController _travellerController = TravellerController();
  Map<String, GuestInformationData?> guestInformationMap = {"adult1": null};
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
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.tourPaymentEvent);
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.tourPaymentSuccessEvent);
      AppFlyerHelper.startCapturingEvent(
          AppFlyerEvent.tourPaymentSuccessFirstBookingEvent);
      _tourReviewReservationModel = ModalRoute.of(context)?.settings.arguments
          as TourReviewReservationModel;
      initiateReservationArguments = _tourReviewReservationModel!.argument;
      _getUserDetail();
      _pickUpPointBloc
          .getPickUpPointDetail(initiateReservationArguments!.zoneId);
      _reviewReservationBloc
          .initDetails(_tourReviewReservationModel!.reviewReservationData);
      _userDetailBloc.stream.listen((event) {
        if (_userDetailBloc.state.userDetailViewModelDataState ==
            UserDetailViewModelDataState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        } else {
          _validateData();
          _publishAppFlyerData();
        }
      });
      _reviewReservationBloc.stream.listen((event) {
        if (_reviewReservationBloc.state.screenState ==
            TourReviewReservationScreenState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
        _validateData();
        _publishAppFlyerData();
      });
    });
    _handleSomeoneElseInfo();
  }

  void _validateData() {
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
      _travellerController.setFirstGuestInfo(
        GuestInformationData(
          paxId: _reviewReservationBloc
              .state.reservationViewModel!.tourPackage!.adultPaxId,
          guestFirstName: userInfo.firstName,
          guestLastName: userInfo.secondName,
          guestMobileNumber: userInfo.mobileNumber,
          guestEmail: userInfo.email,
        ),
      );
    }
  }

  void resetPromoData() {
    Provider.of<PromoWidgetViewModel>(context, listen: false)
        .setPromoWidgetViewModelData(PromoWidgetViewModel());
  }

  void _refreshReviewPage({isRefresh = false}) {
    resetPromoData();
    _tourReviewReservationModel!.argument.totalPrice =
        _reviewReservationBloc.state.reservationViewModel!.totalPrice;
    _reviewReservationBloc.initiateTourBooking(initiateReservationArguments,
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
          title: getTranslated(
              context, AppLocalizationsStrings.activityReservation),
          titleColor: AppColors.kGrey70,
          key: const Key(_kBackButtonKey),
        ),
        body: BlocBuilder(
            bloc: _userDetailBloc,
            builder: () {
              switch (_userDetailBloc.state.userDetailViewModelDataState) {
                case UserDetailViewModelDataState.loaded:
                  return _getSuccessReviewWidget();
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

  Widget _getSuccessReviewWidget() {
    return BlocBuilder(
      bloc: _reviewReservationBloc,
      builder: () {
        switch (_reviewReservationBloc.state.screenState) {
          case TourReviewReservationScreenState.success:
            return _successWidget();
          case TourReviewReservationScreenState.none:
            return _defaultWidget();
          case TourReviewReservationScreenState.loading:
            return _loadIngWidget();
          case TourReviewReservationScreenState.failure:
          case TourReviewReservationScreenState.failureToken:
          case TourReviewReservationScreenState.failureUnavailable:
          case TourReviewReservationScreenState.failureMinimumLimit:
          case TourReviewReservationScreenState.internetFailure:
            return _failureReviewState();
        }
      },
    );
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
      onRefresh: () async => _getUserDetail(isRefresh: true),
    );
  }

  Widget _successWidget() {
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
                _getReservationRoomInfo(),
                _getTourDetails(),
                _getReservationDetails(),
                _getPromotionTagWidget(),
                _getPackageBookingTerms(),
                _getAdditionalNeedsWidget(),
                _getDropOffLocation(),
                _getUserName(),
                _getGuestUserWidget(),
                if (_reviewReservationBloc.isTravellersDetailsRequired())
                  _getTravellersDetails(),
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

  Widget _getReservationRoomInfo() {
    TourReviewReservationViewModel tourBooking =
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
            title: tourBooking.tourName,
            imageUrl: tourBooking.tourImage,
            serviceType: _kTourKey,
            categoryLocation: tourBooking.location,
            categoryName: tourBooking.category,
          ),
          const SizedBox(height: kSize8),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ],
      ),
    );
  }

  Widget _getTourDetails() {
    TourReviewReservationViewModel tourBooking =
        _reviewReservationBloc.state.reservationViewModel!;
    return TourDetailWidget(
      controller: _detailController,
      title: tourBooking.tourPackage!.packageName,
      childCount: tourBooking.childCount,
      childInfo: tourBooking.tourPackage!.childInfo,
      facilityMap: tourBooking.tourPackage!.highlights,
      adultPricePerNight: tourBooking.tourPackage!.adultPrice,
      childrenPricePerNight: tourBooking.tourPackage!.childPrice,
    );
  }

  Widget _getReservationDetails() {
    TourReviewReservationViewModel reservationViewModel =
        _reviewReservationBloc.state.reservationViewModel!;
    return PackageReservationDetailWidget(
      packageDate: Helpers().parseDateTime(
        Helpers.getYYYYmmddFromDateTime(
            _tourReviewReservationModel!.argument.bookingDate),
      ),
      numberOfAdults: reservationViewModel.adultCount,
      numberOfChildren: reservationViewModel.childCount,
      numberOfDays: reservationViewModel.tourPackage?.numberOfDays,
      activityDuration: reservationViewModel.tourPackage?.durationText,
    );
  }

  Widget _getPromotionTagWidget() {
    if (_reviewReservationBloc.state.reservationViewModel?.promotionData !=
            null &&
        _reviewReservationBloc
            .state.reservationViewModel!.promotionData.isNotEmpty) {
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
              freeFoodPromotionList: _reviewReservationBloc
                  .state.reservationViewModel!.promotionData,
            ),
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
    TourPackageViewModel? package =
        _reviewReservationBloc.state.reservationViewModel!.tourPackage;
    return PackageBookingTermsWidget(
      controller: _controller,
      cancellationStatus: package?.cancellationHeader,
      bookingTermsList: TourReservationHelper.getCancellationPolicy(
          context,
          package?.cancellationPolicy,
          AppConfig().configModel.tourCancellationPercent),
    );
  }

  Widget _getAdditionalNeedsWidget() {
    return PackageAdditionalInformationWidget(
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
      },
    );
  }

  Widget _getUserName() {
    return BlocBuilder(
      bloc: _otaRadioButtonBloc,
      builder: () {
        return PackageUserDetailsWidget(
          onTitleArrowClick: _openTourContactInformationPage,
          firstName: _userDetailBloc.state.firstName,
          lastName: _userDetailBloc.state.secondName,
          mobileNumber: _userDetailBloc.state.mobileNumber,
          isBookForSomeoneElse: _otaRadioButtonBloc.state.otaRadioButtonState ==
              OtaRadioButtonState.selected,
        );
      },
    );
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
        GuestInformationData guestInfo = GuestInformationData(
          paxId: _reviewReservationBloc
              .state.reservationViewModel!.tourPackage!.adultPaxId,
          guestFirstName: firstName,
          guestLastName: secondName,
          guestMobileNumber: mobileNumber,
        );
        _travellerController.setFirstGuestInfo(guestInfo);
      }
    } else {
      GuestInformationData guestInfo = GuestInformationData(
        paxId: _reviewReservationBloc
            .state.reservationViewModel!.tourPackage!.adultPaxId,
        guestFirstName: _userDetailBloc.state.firstName,
        guestLastName: _userDetailBloc.state.secondName,
        guestMobileNumber: _userDetailBloc.state.mobileNumber,
        guestEmail: _userDetailBloc.state.email,
      );
      _travellerController.setFirstGuestInfo(guestInfo);
    }
  }

  Widget _getTravellersDetails() {
    bool isAllNameRequired = _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.requireInfo?.allName ??
        false;
    return BlocBuilder(
      bloc: (_otaRadioButtonBloc),
      builder: () {
        return PackageTravellerDetailWidget(
          adultCount: isAllNameRequired
              ? (_tourReviewReservationModel?.adultCount ?? 0)
              : 1,
          childCount: isAllNameRequired
              ? (_tourReviewReservationModel?.childCount ?? 0)
              : 0,
          travellerController: _travellerController,
          tourRequireInfoViewModel: _reviewReservationBloc
              .state.reservationViewModel?.tourPackage?.requireInfo,
          adultPaxId: _reviewReservationBloc
              .state.reservationViewModel!.tourPackage!.adultPaxId,
          childPaxId: _reviewReservationBloc
              .state.reservationViewModel!.tourPackage!.childPaxId,
        );
      },
    );
  }

  Widget _getBottomBar() {
    CurrencyUtil currencyUtil = CurrencyUtil(
        currency: _reviewReservationBloc
            .state.reservationViewModel!.tourPackage?.currency);
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
                  bloc: _travellerController,
                  builder: () {
                    return OtaBottomButtonBar(
                      button1: RichText(
                        key: const Key(_kTotalPriceKey),
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText1,
                          children: <TextSpan>[
                            TextSpan(
                                text: currencyUtil
                                    .getFormattedPrice(_reviewReservationBloc
                                        .state.reservationViewModel!.totalPrice)
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
                          key: const Key(_kbookNowButtonKey),
                          isDisabled: _checkPayNowButtonValidity(),
                          onPressed: () {
                            if (_packageGuestUserDetailController
                                .isValidationSuccess()) {
                              getBookForOtherFirebase(
                                  FirebaseEvent.activityPaymentSubmitError);
                              getBookForOtherFirebase(
                                  FirebaseEvent.activityPromoRedeemError);
                              _publishFirebaseClickEventData();
                              _getAppFlyerClickEventData();
                              _getFirebasePaymentParameters();
                              _openTourConfirmBookingPage();
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
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
    if (_reviewReservationBloc.isTravellersDetailsRequired()) {
      bool isAllNameRequired = _reviewReservationBloc
              .state.reservationViewModel?.tourPackage?.requireInfo?.allName ??
          false;
      bool isAllAdultTravellersInfoValid =
          _travellerController.isAllAdultTravellersInfoValid(
        adultCount: isAllNameRequired
            ? (_tourReviewReservationModel?.adultCount ?? 0)
            : 1,
        tourRequireInfoViewModel: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.requireInfo,
      );
      if (!isAllAdultTravellersInfoValid) {
        return true;
      }

      bool isAllChildTravellersInfoValid =
          _travellerController.isAllChildTravellersInfoValid(
        childCount: isAllNameRequired
            ? (_tourReviewReservationModel?.childCount ?? 0)
            : 0,
        tourRequireInfoViewModel: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.requireInfo,
      );
      if (!isAllChildTravellersInfoValid) {
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

  void _openTourContactInformationPage() {
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
        fromScreen: _kTourKey,
      ),
    );
  }

  bool _isTokenExpired() {
    return _reviewReservationBloc.state.screenState ==
        TourReviewReservationScreenState.failureToken;
  }

  bool _isPackagePriceChanged() {
    return _reviewReservationBloc.state.reservationViewModel!.totalPrice !=
        _reviewReservationBloc.state.reservationViewModel!.lastPrice;
  }

  bool _isPackageUnAvailable() {
    return _reviewReservationBloc.state.screenState ==
        TourReviewReservationScreenState.failureUnavailable;
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
                  route.settings.name == AppRoutes.tourReservationScreen);
          _otaCountDownController.resetTimer();
          _refreshReviewPage();
        }).showAlertDialog(context);
  }

  void _showPackageUnavailableAlert() {
    _otaCountDownController.stopTimer();
    OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.tourFullyBooked),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.popUntil(context,
              (route) => route.settings.name == AppRoutes.tourDetailScreen);
        }).showAlertDialog(context);
  }

  void _showPriceChangeAlert() {
    _otaCountDownController.stopTimer();
    OtaAlertDialog(
        errorMessage: getTranslated(
            context, AppLocalizationsStrings.tourPackagePriceChangeMessage),
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

  TourConfirmBookingModel _getArgument() {
    ConfirmBookingArgument argument =
        TourConfirmBookingHelper.getTourConfirmBookingArgument(
      reservationViewModel: _reviewReservationBloc.state.reservationViewModel!,
      userDetailViewModel: _userDetailBloc.state,
      isBookingForSomeoneElse: _otaRadioButtonBloc.state.otaRadioButtonState ==
          OtaRadioButtonState.selected,
      additionalRequest: _additionalTextController.text,
      tourPickup: (_pickUpPointBloc.state.pageState == PickupPointState.success)
          ? Pickup(
              name: _pickUpPointBloc.state
                  .pickUpPoints![_dropOffController.state.chosenOption].name,
              id: _reviewReservationBloc
                  .state.reservationViewModel!.tourPackage!.zoneId!)
          : null,
      guestInformationList: TourConfirmBookingHelper.getGuestInformationList(
        guestDataMap: _travellerController.state.guestInformationList,
        isMapingForAll: _reviewReservationBloc.isTravellersDetailsRequired(),
        adultCount:
            _reviewReservationBloc.state.reservationViewModel!.adultCount,
        childCount:
            _reviewReservationBloc.state.reservationViewModel!.childCount ?? 0,
      ),
    );

    return TourConfirmBookingModel(
      otaCountDownController: _otaCountDownController,
      argument: argument,
      adultCount: _reviewReservationBloc.state.reservationViewModel!.adultCount,
      childCount:
          _reviewReservationBloc.state.reservationViewModel!.childCount ?? 0,
      childInfo: _reviewReservationBloc
          .state.reservationViewModel!.tourPackage!.childInfo!,
      cancellationPolicy: _reviewReservationBloc
          .state.reservationViewModel!.tourPackage!.cancellationPolicy!,
      adultTourPrice: _reviewReservationBloc
          .state.reservationViewModel!.tourPackage!.adultPrice,
      childTourPrice: _reviewReservationBloc
              .state.reservationViewModel!.tourPackage!.childPrice ??
          0,
      isAllTravellersInfoRequired:
          _reviewReservationBloc.isTravellersDetailsRequired(),
    );
  }

  void _openTourConfirmBookingPage() {
    Navigator.pushNamed(
      context,
      AppRoutes.tourConfirmBookingScreen,
      arguments: _getArgument(),
    );
  }

  void _publishAppFlyerData() {
    if (_userDetailBloc.state.userDetailViewModelDataState ==
            UserDetailViewModelDataState.loaded &&
        _reviewReservationBloc.state.screenState ==
            TourReviewReservationScreenState.success) {
      _getAppFlyerData();
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.tourPaymentEvent,
          key: TourPaymentAppFlyer.tourLocation,
          value: _reviewReservationBloc.state.reservationViewModel?.location);
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.tourPaymentSuccessEvent,
          key: TourPaymentSuccessAppFlyer.tourLocation,
          value: _reviewReservationBloc.state.reservationViewModel?.location);
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
          key: TourPaymentSuccessFirstOrderAppFlyer.tourLocation,
          value: _reviewReservationBloc.state.reservationViewModel?.location);
    }
  }

  void _getAppFlyerData() {
    AppFlyerLogger logger = AppFlyerLogger();
    logger.addKeyValue(
        key: TourReservationAppFlyer.tourPlaceId,
        value: _reviewReservationBloc.state.reservationViewModel?.tourId);
    logger.addKeyValue(
        key: TourReservationAppFlyer.tourId,
        value: _reviewReservationBloc.state.reservationViewModel?.tourId);
    logger.addCurrency(key: TourReservationAppFlyer.tourCurrency);
    logger.addUserLocation();
    logger.addKeyValue(
        key: TourReservationAppFlyer.tourLocation,
        value: _reviewReservationBloc.state.reservationViewModel?.location);
    logger.addIntValue(
        key: TourReservationAppFlyer.tourNumberOfAdult,
        value: _reviewReservationBloc.state.reservationViewModel?.adultCount);
    logger.addIntValue(
        key: TourReservationAppFlyer.tourNumberOfChild,
        value: _reviewReservationBloc.state.reservationViewModel?.childCount);
    logger.addDoubleValue(
        key: TourReservationAppFlyer.tourPricePerAdult,
        value: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.adultPrice);
    logger.addDoubleValue(
        key: TourReservationAppFlyer.tourPricePerChild,
        value: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.childPrice);
    logger.addKeyValue(
        key: TourReservationAppFlyer.tourContentId,
        value: _reviewReservationBloc.state.reservationViewModel?.tourId);
    logger.addContentType(key: TourReservationAppFlyer.tourContentType);
    logger.publishToSuperApp(AppFlyerEvent.tourReservationEvent);
  }

  void _getAppFlyerClickEventData() {
    AppFlyerLogger logger = AppFlyerLogger();
    logger.addKeyValue(
        key: TourReservationClickAppFlyer.tourPlaceId,
        value: _reviewReservationBloc.state.reservationViewModel?.tourId);
    logger.addKeyValue(
        key: TourReservationClickAppFlyer.tourId,
        value: _reviewReservationBloc.state.reservationViewModel?.tourId);
    logger.addCurrency(key: TourReservationClickAppFlyer.tourCurrency);
    logger.addUserLocation();
    logger.addKeyValue(
        key: TourReservationClickAppFlyer.tourLocation,
        value: _reviewReservationBloc.state.reservationViewModel?.location);
    logger.addIntValue(
        key: TourReservationClickAppFlyer.tourNumberOfAdult,
        value: _reviewReservationBloc.state.reservationViewModel?.adultCount);
    logger.addIntValue(
        key: TourReservationClickAppFlyer.tourNumberOfChild,
        value: _reviewReservationBloc.state.reservationViewModel?.childCount);
    logger.addDoubleValue(
        key: TourReservationClickAppFlyer.tourPricePerAdult,
        value: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.adultPrice);
    logger.addDoubleValue(
        key: TourReservationClickAppFlyer.tourPricePerChild,
        value: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.childPrice);
    logger.addKeyValue(
        key: TourReservationClickAppFlyer.tourContentId,
        value: _reviewReservationBloc.state.reservationViewModel?.tourId);
    logger.addContentType(key: TourReservationClickAppFlyer.tourContentType);
    logger.publishToSuperApp(AppFlyerEvent.tourReservationClickEvent);
  }

  void _publishFirebaseClickEventData() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    int adultTravellers =
        _reviewReservationBloc.state.reservationViewModel?.adultCount ?? 0;
    int childTravellers =
        _reviewReservationBloc.state.reservationViewModel?.childCount ?? 0;
    int totalTravellers = adultTravellers + childTravellers;
    firebaseLogger.addKeyValue(
        key: TourReservationClickFirebase.activityId,
        value: _reviewReservationBloc.state.reservationViewModel?.tourId);
    firebaseLogger.addKeyValue(
        key: TourReservationClickFirebase.activityService,
        value: _kServiceType);
    firebaseLogger.addKeyValue(
        key: TourReservationClickFirebase.activityName,
        value: _reviewReservationBloc.state.reservationViewModel?.tourName);
    firebaseLogger.addKeyValue(
        key: TourReservationClickFirebase.activityPackageName,
        value: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.packageName);
    firebaseLogger.addDateValue(
        key: TourReservationClickFirebase.activityDate,
        value: _tourReviewReservationModel?.argument.bookingDate);
    firebaseLogger.addDoubleValue(
        key: TourReservationClickFirebase.activityPricePerAdult,
        value: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.adultPrice);
    firebaseLogger.addDoubleValue(
        key: TourReservationClickFirebase.activityPricePerChild,
        value: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.childPrice);
    firebaseLogger.addIntValue(
        key: TourReservationClickFirebase.activityNumberOfAdult,
        value: _reviewReservationBloc.state.reservationViewModel?.adultCount);
    firebaseLogger.addIntValue(
        key: TourReservationClickFirebase.activityNumberOfChild,
        value: _reviewReservationBloc.state.reservationViewModel?.childCount);
    firebaseLogger.addIntValue(
        key: TourReservationClickFirebase.activityTotalTravellers,
        value: totalTravellers);
    firebaseLogger.addKeyValue(
        key: TourReservationClickFirebase.activityBookForOthers,
        value: _getBookForOthers());
    firebaseLogger.publishToSuperApp(FirebaseEvent.tourReservationClick);
  }

  void getBookForOtherFirebase(String eventName) {
    FirebaseHelper.startCapturingEvent(eventName);
    int adultTravellers =
        _reviewReservationBloc.state.reservationViewModel?.adultCount ?? 0;
    int childTravellers =
        _reviewReservationBloc.state.reservationViewModel?.childCount ?? 0;
    int totalTravellers = adultTravellers + childTravellers;
    FirebaseHelper.addKeyValue(
        key: ActivityPaymentErrorPaymentFirebase.activityId,
        eventName: eventName,
        value: _reviewReservationBloc.state.reservationViewModel?.tourId);
    FirebaseHelper.addKeyValue(
        key: ActivityPaymentErrorPaymentFirebase.activityService,
        eventName: eventName,
        value: _kServiceType);
    FirebaseHelper.addKeyValue(
        key: ActivityPaymentErrorPaymentFirebase.activityName,
        eventName: eventName,
        value: _reviewReservationBloc.state.reservationViewModel?.tourName);
    FirebaseHelper.addKeyValue(
        key: ActivityPaymentErrorPaymentFirebase.activityPackageName,
        eventName: eventName,
        value: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.packageName);
    FirebaseHelper.addDateValue(
        key: ActivityPaymentErrorPaymentFirebase.activityDate,
        eventName: eventName,
        value: _tourReviewReservationModel?.argument.bookingDate);
    FirebaseHelper.addDoubleValue(
        key: ActivityPaymentErrorPaymentFirebase.activityPricePerAdult,
        eventName: eventName,
        value: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.adultPrice);
    FirebaseHelper.addDoubleValue(
        key: ActivityPaymentErrorPaymentFirebase.activityPricePerChild,
        eventName: eventName,
        value: _reviewReservationBloc
            .state.reservationViewModel?.tourPackage?.childPrice);
    FirebaseHelper.addIntValue(
        key: ActivityPaymentErrorPaymentFirebase.activityNoOfAdult,
        eventName: eventName,
        value: _reviewReservationBloc.state.reservationViewModel?.adultCount);
    FirebaseHelper.addIntValue(
        key: ActivityPaymentErrorPaymentFirebase.activityNoOfChild,
        eventName: eventName,
        value: _reviewReservationBloc.state.reservationViewModel?.childCount);
    FirebaseHelper.addIntValue(
        key: ActivityPaymentErrorPaymentFirebase.activityTicketNo,
        eventName: eventName,
        value: totalTravellers);
    FirebaseHelper.addKeyValue(
        key: ActivityPaymentErrorPaymentFirebase.activityBookForOthers,
        eventName: eventName,
        value: _getBookForOthers());
    FirebaseHelper.addKeyValue(
        key: ActivityPaymentErrorPaymentFirebase.activityReferenceId,
        eventName: eventName,
        value: _reviewReservationBloc.state.reservationViewModel?.bookingUrn ??
            "");
  }

  String _getBookForOthers() {
    const String prefixTitle = 'Khun';
    if (_packageGuestUserDetailController.isReservingForSomeoneElse()) {
      return '${_lastNameController.text} ${_firstNameController.text}, '
          '$prefixTitle';
    } else {
      return "";
    }
  }

  void _getFirebasePaymentParameters() {
    FirebaseHelper.startCapturingEvent(FirebaseEvent.activityPaymentEvent);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activityPaymentEvent,
        key: ActivityPaymentFirebase.activityBookForOthers,
        value: _getBookForOthers());
  }
}
