import 'package:flutter/material.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_cancellation_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_special_promotion_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_booking_mailer/view/car_booking_mailer_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/bloc/car_booking_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view/widget/car_details_view/mandatory_services.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_argument_model.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view/widget/car_custom_error_widget.dart';
import 'package:ota/modules/car_rental/car_reservation/helpers/car_app_flyer_helper.dart';

import '../../car_reservation/view/widgets/car_reservation_network_error_with_refresh.dart';
import 'widget/additional_services.dart';
import 'widget/bottom_function.dart';
import 'widget/car_booking_detail_next_button.dart';
import 'widget/car_booking_header_detail.dart';
import 'widget/car_details_view/cancelation_policy.dart';
import 'widget/car_details_view/car_detail_view.dart';
import 'widget/car_details_view/car_details_view_controller.dart';
import 'widget/car_rental_detail.dart';
import 'widget/payment_detail.dart';
import 'widget/refund_detail.dart';

const double _kTopHeight = 180;
const String _kCheckIcon = "assets/images/icons/uil_check-circle.svg";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";
const String _kBookingDetailListKey = "booking_detail_list_key";
const String _kReserveAgainKey = "reserve_again_key";
const String _kserviceName = "CARRENTAL";
const String kNetworkError = "assets/images/icons/network_error_image.svg";

class CarBookingDetail extends StatefulWidget {
  const CarBookingDetail({Key? key}) : super(key: key);

  @override
  CarBookingDetailState createState() => CarBookingDetailState();
}

class CarBookingDetailState extends State<CarBookingDetail> {
  CarBookingDetailArgumentModel? _argumentModel;
  final CarBookingDetailBloc _carBookingDetailBloc = CarBookingDetailBloc();
  final CarDetailsViewController _carDetailsViewController =
      CarDetailsViewController();
  final CarDetailsViewController _cancellationViewController =
      CarDetailsViewController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.carCancellationEvent);
      _argumentModel = ModalRoute.of(context)?.settings.arguments
          as CarBookingDetailArgumentModel;
      _requestCarBookingDeatilData();
    });
    _carBookingDetailBloc.stream.listen((event) {
      if (_carBookingDetailBloc.state.pageState ==
          CarBookingDetailPageState.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
  }

  Future<void> _requestCarBookingDeatilData() async {
    _carBookingDetailBloc.getCarBookingDetailData(arguments: _argumentModel);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: OtaAppBar(
          title: getTranslated(
              context, AppLocalizationsStrings.carReservationSummary),
          onLeftButtonPressed: _onWillPop,
        ),
        body: BlocBuilder(
          bloc: _carBookingDetailBloc,
          builder: () {
            return _buildStateView();
          },
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    NavigatorHelper.shouldSystemPop(context,
        arguments: _carBookingDetailBloc
            .state.bookingDetail?.bookingStatus.getCarBookingStatusValue);
    return false;
  }

  Widget _buildStateView() {
    switch (_carBookingDetailBloc.state.pageState) {
      case CarBookingDetailPageState.loading:
        return const OTALoadingIndicator();
      case CarBookingDetailPageState.failure:
      case CarBookingDetailPageState.failureNetwork:
        return _buildNoInternetWidgetWithRefresh();
      case CarBookingDetailPageState.noData:
        return CarCustomErrorWidgetWithRefresh(
          onRefresh: () => _requestCarBookingDeatilData(),
          height: MediaQuery.of(context).size.height - _kTopHeight,
          errorTextHeader:
              getTranslated(context, AppLocalizationsStrings.sorry),
          errorTextFooter: getTranslated(
              context, AppLocalizationsStrings.carErrorInfoNotAvailable),
        );
      case CarBookingDetailPageState.success:
        return _buildSuccessView();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildNoInternetWidgetWithRefresh() {
    return Padding(
      padding: const EdgeInsets.only(top: kSize24),
      child: Material(
        child: CarReservationNetworkErrorWidgetWithRefresh(
          imageUrl: kNetworkError,
          height: MediaQuery.of(context).size.height - _kTopHeight,
          onRefresh: () async {
            await _requestCarBookingDeatilData();
          },
        ),
      ),
    );
  }

  Widget _buildSuccessView() {
    return SafeArea(
      top: false,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ListView(
            key: const Key(_kBookingDetailListKey),
            padding: const EdgeInsets.symmetric(horizontal: kSize24),
            children: [
              CarBookingDetailHeader(
                carBookingDetailBloc: _carBookingDetailBloc,
              ),
              CarDetailView(
                carBookingDetailBloc: _carBookingDetailBloc,
                carDetailsViewController: _carDetailsViewController,
              ),
              CarRentalDetail(
                carBookingDetailBloc: _carBookingDetailBloc,
              ),
              MandatoryServices(
                carBookingDetailBloc: _carBookingDetailBloc,
              ),
              AdditionalServices(
                carBookingDetailBloc: _carBookingDetailBloc,
              ),
              OtaSpecialPromotionWidget(
                allowLateReturn: _carBookingDetailBloc.state.bookingDetail
                        ?.carBookingDetails?.allowLateReturn ??
                    0,
              ),
              if (_carBookingDetailBloc.state.bookingDetail?.promotionList !=
                      null &&
                  _carBookingDetailBloc
                      .state.bookingDetail!.promotionList.isNotEmpty) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OtaHorizontalDivider(
                      dividerColor: AppColors.kGrey10,
                    ),
                    const SizedBox(height: kSize24),
                    Text(
                      getTranslated(context,
                          AppLocalizationsStrings.carRobinhoodSpecialOffer),
                      style: AppTheme.kHeading1Medium,
                    ),
                    const SizedBox(height: kSize16),
                    OtaFreeFoodBannerWidget(
                        freeFoodPromotionList: _carBookingDetailBloc
                            .state.bookingDetail!.promotionList),
                    const SizedBox(height: kSize24),
                  ],
                ),
              ],
              CarDetailNextButton(
                headerTitle: AppLocalizationsStrings.includeLabel,
                style: AppTheme.kHeading1Medium,
                onPress: () => _goToCarDetailMoreInfo(
                    CarDetailMoreInfoPickType.includedInRentalPrice),
              ),
              CarDetailNextButton(
                style: AppTheme.kHeading1Medium,
                headerTitle: AppLocalizationsStrings.carRentalConditionsLabel,
                onPress: () => _goToCarDetailMoreInfo(
                    CarDetailMoreInfoPickType.carRentalCondition),
              ),
              CarDetailNextButton(
                style: AppTheme.kHeading1Medium,
                headerTitle: AppLocalizationsStrings.pickupConditionsLabel,
                onPress: () =>
                    _goToCarDetailMoreInfo(CarDetailMoreInfoPickType.pickUp),
              ),
              CarBookingDetailCancellationPolicy(
                carBookingDetailBloc: _carBookingDetailBloc,
                carDetailsViewController: _cancellationViewController,
              ),
              PaymentDetail(
                carBookingDetailBloc: _carBookingDetailBloc,
              ),
              RefundDetail(
                carBookingDetailBloc: _carBookingDetailBloc,
              ),
              BottomFunction(
                carBookingDetailBloc: _carBookingDetailBloc,
                onCancelTap: () => _navigateToCancelBookingScreen(),
                onMessageTap: () => _navigateToMailerScreen(),
              ),
              if (!_carBookingDetailBloc.isOngoingBooking)
                SizedBox(
                  height: kSize40 +
                      (MediaQuery.of(context).padding.bottom > kSize0
                          ? kSize0
                          : kSize24),
                )
            ],
          ),
          if (!_carBookingDetailBloc.isOngoingBooking)
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom > kSize0
                      ? kSize0
                      : kSize24),
              child: OtaTextButton(
                key: const Key(_kReserveAgainKey),
                title: getTranslated(
                    context, AppLocalizationsStrings.reserveAgain),
                onPressed: () => _navigateToCarDetailScreen(),
              ),
            )
        ],
      ),
    );
  }

  _navigateToCancelBookingScreen() async {
    _getAppFlyerParameters();
    var data = await Navigator.pushNamed(
      context,
      AppRoutes.carBookingCancellation,
      arguments: CarBookingCancellationArgumentViewModel(
          bookingUrn:
              _carBookingDetailBloc.state.bookingDetail?.bookingUrn ?? '',
          confirmNo: _carBookingDetailBloc.state.bookingDetail?.bookingId ?? '',
          cancellationPolicyList: _carBookingDetailBloc
                  .state.bookingDetail?.carBookingDetails?.cancellationPolicy ??
              [],
          cancellationPolicyDescription: getTranslated(
              context, AppLocalizationsStrings.carCancelPolicyConfigLine),
          pickUpDate: _carBookingDetailBloc
              .state.bookingDetail?.carBookingDetails?.pickUpDate),
    );
    if (data != null) {
      _showPopuoBanner(data as bool);
    }
  }

  _showPopuoBanner(bool isBookingCancel) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        OtaBanner().showMaterialBanner(
          context,
          getTranslated(
              context,
              isBookingCancel
                  ? AppLocalizationsStrings.cancelSuccessMessage
                  : AppLocalizationsStrings.cancelFailureMessage),
          isBookingCancel ? AppColors.kSystemSuccess : AppColors.kSystemWrong,
          isBookingCancel ? _kCheckIcon : _kExclamationIcon,
        );
      },
    );
    if (isBookingCancel) {
      _requestCarBookingDeatilData();
    }
  }

  void _goToCarDetailMoreInfo(
      CarDetailMoreInfoPickType carDetailMoreInfoPickType) {
    CarBookingDetailModel? carBookingDetails =
        _carBookingDetailBloc.state.bookingDetail?.carBookingDetails;
    Navigator.of(context).pushNamed(
      AppRoutes.carDetailMoreInfoScreen,
      arguments: CarDetailMoreInfoArgumentModel(
        carRentalConditionHtmlText:
            carBookingDetails?.carRentalConditionsInfo ?? '',
        includedInRentalPriceHtmlText: carBookingDetails?.includesInfo ?? '',
        pickUpHtmlText: carBookingDetails?.pickupConditionsInfo ?? '',
        carDetailMoreInfoPickType: carDetailMoreInfoPickType,
      ),
    );
  }

  _navigateToMailerScreen() async {
    Navigator.pushNamed(context, AppRoutes.carBookingMailerScreen,
        arguments: CarBookingMailerArgumentModel(
            bookingUrn: _carBookingDetailBloc.state.bookingDetail?.bookingUrn,
            bookingConfirmNo:
                _carBookingDetailBloc.state.bookingDetail?.bookingId,
            serviceName: _kserviceName));
  }

  _navigateToCarDetailScreen() {
    CarBookingDetailModel? carBookingDetails =
        _carBookingDetailBloc.state.bookingDetail?.carBookingDetails;
    Navigator.of(context).pushNamed(
      AppRoutes.carDetailScreen,
      arguments: CarDetailArgumentModel(
        carId: carBookingDetails?.car?.carId ?? '',
        pickupLocationId: carBookingDetails?.pickupCounter?.locationId ?? "",
        returnLocationId: carBookingDetails?.returnCounter?.locationId ?? "",
        pickupDate: Helpers.getOnlyDateFromDateTime(DateTime.now()).add(
          Duration(
            days: AppConfig().configModel.pickUpDeltaCar,
            hours: 10,
          ),
        ),
        returnDate: Helpers.getOnlyDateFromDateTime(DateTime.now()).add(
          Duration(
            days: AppConfig().configModel.dropOffDeltaCar,
            hours: 10,
          ),
        ),
        supplierId: carBookingDetails?.supplier?.id ?? "",
        includeDriver: AppConfig().configModel.includeDriver,
        currency: AppConfig().currency,
        rentalType: AppConfig().rentalType,
        age: AppConfig().configModel.carDriverDefaultAge,
        pickupCounter: _carBookingDetailBloc
                .state.bookingDetail?.carBookingDetails?.pickupCounter?.id ??
            "",
        returnCounter: _carBookingDetailBloc
                .state.bookingDetail?.carBookingDetails?.returnCounter?.id ??
            "",
        userType: getLoginProvider().userType.getCarDetailType(),
        cityName: carBookingDetails?.pickupCounter?.name ?? '',
      ),
    );
  }

  String? _getIndividualPromotionCode() {
    List<OtaFreeFoodPromotionModel>? promotionList =
        _carBookingDetailBloc.state.bookingDetail?.promotionList ?? [];
    for (OtaFreeFoodPromotionModel promotion in promotionList) {
      return promotion.promotionCode;
    }
    return '';
  }

  void _getAppFlyerParameters() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carId,
        value: _carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.car?.carId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carAgencyId,
        value: _carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.supplier?.id);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carNoOfPassengers,
        value: _carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.car?.seatNbr);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carPromoCode,
        value: _getIndividualPromotionCode());
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carLocation,
        value: _carBookingDetailBloc.state.bookingDetail?.carBookingDetails
            ?.pickupCounter?.locationName);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carAddOnPrice,
        value: _carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.extrasOnlinePrice);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carAddOnItems,
        value: _carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.extrasCounterPrice);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carPayNowPrice,
        value: _carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.totalPrice);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carPayLaterPrice,
        value: _carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.extrasCounterPrice);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carRentalPrice,
        value: _carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.netPrice);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carRentalPeriod,
        value: _carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.rentalDays);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carPickUpDate,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: _carBookingDetailBloc
                .state.bookingDetail?.carBookingDetails?.pickUpDate));
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carReturnDate,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: _carBookingDetailBloc
                .state.bookingDetail?.carBookingDetails?.dropOffDate));
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.carCancellationEvent);
  }
}
