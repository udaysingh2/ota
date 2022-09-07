import 'package:flutter/material.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tickets_cancellation_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/ota_common/model/ota_booking_mailer_argument_model.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/tickets/booking_details/bloc/ticket_booking_details.bloc.dart';
import 'package:ota/modules/tickets/booking_details/view/widget/ticket_booking_details_widget.dart';
import 'package:ota/modules/tickets/booking_details/view/widget/ticket_expandable_detail_widget.dart';
import 'package:ota/modules/tickets/booking_details/view/widget/ticket_participant_count_widget.dart';
import 'package:ota/modules/tickets/booking_details/view/widget/ticket_reserve_details_widget.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_detail_argument.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_details_view_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tickets/reservation/helper/ticket_reservation_helper.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_argument_view_model.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_view_model.dart';
import 'package:ota/modules/tours/appointment_detail/view_model/appointment_detail_view_model.dart';
import 'package:ota/modules/tours/booking_details/helper/tour_booking_detail_helper.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/top_detail_section.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_appointment_detail_widget.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_contact_details.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_booking_status.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_payment_status.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_refund_widget.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_meeting_point_widget.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_package_detail_widget.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_bookings_network_error.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';
import 'package:ota/modules/tours/reservation/helper/tour_expandable_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_booking_terms_widget.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_detail_argument_type.dart';

import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';

const String _kCheckIcon = "assets/images/icons/uil_check-circle.svg";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";

class TicketBookingDetailScreen extends StatefulWidget {
  const TicketBookingDetailScreen({Key? key}) : super(key: key);

  @override
  TicketBookingDetailScreenState createState() =>
      TicketBookingDetailScreenState();
}

class TicketBookingDetailScreenState extends State<TicketBookingDetailScreen> {
  final TicketBookingDetailsBloc _ticketBookingDetailsBloc =
      TicketBookingDetailsBloc();
  final OtaCancellationPolicyController _controller =
      OtaCancellationPolicyController();
  final TourExpandableController _detailController = TourExpandableController();
  TicketBookingDetailArgument? argument;
  bool isStatusChanged = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.ticketCancellationEvent);
      argument = ModalRoute.of(context)?.settings.arguments
          as TicketBookingDetailArgument;
      _ticketBookingDetailsBloc.getTicketBookingDetailsData(argument);
    });
    super.initState();
    _ticketBookingDetailsBloc.stream.listen((event) {
      if (_ticketBookingDetailsBloc.state.pageState ==
          TicketBookingDetailsPageStates.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      } else if (_ticketBookingDetailsBloc.state.pageState ==
          TicketBookingDetailsPageStates.success) {
        _getAppFlyerData();
      }
    });
  }

  Future<bool> onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    _appBarBackButtonAction();
    return false;
  }

  _appBarBackButtonAction() {
    NavigatorHelper.shouldSystemPop(
      context,
      arguments: _ticketBookingDetailsBloc.state.data == null
          ? null
          : TourBookingActivityArgument(
              index: TourAndTicketBookingDetailHelper.getIndex(
                  _ticketBookingDetailsBloc.state.data!.ticketBookingType),
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
                title: getTranslated(
                    context, AppLocalizationsStrings.ticketReservationSummary),
                onLeftButtonPressed: _appBarBackButtonAction,
              ),
              Expanded(
                child: BlocBuilder(
                    bloc: _ticketBookingDetailsBloc,
                    builder: () {
                      switch (_ticketBookingDetailsBloc.state.pageState) {
                        case TicketBookingDetailsPageStates.loading:
                          return loadIngWidget();
                        case TicketBookingDetailsPageStates.failure:
                        case TicketBookingDetailsPageStates.internetFailure:
                          return failureState();
                        case TicketBookingDetailsPageStates.success:
                          return successWidget();
                        case TicketBookingDetailsPageStates.initial:
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
          await _ticketBookingDetailsBloc.getTicketBookingDetailsData(argument),
    );
  }

  Widget successWidget() {
    return Stack(
      children: [
        ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(kSize24),
            children: _getScreenWidgets()),
        if (_ticketBookingDetailsBloc.state.data!.ticketBookingType !=
            TourAndTicketBookingType.ongoingBooking)
          _getBottomBar(context),
      ],
    );
  }

  List<Widget> _getScreenWidgets() {
    TicketBookingDetailsData bookingDetailsData =
        _ticketBookingDetailsBloc.state.data!;
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList =
        _ticketBookingDetailsBloc.state.data?.promotionData ?? [];
    List<Widget> screenWidgetList = [];
    screenWidgetList.add(_getBookingStatus());
    screenWidgetList.add(_getTopDetailSection());
    screenWidgetList.add(_getExpandTicketDetailSection());
    screenWidgetList.add(_getReservationDetails());
    screenWidgetList.add(_getTicketParticipantCount());
    if (_ticketBookingDetailsBloc.state.data!.information != null) {
      screenWidgetList.add(_getActivityDetailWidget());
    }
    screenWidgetList.add(_getPackageDetailsWidget());
    if (_ticketBookingDetailsBloc.isMeetingPointValid) {
      screenWidgetList.add(_getAppointmentDetailsWidget());
    }
    if (_ticketBookingDetailsBloc.isProviderDetailsAvialable) {
      screenWidgetList.add(_getContactDetails());
    }
    if (freeFoodPromotionList.isNotEmpty) {
      screenWidgetList.add(_getPromotionTagWidget(freeFoodPromotionList));
    }
    if (bookingDetailsData.meetingPoint != null &&
        bookingDetailsData.meetingPoint!.isNotEmpty) {
      screenWidgetList.add(_getAppointmentDetails());
    }
    screenWidgetList.add(_getCancellationPolicy());
    screenWidgetList.add(_getPaymentWidget());
    if (bookingDetailsData.ticketBookingType ==
        TourAndTicketBookingType.canceledBookings) {
      if (_ticketBookingDetailsBloc.state.data!.ticketBookingStatus !=
          TourAndTicketBookingStatus.unsuccessfulPayment) {
        screenWidgetList.add(_getRefundDetailsWidget());
      }
    } else {
      screenWidgetList.add(_getRobinhoodContact());
    }
    if (bookingDetailsData.ticketBookingType !=
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
          netPrice: _ticketBookingDetailsBloc.state.data!.netPrice,
          cancellationFee:
              _ticketBookingDetailsBloc.state.data!.cancellationCharge,
          totalRefund: _ticketBookingDetailsBloc.state.data!.totalRefundAmount,
        ),
        if (_ticketBookingDetailsBloc.state.data!.ticketBookingType !=
            TourAndTicketBookingType.canceledBookings)
          const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10, height: kSize32),
      ],
    );
  }

  Widget _getExpandTicketDetailSection() {
    return Column(
      children: [
        const SizedBox(height: kSize8),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        TicketExpandableDetailWidget(
          controller: _detailController,
          title: _ticketBookingDetailsBloc.state.data!.packageName,
          facilityMap: _ticketBookingDetailsBloc.state.data!.highlights,
          ticketType: _ticketBookingDetailsBloc.state.data!.ticketTypes,
        ),
      ],
    );
  }

  Widget _getTopDetailSection() {
    return OtaTopDetailsSection(
      title: _ticketBookingDetailsBloc.state.data!.name,
      serviceType:
          _ticketBookingDetailsBloc.state.data!.bookingType.toLowerCase(),
      categoryName: _ticketBookingDetailsBloc.state.data!.category,
      imageUrl: _ticketBookingDetailsBloc.state.data!.imageUrl,
      categoryLocation: _ticketBookingDetailsBloc.state.data!.location,
    );
  }

  Widget _getBottomBar(BuildContext context) {
    return OtaBottomButtonBar(
      isExpandedRightButton: true,
      safeAreaBottom: false,
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
              AppRoutes.ticketDetailScreen,
              arguments: TicketDetailArgument(
                  ticketId: _ticketBookingDetailsBloc.state.data!.ticketId,
                  countryId: _ticketBookingDetailsBloc.state.data!.countryId,
                  cityId: _ticketBookingDetailsBloc.state.data!.cityId,
                  userType: getLoginProvider().isLoggedIn()
                      ? TicketDetailUserType.loggedInUser
                      : TicketDetailUserType.guestUser),
            );
          },
        ),
      ),
    );
  }

  Widget _getBookingStatus() {
    return TourBookingDetailsBookingStatus(
      bookingId: _ticketBookingDetailsBloc.state.data!.bookingId,
      referenceId: _ticketBookingDetailsBloc.state.data!.bookingUrn,
      orderId: _ticketBookingDetailsBloc.state.data!.orderId,
      bookingStatus: TourAndTicketBookingDetailHelper.getBookingStatusText(
        context: context,
        bookingStatus:
            _ticketBookingDetailsBloc.state.data!.ticketBookingStatus,
        cancellationDate:
            _ticketBookingDetailsBloc.state.data!.cancellationDate!,
      ),
      statusType: _ticketBookingDetailsBloc.state.data!.ticketBookingStatus,
    );
  }

  Widget _getReservationDetails() {
    return TicketReserveDetailsWidget(
      packageDate:
          DateTime.tryParse(_ticketBookingDetailsBloc.state.data!.bookingDate!),
      contactName: _ticketBookingDetailsBloc
              .state.data!.participantsInfo!.first.name
              .toString() +
          _ticketBookingDetailsBloc.state.data!.participantsInfo!.first.surname
              .toString()
              .addLeadingSpace(),
      numberOfDays: _ticketBookingDetailsBloc.state.data!.noOfDays,
      activityDuration: _ticketBookingDetailsBloc.state.data!.duration,
      participationInformation:
          AppLocalizationsStrings.participationInformation,
    );
  }

  Widget _getAppointmentDetails() {
    return TourBookingMeetingPointWidget(
        meetingPoint: _ticketBookingDetailsBloc.state.data!.meetingPoint!);
  }

  Widget _getTicketParticipantCount() {
    return TicketParticipantCountWidget(
      ticketList: _ticketBookingDetailsBloc.state.data!.ticketTypes,
    );
  }

  Widget _getActivityDetailWidget() {
    return TourBookingPackageDetailWidget(
      titleKey: AppLocalizationsStrings.additionalTicketDetail,
      onTap: () {
        Navigator.pushNamed(
            context, AppRoutes.ticketBookingDetailDescriptionScreen,
            arguments: _ticketBookingDetailsBloc.state.data!.information);
      },
    );
  }

  Widget _getPackageDetailsWidget() {
    return TourBookingPackageDetailWidget(
      titleKey: AppLocalizationsStrings.packageDetails,
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.ticketBookingPackageDetailScreen,
            arguments: _ticketBookingDetailsBloc.state.packageDetail);
      },
    );
  }

  Widget _getAppointmentDetailsWidget() {
    AppointmentDetailViewModel argument =
        AppointmentDetailViewModel.mapFromData(
            locationName: _ticketBookingDetailsBloc.state.data!.location,
            meetingPointValue:
                _ticketBookingDetailsBloc.state.packageDetail?.meetingPoint,
            meetingLatitude: _ticketBookingDetailsBloc
                .state.packageDetail?.meetingPointLatitude,
            meetingLongitude: _ticketBookingDetailsBloc
                .state.packageDetail?.meetingPointLongitude);
    return TourAppointmentDetailWidget(
      titleKey: AppLocalizationsStrings.appointmentDetails,
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.appointmentDetailScreen,
          arguments: argument,
        );
      },
    );
  }

  Widget _getCancellationPolicy() {
    return PackageBookingTermsWidget(
      controller: _controller,
      padding: EdgeInsets.zero,
      bookingTermsList: TicketReservationHelper.getCancellationPolicy(
          context,
          _ticketBookingDetailsBloc.state.data?.cancellationPolicy,
          AppConfig.shared.configModel.tourCancellationPercent),
      cancellationStatus:
          _ticketBookingDetailsBloc.state.data!.cancellationHeader,
    );
  }

  Widget _getContactDetails() {
    return TourBookingContactDetailsWidget(
      phoneNumber: _ticketBookingDetailsBloc.state.data!.supplierContact,
      providerInformation: _ticketBookingDetailsBloc.state.data!.providerName,
    );
  }

  Widget _getPromotionTagWidget(
      List<OtaFreeFoodPromotionModel> freeFoodPromotionList) {
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
        OtaFreeFoodBannerWidget(freeFoodPromotionList: freeFoodPromotionList),
        const SizedBox(height: kSize24),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
      ],
    );
  }

  Widget _getPaymentWidget() {
    return TourBookingDetailsPaymentStatus(
      status: _ticketBookingDetailsBloc.state.data!.ticketBookingStatus,
      paymentStatus:
          getTranslated(context, AppLocalizationsStrings.tourBookingpPaid),
      netPrice: _ticketBookingDetailsBloc.state.data!.netPrice,
      totalPrice: _ticketBookingDetailsBloc.state.data!.totalPrice,
      discount: _ticketBookingDetailsBloc.state.data!.discount,
      cardNickname: _ticketBookingDetailsBloc.state.data?.cardNickname,
      cardNo: _ticketBookingDetailsBloc.state.data?.cardNo,
      paymentType: _ticketBookingDetailsBloc.state.data?.paymentType,
      appliedPromo: _ticketBookingDetailsBloc.state.data?.appliedPromo,
      isTour: false,
      isWalletAvailable: _ticketBookingDetailsBloc.walletPaymentDetails != null,
      walletAmount: _ticketBookingDetailsBloc.walletPaymentDetails?.amount,
      walletName: _ticketBookingDetailsBloc.walletPaymentDetails?.name,
      isCardAvailable:
          _ticketBookingDetailsBloc.state.data?.isCardPaymentAvailable ?? false,
    );
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget _getRobinhoodContact() {
    return TicketBookingDetailsWidget(
        onMessageTap: () => _openBookingMailerScreen(),
        onTap: () {
          _navigateToCancellationScreen();
        },
        isDisabledContact: TourAndTicketBookingDetailHelper.isContactDisabled(
            _ticketBookingDetailsBloc.state.data!.ticketBookingStatus),
        isDisabledEmmailConfirmation:
            (_ticketBookingDetailsBloc.state.data!.ticketBookingStatus !=
                TourAndTicketBookingStatus.bookingConfirmed),
        isDisableCancellation: _getCancellationStatus());
  }

  bool _getCancellationStatus() {
    if (_ticketBookingDetailsBloc.state.data!.ticketBookingStatus ==
            TourAndTicketBookingStatus.bookingConfirmed &&
        _ticketBookingDetailsBloc.state.data!.ticketBookingType ==
            TourAndTicketBookingType.ongoingBooking) {
      return false;
    }
    return true;
  }

  void _openBookingMailerScreen() {
    Navigator.pushNamed(
      context,
      AppRoutes.otaBookingMailerScreen,
      arguments: OtaBookingMailerArgumentModel(
          bookingUrn: _ticketBookingDetailsBloc.state.data!.bookingUrn!,
          bookingConfirmNo: _ticketBookingDetailsBloc.state.data!.bookingId!,
          bookingType: OtaServiceType.ticket),
    );
  }

  _navigateToCancellationScreen() async {
    final data = await Navigator.pushNamed(
      context,
      AppRoutes.ticketBookingCancellationScreen,
      arguments: TicketBookingCancellationArgumentViewModel(
        cancellationPolicyList:
            _ticketBookingDetailsBloc.state.data?.cancellationPolicy,
        confirmNo: _ticketBookingDetailsBloc.state.data!.bookingId!,
        bookingUrn: _ticketBookingDetailsBloc.state.data!.bookingUrn!,
        bookingStatus: argument?.bookingStatus ?? '',
        bookingDate: _ticketBookingDetailsBloc.state.data!.bookingDate,
        confirmationDate:
            _ticketBookingDetailsBloc.state.data!.confirmationDate,
      ),
    );
    _updateArgument(data);
  }

  _updateArgument(Object? data) {
    if (data is TicketCancellationStatus) {
      if (data == TicketCancellationStatus.success) {
        isStatusChanged = true;
        _refreshTicketBookingDetailsData();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          OtaBanner().showMaterialBanner(
            context,
            getTranslated(
                context, AppLocalizationsStrings.awaitingConfirmationMessage),
            AppColors.kSystemSuccess,
            _kCheckIcon,
          );
        });
      } else {
        _refreshTicketBookingDetailsData();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          OtaBanner().showMaterialBanner(
              context,
              getTranslated(
                  context, AppLocalizationsStrings.bookingCancelFailure),
              AppColors.kSystemWrong,
              _kExclamationIcon);
        });
      }
    }
  }

  _refreshTicketBookingDetailsData() {
    _ticketBookingDetailsBloc.getTicketBookingDetailsData(argument);
  }

  void _getAppFlyerData() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketCancellationEvent,
        key: TicketCancellationAppFlyer.ticketPlaceId,
        value: _ticketBookingDetailsBloc.state.data?.ticketId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketCancellationEvent,
        key: TicketCancellationAppFlyer.ticketActivityId,
        value: _ticketBookingDetailsBloc.state.data?.ticketId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketCancellationEvent,
        key: TicketCancellationAppFlyer.ticketPromoCode,
        value: _ticketBookingDetailsBloc
            .state.data?.appliedPromo?.promotion.promotionCode);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.ticketCancellationEvent,
        key: TicketCancellationAppFlyer.ticketPromoAmount,
        value: _ticketBookingDetailsBloc
            .state.data?.appliedPromo?.priceViewModel?.effectiveDiscount);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.ticketCancellationEvent);
    _getAppFlyerDefaultTicketTypes();
    _getAppFlyerTicketTypes(_ticketBookingDetailsBloc.state.data?.ticketTypes);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketCancellationEvent,
        key: TicketCancellationAppFlyer.ticketPaymentType,
        value: _ticketBookingDetailsBloc.state.data?.paymentMethod);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.ticketCancellationEvent,
        key: TicketCancellationAppFlyer.ticketCurrency);
  }

  void _getAppFlyerDefaultTicketTypes() {
    for (int i = 0; i < 4; i++) {
      if (i == 0) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketCancellationEvent,
            key: TicketCancellationAppFlyer.ticketPaxAQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketCancellationEvent,
            key: TicketCancellationAppFlyer.ticketPaxAPerPrice,
            value: 0.0);
      } else if (i == 1) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketCancellationEvent,
            key: TicketCancellationAppFlyer.ticketPaxBQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketCancellationEvent,
            key: TicketCancellationAppFlyer.ticketPaxBPerPrice,
            value: 0.0);
      } else if (i == 2) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketCancellationEvent,
            key: TicketCancellationAppFlyer.ticketPaxCQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketCancellationEvent,
            key: TicketCancellationAppFlyer.ticketPaxCPerPrice,
            value: 0.0);
      } else if (i == 3) {
        AppFlyerHelper.addIntValue(
            eventName: AppFlyerEvent.ticketCancellationEvent,
            key: TicketCancellationAppFlyer.ticketPaxDQuantity,
            value: 0);
        AppFlyerHelper.addDoubleValue(
            eventName: AppFlyerEvent.ticketCancellationEvent,
            key: TicketCancellationAppFlyer.ticketPaxDPerPrice,
            value: 0.0);
      }
    }
  }

  void _getAppFlyerTicketTypes(
      List<TicketBookingDetailsTicketTypeInfo>? ticketTypeList) {
    int ticketQuantity = 0;
    if (ticketTypeList == null) {
      return;
    } else if (ticketTypeList.isEmpty) {
      return;
    } else {
      for (int i = 0; i < ticketTypeList.length; i++) {
        if (i == 0) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketCancellationEvent,
              key: TicketCancellationAppFlyer.ticketPaxAQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketCancellationEvent,
              key: TicketCancellationAppFlyer.ticketPaxAPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        } else if (i == 1) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketCancellationEvent,
              key: TicketCancellationAppFlyer.ticketPaxBQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketCancellationEvent,
              key: TicketCancellationAppFlyer.ticketPaxBPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        } else if (i == 2) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketCancellationEvent,
              key: TicketCancellationAppFlyer.ticketPaxCQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketCancellationEvent,
              key: TicketCancellationAppFlyer.ticketPaxCPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        } else if (i == 3) {
          AppFlyerHelper.addIntValue(
              eventName: AppFlyerEvent.ticketCancellationEvent,
              key: TicketCancellationAppFlyer.ticketPaxDQuantity,
              value: ticketTypeList[i].noOfTickets);
          AppFlyerHelper.addDoubleValue(
              eventName: AppFlyerEvent.ticketCancellationEvent,
              key: TicketCancellationAppFlyer.ticketPaxDPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        }
      }
      AppFlyerHelper.addIntValue(
          eventName: AppFlyerEvent.ticketCancellationEvent,
          key: TicketCancellationAppFlyer.ticketTotalQuantity,
          value: ticketQuantity);
    }
  }
}
