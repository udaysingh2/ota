import 'package:flutter/material.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_cancellation_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/ota_common/model/ota_booking_mailer_argument_model.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/tours/appointment_detail/view_model/appointment_detail_view_model.dart';
import 'package:ota/modules/tours/booking_details/bloc/tour_booking_details.bloc.dart';
import 'package:ota/modules/tours/booking_details/helper/tour_booking_detail_helper.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/top_detail_section.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_appointment_detail_widget.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_contact_details.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_detail_widget.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_booking_status.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_payment_status.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_refund_widget.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_widget.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_meeting_point_widget.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_package_detail_widget.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_bookings_network_error.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_reserve_details_widget.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_detail_argument.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/reservation/helper/tour_expandable_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_booking_terms_widget.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view_model/tour_booking_cancellation_argument_view_model.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view_model/tour_booking_cancellation_view_model.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_detail_argument_type.dart';

const String _kCheckIcon = "assets/images/icons/uil_check-circle.svg";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";

class TourBookingDetailScreen extends StatefulWidget {
  const TourBookingDetailScreen({Key? key}) : super(key: key);

  @override
  TourBookingDetailScreenState createState() => TourBookingDetailScreenState();
}

class TourBookingDetailScreenState extends State<TourBookingDetailScreen> {
  final TourBookingDetailsBloc _tourBookingDetailsBloc =
      TourBookingDetailsBloc();
  final OtaCancellationPolicyController _controller =
      OtaCancellationPolicyController();
  final TourExpandableController _detailController = TourExpandableController();
  TourBookingDetailArgument? argument;
  bool isStatusChanged = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.tourCancellationEvent);
      argument = ModalRoute.of(context)?.settings.arguments
          as TourBookingDetailArgument?;
      _tourBookingDetailsBloc.getTourBookingDetailsData(argument);
    });
    _tourBookingDetailsBloc.stream.listen((event) {
      if (_tourBookingDetailsBloc.state.pageState ==
          TourBookingDetailsPageStates.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      } else if (_tourBookingDetailsBloc.state.pageState ==
          TourBookingDetailsPageStates.success) {
        _getAppFlyerData();
      }
    });

    super.initState();
  }

  Future<bool> onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    _appBarBackButtonAction();
    return false;
  }

  _appBarBackButtonAction() {
    NavigatorHelper.shouldSystemPop(
      context,
      arguments: _tourBookingDetailsBloc.state.data == null
          ? null
          : TourBookingActivityArgument(
              index: TourAndTicketBookingDetailHelper.getIndex(
                  _tourBookingDetailsBloc.state.data!.tourBookingType),
              isStatusChanged: isStatusChanged),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          backgroundColor: AppColors.kLight100,
          body: Column(
            children: [
              OtaAppBar(
                title: getTranslated(context,
                    AppLocalizationsStrings.activityReservationSummary),
                onLeftButtonPressed: _appBarBackButtonAction,
              ),
              Expanded(
                child: BlocBuilder(
                    bloc: _tourBookingDetailsBloc,
                    builder: () {
                      switch (_tourBookingDetailsBloc.state.pageState) {
                        case TourBookingDetailsPageStates.loading:
                          return loadIngWidget();
                        case TourBookingDetailsPageStates.failure:
                        case TourBookingDetailsPageStates.internetFailure:
                          return failureState();
                        case TourBookingDetailsPageStates.success:
                          return successWidget();
                        case TourBookingDetailsPageStates.initial:
                          return const SizedBox();
                      }
                    }),
              ),
            ],
          )),
    );
  }

  Widget loadIngWidget() {
    return const OTALoadingIndicator();
  }

  Widget failureState() {
    return TourBookingsNetworkErrorWidget(
      height: MediaQuery.of(context).size.height - kSize200,
      onRefresh: () async =>
          await _tourBookingDetailsBloc.getTourBookingDetailsData(argument),
    );
  }

  Widget successWidget() {
    return Stack(
      children: [
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(kSize24),
          children: _getScreenWidgets(),
        ),
        if (_tourBookingDetailsBloc.state.data!.tourBookingType !=
            TourAndTicketBookingType.ongoingBooking)
          _getBottomBar(context),
      ],
    );
  }

  List<Widget> _getScreenWidgets() {
    TourBookingDetailsData bookingDetailsData =
        _tourBookingDetailsBloc.state.data!;
    List<Widget> screenWidgetList = [];
    screenWidgetList.add(_getOldBookingStatus());
    screenWidgetList.add(_getTopDetailSection());
    screenWidgetList.add(_getTourDetails());
    screenWidgetList.add(_getReservationDetails());
    if (_tourBookingDetailsBloc.state.data!.informationViewModel != null) {
      screenWidgetList.add(_getActivityDetailWidget());
    }
    screenWidgetList.add(_getPackageDetailsWidget());
    if (_tourBookingDetailsBloc.isMeetingPointValid) {
      screenWidgetList.add(_getAppointmentDetailsWidget());
    }
    if (_tourBookingDetailsBloc.isProviderDetailsAvialable) {
      screenWidgetList.add(_getContactDetails());
    }
    if (_tourBookingDetailsBloc.state.data?.promotionData != null &&
        _tourBookingDetailsBloc.state.data!.promotionData.isNotEmpty) {
      screenWidgetList.add(_getPromotionTagWidget());
    }
    if (bookingDetailsData.meetingPoint != null &&
        bookingDetailsData.meetingPoint!.isNotEmpty) {
      screenWidgetList.add(_getAppointmentDetails());
    }
    screenWidgetList.add(_getCancellationPolicy());
    screenWidgetList.add(_getPaymentWidget());
    if (_tourBookingDetailsBloc.state.data!.tourBookingType ==
        TourAndTicketBookingType.canceledBookings) {
      if (_tourBookingDetailsBloc.state.data!.tourBookingStatus !=
          TourAndTicketBookingStatus.unsuccessfulPayment) {
        screenWidgetList.add(_getRefundDetailsWidget());
      }
    } else {
      screenWidgetList.add(_getRobinhoodContact());
    }
    if (_tourBookingDetailsBloc.state.data!.tourBookingType !=
        TourAndTicketBookingType.ongoingBooking) {
      screenWidgetList.add(const SizedBox(height: kSize100));
    }
    return screenWidgetList;
  }

  Widget _getRefundDetailsWidget() {
    return Column(
      children: [
        TourAndTicketBookingDetailsRefundWidget(
          showHeader: true,
          netPrice: _tourBookingDetailsBloc.state.data!.netPrice,
          cancellationFee:
              _tourBookingDetailsBloc.state.data!.cancellationCharge,
          totalRefund: _tourBookingDetailsBloc.state.data!.totalRefundAmount,
        ),
        if (_tourBookingDetailsBloc.state.data!.tourBookingType !=
            TourAndTicketBookingType.canceledBookings)
          const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10, height: kSize32),
      ],
    );
  }

  Widget _getTourDetails() {
    return Column(
      children: [
        const SizedBox(height: kSize8),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        TourBookingDetailWidget(
          controller: _detailController,
          title: _tourBookingDetailsBloc.state.data!.packageName,
          childCount: _tourBookingDetailsBloc.state.data!.noOfChild,
          childInfo: ToursChildInfo(
              minAge: _tourBookingDetailsBloc.state.data!.minAge,
              maxAge: _tourBookingDetailsBloc.state.data!.maxAge),
          facilityMap: _tourBookingDetailsBloc.state.data!.highlights,
          adultPricePerNight: _tourBookingDetailsBloc.state.data!.adultPrice,
          childrenPricePerNight: _tourBookingDetailsBloc.state.data!.childPrice,
        ),
      ],
    );
  }

  Widget _getTopDetailSection() {
    return OtaTopDetailsSection(
      title: _tourBookingDetailsBloc.state.data!.name,
      serviceType:
          _tourBookingDetailsBloc.state.data!.bookingType.toLowerCase(),
      categoryName: _tourBookingDetailsBloc.state.data!.category,
      imageUrl: _tourBookingDetailsBloc.state.data!.imageUrl,
      categoryLocation: _tourBookingDetailsBloc.state.data!.location,
    );
  }

  Widget _getBottomBar(BuildContext context) {
    return OtaBottomButtonBar(
      safeAreaBottom: false,
      isExpandedRightButton: true,
      spaceBetweenButton: kSize16,
      button1: Align(
        alignment: Alignment.bottomCenter,
        child: OtaTextButton(
          key: const Key("btn"),
          title: getTranslated(context, AppLocalizationsStrings.reserveAgain),
          textHorizontalPadding: kSize40,
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              AppRoutes.tourDetailScreen,
              arguments: TourDetailArgument(
                  tourId: _tourBookingDetailsBloc.state.data!.tourId,
                  countryId: _tourBookingDetailsBloc.state.data!.countryId,
                  cityId: _tourBookingDetailsBloc.state.data!.cityId,
                  userType: getLoginProvider().isLoggedIn()
                      ? TourDetailUserType.loggedInUser
                      : TourDetailUserType.guestUser),
            );
          },
        ),
      ),
    );
  }

  Widget _getOldBookingStatus() {
    return TourBookingDetailsBookingStatus(
      bookingId: _tourBookingDetailsBloc.state.data!.bookingId,
      referenceId: _tourBookingDetailsBloc.state.data!.bookingUrn,
      orderId: _tourBookingDetailsBloc.state.data!.orderId,
      bookingStatus: TourAndTicketBookingDetailHelper.getBookingStatusText(
        context: context,
        bookingStatus: _tourBookingDetailsBloc.state.data!.tourBookingStatus,
        cancellationDate: _tourBookingDetailsBloc.state.data!.cancellationDate!,
      ),
      statusType: _tourBookingDetailsBloc.state.data!.tourBookingStatus,
    );
  }

  Widget _getReservationDetails() {
    return TourReserveDetailsWidget(
      packageDate:
          DateTime.tryParse(_tourBookingDetailsBloc.state.data!.bookingDate!),
      contactName: TourAndTicketBookingDetailHelper.getNameOfParticipant(
          _tourBookingDetailsBloc.state.data!.participantsInfo?.first),
      numberOfDays: _tourBookingDetailsBloc.state.data!.noOfDays,
      activityDuration: _tourBookingDetailsBloc.state.data!.duration,
      noOfParticipants: TourAndTicketBookingDetailHelper.getNoOfParticipants(
          context,
          _tourBookingDetailsBloc.state.data!.noOfAdults,
          _tourBookingDetailsBloc.state.data!.noOfChild),
      participationInformation:
          AppLocalizationsStrings.participationInformation,
    );
  }

  Widget _getAppointmentDetails() {
    return TourBookingMeetingPointWidget(
        meetingPoint: _tourBookingDetailsBloc.state.data!.meetingPoint!);
  }

  Widget _getActivityDetailWidget() {
    return TourBookingPackageDetailWidget(
      titleKey: AppLocalizationsStrings.additionalTourDetail,
      onTap: () {
        Navigator.pushNamed(
            context, AppRoutes.tourBookingDetailDescriptionScreen,
            arguments:
                _tourBookingDetailsBloc.state.data?.informationViewModel);
      },
    );
  }

  Widget _getPackageDetailsWidget() {
    return TourBookingPackageDetailWidget(
      titleKey: AppLocalizationsStrings.packageDetails,
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.tourBookingPackageDetailScreen,
            arguments: _tourBookingDetailsBloc.state.packageDetail);
      },
    );
  }

  Widget _getAppointmentDetailsWidget() {
    return TourAppointmentDetailWidget(
      titleKey: AppLocalizationsStrings.appointmentDetails,
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.appointmentDetailScreen,
          arguments: AppointmentDetailViewModel.mapFromData(
              locationName: _tourBookingDetailsBloc.state.data!.location,
              meetingPointValue:
                  _tourBookingDetailsBloc.state.packageDetail?.meetingPoint,
              meetingLatitude: _tourBookingDetailsBloc
                  .state.packageDetail?.meetingPointLatitude,
              meetingLongitude: _tourBookingDetailsBloc
                  .state.packageDetail?.meetingPointLongitude),
        );
      },
    );
  }

  Widget _getCancellationPolicy() {
    return PackageBookingTermsWidget(
      controller: _controller,
      padding: EdgeInsets.zero,
      bookingTermsList: TourAndTicketBookingDetailHelper.getCancellationPolicy(
          context,
          _tourBookingDetailsBloc.state.data!.cancellationPolicy,
          AppConfig.shared.configModel.tourCancellationPercent),
      cancellationStatus:
          _tourBookingDetailsBloc.state.data!.cancellationHeader,
    );
  }

  Widget _getContactDetails() {
    return TourBookingContactDetailsWidget(
      phoneNumber: _tourBookingDetailsBloc.state.data!.supplierContact,
      providerInformation: _tourBookingDetailsBloc.state.data!.providerName,
    );
  }

  Widget _getPromotionTagWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize24),
        Text(
          getTranslated(context, AppLocalizationsStrings.robinhoodSpecialOffer),
          style: AppTheme.kHeading1Medium,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: kSize16),
        OtaFreeFoodBannerWidget(
          freeFoodPromotionList:
              _tourBookingDetailsBloc.state.data!.promotionData,
        ),
        const SizedBox(height: kSize24),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
      ],
    );
  }

  Widget _getPaymentWidget() {
    return TourBookingDetailsPaymentStatus(
        status: _tourBookingDetailsBloc.state.data!.tourBookingStatus,
        paymentStatus:
            getTranslated(context, AppLocalizationsStrings.tourBookingpPaid),
        netPrice: _tourBookingDetailsBloc.state.data!.netPrice,
        totalPrice: _tourBookingDetailsBloc.state.data!.totalPrice,
        discount: _tourBookingDetailsBloc.state.data!.discount,
        cardNickname: _tourBookingDetailsBloc.state.data?.cardNickname,
        cardNo: _tourBookingDetailsBloc.state.data?.cardNo,
        paymentType: _tourBookingDetailsBloc.state.data?.paymentType,
        appliedPromo: _tourBookingDetailsBloc.state.data?.appliedPromo,
        isTour: true,
        isWalletAvailable: _tourBookingDetailsBloc.walletPaymentDetails != null,
        walletAmount: _tourBookingDetailsBloc.walletPaymentDetails?.amount,
        walletName: _tourBookingDetailsBloc.walletPaymentDetails?.name,
        isCardAvailable:
            _tourBookingDetailsBloc.state.data?.isCardPaymentAvailable ??
                false);
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget _getRobinhoodContact() {
    return TourBookingDetailsWidget(
      onMessageTap: () => _openBookingMailerScreen(),
      onTap: () {
        _navigateToCancellationScreen();
      },
      isDisabledEmailConfirmation:
          (_tourBookingDetailsBloc.state.data!.tourBookingStatus !=
              TourAndTicketBookingStatus.bookingConfirmed),
      isDisabledContact: TourAndTicketBookingDetailHelper.isContactDisabled(
          _tourBookingDetailsBloc.state.data!.tourBookingStatus),
      isDisableCancellation: _getCancellationStatus(),
    );
  }

  bool _getCancellationStatus() {
    if (_tourBookingDetailsBloc.state.data!.tourBookingStatus ==
            TourAndTicketBookingStatus.bookingConfirmed &&
        _tourBookingDetailsBloc.state.data!.tourBookingType ==
            TourAndTicketBookingType.ongoingBooking) {
      return false;
    }
    return true;
  }

  void _openBookingMailerScreen() {
    Navigator.pushNamed(context, AppRoutes.otaBookingMailerScreen,
        arguments: OtaBookingMailerArgumentModel(
            bookingUrn: _tourBookingDetailsBloc.state.data!.bookingUrn!,
            bookingConfirmNo: _tourBookingDetailsBloc.state.data!.bookingId!,
            bookingType: OtaServiceType.tour));
  }

  _navigateToCancellationScreen() async {
    final data = await Navigator.pushNamed(
      context,
      AppRoutes.tourBookingCancellationScreen,
      arguments: TourBookingCancellationArgumentViewModel(
        cancellationPolicyList:
            _tourBookingDetailsBloc.state.data?.cancellationPolicy,
        confirmNo: _tourBookingDetailsBloc.state.data!.bookingId!,
        bookingUrn: _tourBookingDetailsBloc.state.data!.bookingUrn!,
        bookingStatus: argument?.bookingStatus ?? '',
        bookingDate: _tourBookingDetailsBloc.state.data!.bookingDate,
        confirmationDate: _tourBookingDetailsBloc.state.data!.confirmationDate,
      ),
    );
    _updateArgument(data);
  }

  _updateArgument(Object? data) {
    if (data is TourCancellationStatus) {
      if (data == TourCancellationStatus.success) {
        isStatusChanged = true;
        _refreshTourBookingDetailsData();
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            OtaBanner().showMaterialBanner(
              context,
              getTranslated(
                  context, AppLocalizationsStrings.awaitingConfirmationMessage),
              AppColors.kSystemSuccess,
              _kCheckIcon,
            );
          },
        );
      } else {
        _refreshTourBookingDetailsData();
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            OtaBanner().showMaterialBanner(
                context,
                getTranslated(
                    context, AppLocalizationsStrings.bookingCancelFailure),
                AppColors.kSystemWrong,
                _kExclamationIcon);
          },
        );
      }
    }
  }

  _refreshTourBookingDetailsData() {
    _tourBookingDetailsBloc.getTourBookingDetailsData(argument);
  }

  void _getAppFlyerData() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourPlaceId,
        value: _tourBookingDetailsBloc.state.data?.tourId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourId,
        value: _tourBookingDetailsBloc.state.data?.tourId);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.tourCancellationEvent);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourNumberOfAdult,
        value: _tourBookingDetailsBloc.state.data?.noOfAdults);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourNumberOfChild,
        value: _tourBookingDetailsBloc.state.data?.noOfChild);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourPricePerAdult,
        value: _tourBookingDetailsBloc.state.data?.adultPrice);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourPricePerChild,
        value: _tourBookingDetailsBloc.state.data?.childPrice);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourPromoCode,
        value: _tourBookingDetailsBloc
            .state.data?.appliedPromo?.promotion.promotionCode);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourPromoAmount,
        value: _tourBookingDetailsBloc
            .state.data?.appliedPromo?.priceViewModel?.effectiveDiscount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourPaymentType,
        value: _tourBookingDetailsBloc.state.data?.paymentMethod);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourReservationId,
        value: _tourBookingDetailsBloc.state.data?.bookingId);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.tourCancellationEvent,
        key: TourCancellationAppFlyer.tourCurrency);
  }
}
