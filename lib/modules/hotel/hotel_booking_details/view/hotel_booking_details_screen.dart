import 'package:flutter/material.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_cancellation_request_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_addon_service_tile.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_booking_details_wallet_widget/ota_wallet_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_list_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_reservation_details_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_room_promotion_widget/ota_room_special_promotion_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument_view_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_view_model.dart';
import 'package:ota/modules/hotel/hotel_booking_details/bloc/hotel_booking_details_bloc.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/booking_details_refund_widget.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/booking_details_widget.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_detail_payment_list.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_details_booking_status.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_details_payment_status.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_details_room_info/hotel_booking_details_room_info_widget.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_detail_argument.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_view_model.dart';
import 'package:ota/modules/hotel/hotel_booking_mailer/view/hotel_booking_mailer_argument_model.dart';
import 'package:ota/modules/hotel/hotel_bookings/view/widgets/hotel_bookings_network_error.dart';
import 'package:ota/modules/hotel/hotel_bookings/view_model/hotel_booking_argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view/widgets/hotel_payment_card_item.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';

const String _kCheckIcon = "assets/images/icons/uil_check-circle.svg";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";
const double _kReserveAgainPadding = 50.0;

class HotelBookingDetailsScreen extends StatefulWidget {
  const HotelBookingDetailsScreen({Key? key}) : super(key: key);

  @override
  HotelBookingDetailsScreenState createState() =>
      HotelBookingDetailsScreenState();
}

class HotelBookingDetailsScreenState extends State<HotelBookingDetailsScreen> {
  final HotelBookingDetailsBloc _hotelBookingDetailsBloc =
      HotelBookingDetailsBloc();
  HotelBookingDetailArgument? argument;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppFlyerHelper.startCapturingEvent(
          AppFlyerEvent.hotelcancellationRequestEvent);
      argument = ModalRoute.of(context)?.settings.arguments
          as HotelBookingDetailArgument;
      _hotelBookingDetailsBloc.getHotelBookingDetailsData(argument);

      _hotelBookingDetailsBloc.stream.listen(
        (event) {
          if (_hotelBookingDetailsBloc.state.pageState ==
              HotelBookingDetailsPageState.internetFailure) {
            OtaNoInternetAlertDialog().showAlertDialog(context);
          }
          if (_hotelBookingDetailsBloc.state.pageState ==
              HotelBookingDetailsPageState.success) {
            _getAppFlyerEvent();
          }
        },
      );
    });

    super.initState();
  }

  _refreshHotelBookingDetailsData({HotelBookingDetailArgument? data}) {
    _hotelBookingDetailsBloc.getHotelBookingDetailsData(data);
  }

  void _openHotelBookingMailerScreen() {
    Navigator.pushNamed(context, AppRoutes.hotelBookingMailerScreen,
        arguments: HotelBookingMailerArgumentModel(
            bookingUrn: _hotelBookingDetailsBloc.state.data!.bookingUrn,
            bookingConfirmNo: _hotelBookingDetailsBloc.state.data!.bookingId));
  }

  @override
  void dispose() {
    _hotelBookingDetailsBloc.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    _appBarBackButtonAction();
    return false;
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
                    context, AppLocalizationsStrings.hotelReservationSummary),
                titleColor: AppColors.kGreyScale,
                onLeftButtonPressed: _appBarBackButtonAction,
              ),
              Expanded(
                child: BlocBuilder(
                    bloc: _hotelBookingDetailsBloc,
                    builder: () {
                      switch (_hotelBookingDetailsBloc.state.pageState) {
                        case HotelBookingDetailsPageState.loading:
                          return loadIngWidget();
                        case HotelBookingDetailsPageState.failure:
                        case HotelBookingDetailsPageState.internetFailure:
                          return failureState();
                        case HotelBookingDetailsPageState.success:
                          return successWidget();
                        default:
                          return defaultWidget();
                      }
                    }),
              ),
            ],
          )),
    );
  }

  _appBarBackButtonAction() {
    NavigatorHelper.shouldSystemPop(context,
        arguments: HotelBookingsArgumentModel(
          bookingType: _hotelBookingDetailsBloc.state.data?.bookingType.index,
          activityStatus: _hotelBookingDetailsBloc.state.data?.activityStatus,
        ));
  }

  Widget successWidget() {
    HotelBookingDetailsPaymentDetails? walletPaymentModel =
        _hotelBookingDetailsBloc.getWalletPaymentMethod();
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        SafeArea(
          top: false,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: _kReserveAgainPadding),
            children: [
              _getBookingStatus(),
              const SizedBox(height: kSize16),
              _getRoomInfo(),
              _getRoomDetails(),
              if (_hotelBookingDetailsBloc.state.data!.addonsList != null &&
                  _hotelBookingDetailsBloc.state.data!.addonsList!.isNotEmpty)
                _getAddonList(),
              const SizedBox(
                height: kSize16,
              ),
              if (_hotelBookingDetailsBloc.state.data!.hotelBenfits.isNotEmpty)
                _getSpecialPromotionsData(),
              if (_hotelBookingDetailsBloc
                      .state.data?.freeFoodPromotions.isNotEmpty ??
                  false) ...[
                _getPrivileges(),
                const Padding(
                  padding: kPaddingAll24,
                  child: OtaHorizontalDivider(
                    dividerColor: AppColors.kGrey10,
                  ),
                ),
              ],
              Offstage(
                offstage: _hotelBookingDetailsBloc
                    .state.data!.cancellationPolicyList!.isEmpty,
                child: _getCancellationPolicy(),
              ),
              if (_hotelBookingDetailsBloc
                  .state.data!.cancellationPolicyList!.isNotEmpty)
                const Padding(
                  padding: kPaddingHori24,
                  child: OtaHorizontalDivider(
                    dividerColor: AppColors.kGrey10,
                  ),
                ),
              const SizedBox(
                height: kSize16,
              ),
              _getPaymentStatus(),
              _getPaymentDetails(
                  walletPaymentModel != null, walletPaymentModel?.amount),
              const Padding(
                padding: kPaddingHori24,
                child: OtaHorizontalDivider(
                  dividerColor: AppColors.kGrey10,
                  height: kSize32,
                ),
              ),
              getCardWidget(
                  walletPaymentModel?.name, walletPaymentModel != null),
              const Padding(
                padding: kPaddingHori24,
                child: OtaHorizontalDivider(
                  dividerColor: AppColors.kGrey10,
                  height: kSize24,
                ),
              ),
              Offstage(
                offstage: _hotelBookingDetailsBloc.state.data!.bookingType !=
                            HotelBookingType.canceledBookings &&
                        _hotelBookingDetailsBloc.state.data!.activityStatus !=
                            ActivityStatus.userCancelled ||
                    _hotelBookingDetailsBloc.state.data!.activityStatus ==
                        ActivityStatus.paymentFailed,
                child: _getRefundDetailsWidget(),
              ),
              Offstage(
                offstage: _hotelBookingDetailsBloc.state.data!.bookingType ==
                        HotelBookingType.canceledBookings ||
                    _hotelBookingDetailsBloc.state.data!.activityStatus ==
                        ActivityStatus.paymentFailed ||
                    _hotelBookingDetailsBloc.state.data!.activityStatus ==
                        ActivityStatus.userCancelled ||
                    _hotelBookingDetailsBloc.state.data!.activityStatus ==
                        ActivityStatus.hotelRejected,
                child: _getRobinhoodContact(),
              ),
              Offstage(
                offstage: _hotelBookingDetailsBloc.state.data!.bookingType ==
                    HotelBookingType.canceledBookings,
                child: const SizedBox(
                  height: kSize24,
                ),
              ),
            ],
          ),
        ),
        Offstage(
          offstage: _hotelBookingDetailsBloc.state.data?.bookingType ==
              HotelBookingType.ongoingBooking,
          child: SafeArea(child: _getBottomBar(context)),
        ),
      ],
    );
  }

  Widget _getBookingStatus() {
    return Padding(
      padding: kPaddingHori24,
      child: HotelBookingDetailsBookingStatus(
        referenceId: _hotelBookingDetailsBloc.state.data!.referenceId,
        bookingId: _hotelBookingDetailsBloc.state.data!.bookingId,
        activityStatus: _getBookingStatusString(
            _hotelBookingDetailsBloc.state.data?.activityStatus ??
                ActivityStatus.none,
            argument!),
        state: _hotelBookingDetailsBloc.state.data?.activityStatus ??
            ActivityStatus.none,
      ),
    );
  }

  String _getBookingStatusString(
      ActivityStatus activityStatus, HotelBookingDetailArgument argument) {
    if (activityStatus == ActivityStatus.userCancelled) {
      return (argument.activityStatus != null
                  ? argument.activityStatus!
                  : _getStatus(
                      _hotelBookingDetailsBloc.state.data!.activityStatus))
              .addTrailingSpace() +
          _getCancellationDate(
              _hotelBookingDetailsBloc.state.data!.cancellationDate!);
    } else {
      return _getStatus(_hotelBookingDetailsBloc.state.data!.activityStatus);
    }
  }

  String _getCancellationDate(String? date) {
    if (date == null) return '';
    return Helpers.getddMMMyyyy(Helpers().parseDateTime(date));
  }

  String _getStatus(ActivityStatus activityStatus) {
    switch (activityStatus) {
      case ActivityStatus.bookingSuccess:
        return getTranslated(context, AppLocalizationsStrings.activitySuccess);
      case ActivityStatus.completed:
        return getTranslated(context, AppLocalizationsStrings.completedLabel);
      case ActivityStatus.hotelRejected:
        return getTranslated(
            context, AppLocalizationsStrings.activityHotelRejected);
      case ActivityStatus.paymentFailed:
        return getTranslated(
            context, AppLocalizationsStrings.activityPaymentFailed);
      case ActivityStatus.userCancelled:
        return getTranslated(
            context, AppLocalizationsStrings.activityUserCancelledOn);
      case ActivityStatus.paymentPending:
        return getTranslated(
            context, AppLocalizationsStrings.activityPaymentPending);
      case ActivityStatus.awaitingCancellation:
        return getTranslated(
            context, AppLocalizationsStrings.activityAwaitingCancellation);
      case ActivityStatus.awaitingConfirmation:
        return getTranslated(
            context, AppLocalizationsStrings.activityAwaitingConfirmation);
      default:
        return '';
    }
  }

  Widget _getRoomInfo() {
    return Padding(
      padding: kPaddingHori24,
      child: HotelBookingDetailsRoomInfoWidget(
        facilityMap: _hotelBookingDetailsBloc.state.data?.facilityMap,
        imageUrl: _hotelBookingDetailsBloc.state.data?.imageUrl,
        offerName: _hotelBookingDetailsBloc.state.data?.getOfferName(),
        pricePerNight: _hotelBookingDetailsBloc.state.data?.pricePerNight,
        propertyName: _hotelBookingDetailsBloc.state.data?.propertyName,
        roomDetailsList: _hotelBookingDetailsBloc.state.data?.roomDetailsList,
        starRating: _hotelBookingDetailsBloc.state.data?.starRating ?? 0,
        address: _hotelBookingDetailsBloc.state.data?.address,
        phoneNumber: _hotelBookingDetailsBloc.state.data?.phoneNumber,
        latitude: double.tryParse(
                _hotelBookingDetailsBloc.state.data!.latitude ?? "0.0") ??
            0.0,
        longitude: double.tryParse(
                _hotelBookingDetailsBloc.state.data!.longitude ?? "0.0") ??
            0.0,
      ),
    );
  }

  Widget _getRoomDetails() {
    return OtaReservationDetailsWidget(
      padding: kPaddingHori24,
      checkInDate: Helpers()
          .parseDateTime(_hotelBookingDetailsBloc.state.data!.checkInDate),
      checkOutDate: Helpers()
          .parseDateTime(_hotelBookingDetailsBloc.state.data!.checkOutDate),
      numberOfNights:
          int.tryParse(_hotelBookingDetailsBloc.state.data!.numberOfNights) ??
              0,
      numberOfRooms: _hotelBookingDetailsBloc.state.data!.getRoomCount(),
      numberOfAdults: _hotelBookingDetailsBloc.state.data!.getAdultCount(),
      numberOfChildren: _hotelBookingDetailsBloc.state.data!.getChildCount(),
      guestName: getGuestName(_hotelBookingDetailsBloc.state.data!.firstName,
          _hotelBookingDetailsBloc.state.data!.lastName),
    );
  }

  String getGuestName(String firstName, String lastName) {
    if (firstName.isEmpty && lastName.isEmpty) return "";
    return (firstName.addTrailingSpace() + lastName).trim();
  }

  Widget _getAddonList() {
    List<HotelBookingDetailsAddons>? models =
        _hotelBookingDetailsBloc.state.data!.addonsList;
    return Padding(
      padding: kPaddingHori24,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return OtaHotelAddonServiceTile(
            name: models!.elementAt(index).serviceName ?? "",
            price: double.tryParse(models.elementAt(index).cost ?? "0") ?? 0,
            currency: AppConfig().currency,
            quantity: models.elementAt(index).quantity!,
            requestDate: models.elementAt(index).selectedDate ?? DateTime.now(),
            showHeader: index == 0 ? true : false,
            isEditAvailable: false,
            isAddItemsAvailable: false,
          );
        },
        itemCount: models!.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }

  Widget _getPrivileges() {
    return Padding(
      padding: kPaddingHori24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated(context, AppLocalizationsStrings.robinhoodPrivileges),
            style: AppTheme.kHeading1Medium,
          ),
          const SizedBox(
            height: kSize16,
          ),
          OtaFreeFoodBannerWidget(
              freeFoodPromotionList:
                  _hotelBookingDetailsBloc.state.data!.freeFoodPromotions),
        ],
      ),
    );
  }

  Widget _getCancellationPolicy() {
    return Padding(
      padding: kPaddingHori24,
      child: Column(
        children: [
          OtaCancellationPolicyListWidget(
              cancellationPolicyModel:
                  _hotelBookingDetailsBloc.state.data?.cancellationPolicyList),
        ],
      ),
    );
  }

  _getPaymentDetails(bool isWalletAvailable, String? walletAmount) {
    return HotelBookingDetailPaymentList(
      discountAmount: _hotelBookingDetailsBloc.state.data!.discountAmount ?? 0,
      grandTotal: (_hotelBookingDetailsBloc.state.data!.bookingType ==
                  HotelBookingType.canceledBookings &&
              _hotelBookingDetailsBloc
                      .state.data!.grandTotalWithCancellationCharges !=
                  null)
          ? _hotelBookingDetailsBloc
              .state.data!.grandTotalWithCancellationCharges!
          : _hotelBookingDetailsBloc.state.data!.grandTotal,
      totalRoomPrice: _hotelBookingDetailsBloc.state.data!.totalRoomPrice,
      totalServicePrice: _hotelBookingDetailsBloc.state.data!.totalServicePrice,
      appliedPromo: _hotelBookingDetailsBloc.state.data!.appliedPromo,
      isWalletAvailable: isWalletAvailable,
      walletAmount: walletAmount,
    );
  }

  _getPaymentStatus() {
    return Padding(
      padding: kPaddingHori24,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        HotelBookingDetailsPaymentStatus(
          paymentStatus:
              _hotelBookingDetailsBloc.state.data?.paymentStatus ?? "",
        ),
        const OtaHorizontalDivider(
            dividerColor: AppColors.kGrey10, height: kSize32),
      ]),
    );
  }

  Widget _getRobinhoodContact() {
    return BookingDetailsWidget(
      activityStatus: _hotelBookingDetailsBloc.state.data?.activityStatus,
      cancellationPolicyList:
          _hotelBookingDetailsBloc.state.data?.cancellationPolicyList,
      onTap: () {
        _navigateToCancellationScreen();
      },
      onMessageTap: () => _openHotelBookingMailerScreen(),
      isDisabled: _isBookingDetailWidgetDisabled(),
      isDisableCancellation: _isBookingCancellationDisabled(),
    );
  }

  bool _isBookingDetailWidgetDisabled() {
    return !(_hotelBookingDetailsBloc.state.data!.hotelBookingStatus ==
                HotelBookingStatus.bookingConfirmed &&
            _hotelBookingDetailsBloc.state.data!.bookingType ==
                HotelBookingType.ongoingBooking &&
            _hotelBookingDetailsBloc.state.data!.activityStatus ==
                ActivityStatus.bookingSuccess ||
        _hotelBookingDetailsBloc.state.data!.activityStatus ==
            ActivityStatus.paymentPending ||
        _hotelBookingDetailsBloc.state.data!.activityStatus ==
            ActivityStatus.awaitingConfirmation ||
        _hotelBookingDetailsBloc.state.data!.activityStatus ==
            ActivityStatus.awaitingCancellation);
  }

  bool _isBookingCancellationDisabled() {
    if (_hotelBookingDetailsBloc.state.data!.activityStatus ==
            ActivityStatus.paymentPending ||
        _hotelBookingDetailsBloc.state.data!.activityStatus ==
            ActivityStatus.awaitingConfirmation ||
        _hotelBookingDetailsBloc.state.data!.activityStatus ==
            ActivityStatus.awaitingCancellation) {
      return true;
    }

    /// ongoingBooking & payment using card & enabled only when
    /// the current date >= card payment confirm date + 1 and current date < checkout date
    return !(_hotelBookingDetailsBloc.state.data!.bookingType ==
            HotelBookingType.ongoingBooking) &&
        (_hotelBookingDetailsBloc.state.data!.activityStatus ==
            ActivityStatus.bookingSuccess);
  }

  _navigateToCancellationScreen() async {
    final data = await Navigator.pushNamed(
      context,
      AppRoutes.hotelBookingCancellationScreen,
      arguments: HotelBookingCancellationArgumentViewModel(
        cancellationPolicyList:
            _hotelBookingDetailsBloc.state.data?.cancellationPolicyList,
        confirmNo: _hotelBookingDetailsBloc.state.data!.bookingId,
        bookingUrn: _hotelBookingDetailsBloc.state.data!.bookingUrn,
        bookingStatus: argument?.bookingStatus ?? '',
      ),
    );
    _updateArgument(data);
  }

  _updateArgument(Object? data) {
    if (data is HotelBookingDetailArgument) {
      if (data.cancellationStatus != null) {
        if (data.cancellationStatus == CancellationStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            OtaBanner().showMaterialBanner(
              context,
              getTranslated(
                  context, AppLocalizationsStrings.cancelSuccessMessage),
              AppColors.kSystemSuccess,
              _kCheckIcon,
              bannerHeight: kSize72,
              crossAxisAlignment: CrossAxisAlignment.start,
            );
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            OtaBanner().showMaterialBanner(
              context,
              getTranslated(
                  context, AppLocalizationsStrings.cancelFailureMessage),
              AppColors.kSystemWrong,
              _kExclamationIcon,
              bannerHeight: kSize72,
              crossAxisAlignment: CrossAxisAlignment.start,
            );
          });
        }
      }
      argument = data;
      _refreshHotelBookingDetailsData(data: data);
    }
  }

  Widget defaultWidget() {
    return HotelBookingsNetworkErrorWidget(
      height: MediaQuery.of(context).size.height - kSize200,
      onRefresh: () async =>
          await _refreshHotelBookingDetailsData(data: argument),
    );
  }

  Widget loadIngWidget() {
    return const OTALoadingIndicator();
  }

  Widget failureState() {
    return HotelBookingsNetworkErrorWidget(
      height: MediaQuery.of(context).size.height - kSize200,
      onRefresh: () async =>
          await _refreshHotelBookingDetailsData(data: argument),
    );
  }

  Widget getCardWidget(String? walletName, bool isWalletAvailable) {
    return Container(
      color: AppColors.kLight100,
      child: Column(
        children: [
          Padding(
            padding: kPaddingHori24,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                getTranslated(
                    context, AppLocalizationsStrings.paymentMethodsPaymentMain),
                style: AppTheme.kBodyMedium,
              ),
            ),
          ),
          isWalletAvailable && OtaServiceEnabledHelper.isWalletEnabled()
              ? OtaWalletWidget(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSize24, vertical: kSize14),
                  walletTitle: walletName,
                )
              : const SizedBox.shrink(),
          if (_hotelBookingDetailsBloc.getPaymentMethod() != null)
            HotelPaymentCardItem(
              cardName:
                  _hotelBookingDetailsBloc.getPaymentMethod()?.cardNickName ??
                      '',
              cardNumber:
                  _hotelBookingDetailsBloc.getPaymentMethod()?.cardNumber ?? "",
              paymentType: _hotelBookingDetailsBloc
                  .getPaymentMethod()
                  ?.paymentMethodType,
              padding: const EdgeInsets.symmetric(
                  horizontal: kSize24, vertical: kSize6),
            ),
        ],
      ),
    );
  }

  Widget _getRefundDetailsWidget() {
    return Padding(
      padding:
          const EdgeInsets.only(left: kSize24, right: kSize24, bottom: kSize34),
      child: Column(
        children: [
          BookingDetailsRefundWidget(
            showHeader: true,
            netPrice: _hotelBookingDetailsBloc.state.data?.grandTotal,
            operationFee: _hotelBookingDetailsBloc.state.data?.amountAdminfee,
            cancellationFee:
                _hotelBookingDetailsBloc.state.data?.amountCancelCharge,
            totalRefund: _hotelBookingDetailsBloc.state.data?.getTotalRefund(),
          ),
        ],
      ),
    );
  }

  Widget _getBottomBar(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: kSize20),
          child: OtaTextButton(
            title: getTranslated(context, AppLocalizationsStrings.reserveAgain),
            key: const Key("ReserveAgainButton"),
            textHorizontalPadding: kSize40,
            onPressed: () {
              openHotelDetailScreen();
            },
          ),
        ),
      );

  void openHotelDetailScreen() {
    final hotelArgument = HotelDetailArgument.getDefaulArgument(
      _hotelBookingDetailsBloc.state.data!.hotelId,
      _hotelBookingDetailsBloc.state.data!.cityId,
      _hotelBookingDetailsBloc.state.data!.countryId,
    );
    Navigator.pushNamed(context, AppRoutes.hotelDetail,
        arguments: hotelArgument);
  }

  void _getAddOnData(List<HotelBookingDetailsAddons>? models) {
    double price = 0.0;
    double addonCost = 0.0;
    int quantity = 0;
    if (models == null) {
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelcancellationRequestEvent,
          key: HotelCancellationRequestAppFlyer.hotelEnhancement,
          value: "No");

      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelcancellationRequestEvent,
          key: HotelCancellationRequestAppFlyer.hotelEnhancementPrice,
          value: 0.0);
    } else if (models.isEmpty) {
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelcancellationRequestEvent,
          key: HotelCancellationRequestAppFlyer.hotelEnhancement,
          value: "No");

      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelcancellationRequestEvent,
          key: HotelCancellationRequestAppFlyer.hotelEnhancementPrice,
          value: 0.0);
    } else {
      for (int i = 0; i < models.length; i++) {
        addonCost = double.tryParse(models[i].cost ?? "0.0") ?? 0.0;

        quantity = int.tryParse(models[i].quantity ?? "0") ?? 0;
        addonCost = addonCost * quantity;
        price += addonCost;
      }
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelcancellationRequestEvent,
          key: HotelCancellationRequestAppFlyer.hotelEnhancement,
          value: "Yes");

      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelcancellationRequestEvent,
          key: HotelCancellationRequestAppFlyer.hotelEnhancementPrice,
          value: price);
    }
  }

  Widget _getSpecialPromotionsData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OtaRoomSpecialPromotionWidget(
            padding: const EdgeInsets.only(top: kSize8),
            header: getTranslated(
                context, AppLocalizationsStrings.specialPromotionBooking),
            bottomDetail: getTranslated(
                context, AppLocalizationsStrings.promotionTNCbooking),
            specialPromotionList:
                _hotelBookingDetailsBloc.state.data!.hotelBenfits,
          ),
          const OtaHorizontalDivider(
            dividerColor: AppColors.kGrey10,
            height: kSize1,
          ),
          const SizedBox(
            height: kSize24,
          ),
        ],
      ),
    );
  }

  void _getAppFlyerEvent() {
    int result = Helpers.daysBetween(
        start: _hotelBookingDetailsBloc.state.data!.checkInDate,
        end: _hotelBookingDetailsBloc.state.data!.checkOutDate);

    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.hotelId,
        value: _hotelBookingDetailsBloc.state.data!.hotelId);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.hotelStar,
        value: _hotelBookingDetailsBloc.state.data?.starRating ?? 0);

    AppFlyerHelper.addCommaSeparatedList(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.roomClass,
        value: _hotelBookingDetailsBloc.state.data?.roomDetailsList
            .map((e) => e.roomCatName)
            .toList());

    AppFlyerHelper.addCommaSeparatedList(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        value: _hotelBookingDetailsBloc.state.data?.roomDetailsList
            .map((e) => e.roomCode)
            .toList(),
        key: HotelCancellationRequestAppFlyer.roomId);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent);

    AppFlyerHelper.addCommaSeparatedList(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        value: _hotelBookingDetailsBloc.state.data!.freeFoodPromotions
            .map((e) => e.line1)
            .toList(),
        key: HotelCancellationRequestAppFlyer.promoType);

    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.promoCode,
        value: _hotelBookingDetailsBloc
            .state.data!.appliedPromo?.promotion.promotionCode);

    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.promoAmount,
        value: _hotelBookingDetailsBloc
            .state.data!.appliedPromo?.priceViewModel?.effectiveDiscount);

    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.roomPrice,
        value: _hotelBookingDetailsBloc.state.data?.pricePerNight);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.checkInDate,
        value: _hotelBookingDetailsBloc.state.data!.checkInDate);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.checkOutDate,
        value: _hotelBookingDetailsBloc.state.data!.checkOutDate);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.stayPeriod,
        value: result);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.numberOfAdult,
        value: _hotelBookingDetailsBloc.state.data!.getAdultCount());
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.numberOfChild,
        value: _hotelBookingDetailsBloc.state.data!.getChildCount());
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.reservationId,
        value: _hotelBookingDetailsBloc.state.data!.bookingId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.paymentType,
        value: _hotelBookingDetailsBloc.getPaymentMethod()?.cardType);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.currency,
        value: AppConfig().currency);
    _getAddOnData(_hotelBookingDetailsBloc.state.data?.addonsList);
  }
}
