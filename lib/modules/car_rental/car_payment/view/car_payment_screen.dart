import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_click_payment_event_parameters.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_payment_success_first_order_parameters.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_payment_success_purchase_order.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_special_promotion_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/bloc/promo_widget_bloc.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_click_payment_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_payment_promo_error_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_rental_payment_success_parameters.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_payment/bloc/car_payment_bloc.dart';
import 'package:ota/modules/car_rental/car_payment/helper/car_payment_helper.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_additional_services.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_cancellation_policy_list.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_car_info.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_list_summary.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_mandatory_addon_service.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/helpers/car_app_flyer_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';
import 'package:ota/modules/hotel/hotel_payment/channels/ota_payment_details.dart';
import 'package:ota/modules/hotel/hotel_payment/view/widgets/hotel_payment_header_widget.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:provider/provider.dart';

import '../../../../channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';
import '../../../../channels/payment_management_invoke/usecases/payment_management_use_cases.dart';
import '../../../../common/utils/app_theme.dart';
import '../../../../common/utils/helper.dart';
import '../../../../common/utils/scb_easy_helper.dart';
import '../../../../core/app_config.dart';
import '../../../../core/app_routes.dart';
import '../../../../core_components/bloc/bloc_builder.dart';
import '../../../../core_pack/custom_widgets/ota_alert_dialog.dart';
import '../../../../core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import '../../../../core_pack/custom_widgets/ota_countdown_timer/ota_countdown_timer.dart';
import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import '../../../../core_pack/custom_widgets/ota_icon_button.dart';
import '../../../../core_pack/custom_widgets/ota_virtual_wallet/bloc/virtual_payment_bloc.dart';
import '../../../authentication/helper/auth_navigtor_helper.dart';
import '../../../authentication/model/login_model.dart';
import '../../../hotel/hotel_payment/bloc/payment_method_bloc.dart';
import '../../../hotel/hotel_payment/view/widgets/hotel_payment_card_item.dart';
import '../../../hotel/hotel_payment/view_model/payment_method_list_view_model.dart';
import '../../../hotel/hotel_payment/view_model/payment_method_type.dart';
import '../../../payment_method/view_model/payment_initiate_argument_model.dart';
import '../../car_reservation/view/widgets/car_reservation_network_error_with_refresh.dart';
import '../../car_reservation/view_model/car_reservation_add_on_view_model.dart';
import '../view_model/car_payment_argument_view_model.dart';

const double _kTopTimerPadding = 40.0;
const double _kCardBottomSpacing = 100.0;
const _kTopHeight = 180;

const double _kSize = kSize34;
const String _kServiceType = 'CARRENTAL';
const String _kPayWise = 'PAYWISE';
const String _kCard = 'CARD';
const String _arrowRight = "assets/images/icons/arrow_right.svg";
const String kNetworkError = "assets/images/icons/network_error_image.svg";
const String _kPickupDropOffDetailsButton = 'PickupDropoffDetailsButton';
const String _kWallet = 'WALLET';
const String _kVa = 'VA';

class CarPaymentMainScreen extends StatefulWidget {
  const CarPaymentMainScreen({Key? key}) : super(key: key);

  @override
  CarPaymentMainScreenState createState() => CarPaymentMainScreenState();
}

class CarPaymentMainScreenState extends State<CarPaymentMainScreen> {
  OtaCountDownController? _otaCountDownController;
  CarPaymentArgumentModel? _carPaymentArgumentModel;
  CarPaymentArgumentModel? argument;
  final CarPaymentBloc _carPaymentBloc = CarPaymentBloc();
  final PaymentMethodBloc _paymentMethodBloc = PaymentMethodBloc();
  final VirtualPaymentBloc _virtualPaymentBloc = VirtualPaymentBloc();

  final PaymentManagementUseCases paymentManagementUseCases =
      PaymentManagementUseCasesImpl();
  String _initialPaymentBookingUrn = '';
  final SuperAppToOtaPayment superAppToOtaPayment = SuperAppToOtaPayment();
  final PromoWidgetBloc _promoWidgetBloc = PromoWidgetBloc();
  PromoWidgetViewModel? _previousPromoAppliedModel;
  AppFlyerLogger appFlyerLogger = AppFlyerLogger();
  FirebaseLogger firebaseLogger = FirebaseLogger();

  @override
  void dispose() {
    superAppToOtaPayment.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      argument =
          ModalRoute.of(context)?.settings.arguments as CarPaymentArgumentModel;
      _carPaymentBloc.loadFromArgument(argument!, context);
      superAppToOtaPayment.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
      CarClickPaymentFirebase.addOnList.clear();
      CarClickPaymentFirebase.addOnPricesList.clear();
    });
    _paymentMethodBloc.getPaymentMethodListData('');
    _carPaymentBloc.stream.listen((event) {
      if (_carPaymentBloc.state.state == CarPaymentViewModelState.loaded) {
        _launchAppFlyerViewEvent();
      }
      if (_carPaymentBloc.state.state ==
          CarPaymentViewModelState.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
    _previousPromoAppliedModel =
        Provider.of<PromoWidgetViewModel>(context, listen: false);
    _promoWidgetBloc.initPreviousAppliedPromo(_previousPromoAppliedModel);
    if (OtaServiceEnabledHelper.isWalletEnabled()) {
      _virtualPaymentBloc.getVirtualWalletBalance();
    }
  }

  void waitForReplyFromSuperApp(OtaPaymentModelChannel data) async {
    _paymentMethodBloc.setDefaultPaymentMethodFromChannel(data);
  }

  void _checkEasyAppInstalled() async {
    SCBEasyAppState result = await SCBEasyHelper.launchSCBEasyApp(context);
    switch (result) {
      case SCBEasyAppState.installInitiated:
        break;
      case SCBEasyAppState.success:
        _goToLoadingScreen();
        break;
      case SCBEasyAppState.anotherPaymentSelected:
        _onPaymentSelectionTapped();
        break;
    }
  }

  void _onPaymentSelectionTapped() async {
    LoginModel loginModel = getLoginProvider();
    await paymentManagementUseCases.invokeExampleMethod(
        methodName: "paymentManagement",
        arguments: PaymentManagementArgumentModelChannel(
          serviceType: _kServiceType,
          env: loginModel.getEnv(),
          language: loginModel.getLanguage(),
          userId: loginModel.userId,
        ));
    //TODO: This will require super app build to verify
    _paymentMethodBloc.getPaymentMethodListData("");
  }

  void _checkNetPrice() {
    bool isValidationFailed = CarPaymentHelper.isMinAmountValidationFailed(
        isWalletEnabled: _virtualPaymentBloc.isWalletOn(),
        paidByWallet: _virtualPaymentBloc.state.walletPaidAmmount,
        onlinePayableAmount: _getPayableAmountOnline());

    if (isValidationFailed) {
      OtaAlertDialog(
          errorMessage:
              getTranslated(context, AppLocalizationsStrings.netPriceLessError),
          errorTitle:
              getTranslated(context, AppLocalizationsStrings.unableToProceed),
          buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
          onPressed: () {
            Navigator.of(context).pop();
          }).showAlertDialog(context);
    } else if ((_paymentMethodBloc
                .getDefaultPaymentMethod()
                ?.paymentMethodType ??
            PaymentMethodType.scb) ==
        PaymentMethodType.scb) {
      _checkEasyAppInstalled();
    } else {
      _goToLoadingScreen();
    }
  }

  void _goToLoadingScreen() async {
    _getAppFlyerParameterForPaymentSuccessForFirstOrder();
    _getAppFlyerParameterForPaymentSuccessForPurchaseOrder();
    _getFirebaseParametersForPaymentAndPromoError(
        FirebaseEvent.carPaymentErrorEvent);
    _getFirebaseParametersForPaymentAndPromoError(
        FirebaseEvent.carAddPromoErrorEvent);
    getPaymentDataFirebase(FirebaseEvent.carBookingSuccess);
    PaymentMethodInitiateArgument paymentMethodInitiateArgument =
        PaymentMethodInitiateArgument(
      currency: AppConfig().currency,
      bookingUrn: _carPaymentArgumentModel?.bookingUrn.toString() ?? "",
      screenComingFrom: ScreenToPayment.carRental,
      otaCountDownController: _otaCountDownController,
      newbookingUrn: _initialPaymentBookingUrn,
      carPaymentArgumentModel: _carPaymentArgumentModel,
      paymentDetails: _getPaymentMethodDetails(
        paymentMethod:
            (_paymentMethodBloc.getDefaultPaymentMethod()?.paymentMethodType ??
                        PaymentMethodType.scb) ==
                    PaymentMethodType.scb
                ? _kPayWise
                : _kCard,
        cardRef: _paymentMethodBloc.getDefaultPaymentMethod()!.cardRef,
        cardType: _paymentMethodBloc
            .getDefaultPaymentMethod()!
            .paymentMethodType
            .value,
        payablePrice: _getPayableAmountOnline(),
        paymentMethodId:
            (_paymentMethodBloc.getDefaultPaymentMethod()?.paymentMethodType ??
                        PaymentMethodType.scb) ==
                    PaymentMethodType.scb
                ? ''
                : _paymentMethodBloc.getDefaultPaymentMethod()!.paymentMethodId,
        paidByWalletPrice: _virtualPaymentBloc.state.walletPaidAmmount,
      ),
    );

    final bookingUrn = await Navigator.pushNamed(
      context,
      AppRoutes.paymentLoadingScreen,
      arguments: paymentMethodInitiateArgument,
    );

    updateInitialPaymentUrn(bookingUrn);

    _otaCountDownController?.isTimeOutDisabled = false;
    if (!_otaCountDownController!.isTimerActive) {
      _otaCountDownController?.showTimeOut();
    }
  }

  void updateInitialPaymentUrn(Object? bookingUrn) {
    if (bookingUrn is String) _initialPaymentBookingUrn = bookingUrn;
  }

  void _initializePreviousAppliedPromo() {
    if (_previousPromoAppliedModel?.data != null) {
      _carPaymentBloc.updateDiscountAmountNoEmit(
          _previousPromoAppliedModel?.data?.priceViewModel?.effectiveDiscount ??
              0);
    }
  }

  @override
  Widget build(BuildContext context) {
    _carPaymentArgumentModel =
        ModalRoute.of(context)?.settings.arguments as CarPaymentArgumentModel;
    _otaCountDownController = _carPaymentArgumentModel?.otaCountDownController;
    return Scaffold(
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.confirmReservation),
        titleColor: AppColors.kGrey70,
        key: const Key("back_button_icon"),
      ),
      body: BlocBuilder(
          bloc: _carPaymentBloc,
          builder: () {
            switch (_carPaymentBloc.state.state) {
              case CarPaymentViewModelState.initial:
                return defaultWidget();
              case CarPaymentViewModelState.loaded:
                _initializePreviousAppliedPromo();
                return successWidget();
              case CarPaymentViewModelState.loading:
                return loadIngWidget();
              case CarPaymentViewModelState.failure:
              case CarPaymentViewModelState.failureNetwork:
                return _failureWidget();
              default:
                return defaultWidget();
            }
          }),
    );
  }

  void _updatePromoDataInProvider() {
    Provider.of<PromoWidgetViewModel>(context, listen: false)
        .setPromoWidgetViewModelData(_promoWidgetBloc.state);
  }

  Widget defaultWidget() => const SizedBox();

  Widget loadIngWidget() => const OTALoadingIndicator();

  Widget _failureWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: kSize24),
      child: Material(
        child: CarReservationNetworkErrorWidgetWithRefresh(
          imageUrl: kNetworkError,
          height: MediaQuery.of(context).size.height - _kTopHeight,
          onRefresh: () async {
            await _requestCarDetailData(isRefresh: true);
          },
        ),
      ),
    );
  }

  Future<void> _requestCarDetailData({isRefresh = false}) async {
    await _carPaymentBloc.loadFromArgument(argument!, context);
  }

  Widget promotionBannerWidget(
      List<OtaFreeFoodPromotionModel> freeFoodPromotionList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        const SizedBox(height: kSize24),
        Text(
          getTranslated(context, AppLocalizationsStrings.robinhoodSpecialOffer),
          style: AppTheme.kHeading1Medium,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: kSize16),
        OtaFreeFoodBannerWidget(freeFoodPromotionList: freeFoodPromotionList),
        const SizedBox(height: kSize24),
      ],
    );
  }

  Widget successWidget() {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList =
        _carPaymentArgumentModel?.promotionModelList ?? [];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        children: [
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(top: _kTopTimerPadding),
              children: [
                const SizedBox(
                  height: kSize16,
                ),
                _getCarInfo(),
                const SizedBox(
                  height: kSize16,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kSize24),
                  child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSize24),
                  child: _getPickUpReturnDetails(),
                ),
                if (_carPaymentArgumentModel?.extraCharge != null &&
                    _carPaymentArgumentModel!.extraCharge!.isNotEmpty)
                  _getMandatoryServices(),
                if (_carPaymentArgumentModel?.extraCharge != null &&
                    _carPaymentArgumentModel!.extraCharge!.isNotEmpty)
                  _getAdditionalServices(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kSize24),
                  child: OtaSpecialPromotionWidget(
                    allowLateReturn:
                        _carPaymentArgumentModel?.allowLateReturn ?? 0,
                  ),
                ),
                if (freeFoodPromotionList.isNotEmpty)
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kSize24),
                      child: promotionBannerWidget(freeFoodPromotionList)),
                HotelPaymentHeaderWidget(
                    headerText: getTranslated(
                        context, AppLocalizationsStrings.paymentDetail),
                    height: kSize56),
                _getCarPaymentListSummery(),
                getCancellationPolicyList(),
                getCardWidget(),
                const HotelPaymentHeaderWidget(
                    headerText: "", height: _kCardBottomSpacing),
              ],
            ),
          ),
          SafeArea(child: _getBottomBar(context)),
          OtaCountDownTimer(
            controller: _otaCountDownController!,
          ),
        ],
      ),
    );
  }

  Widget _getCarInfo() {
    String? brandName = _carPaymentArgumentModel?.brandName;
    String? carName = _carPaymentArgumentModel?.carName;

    return CarPaymentCarInfo(
      serviceProvider: _carPaymentArgumentModel?.serviceProvider,
      gear: _carPaymentArgumentModel?.gear,
      noOfDoors: _carPaymentArgumentModel?.doorNbr,
      noOfLargeBag: _carPaymentArgumentModel?.bagLargeNbr,
      name: '$brandName' '${' '}$carName',
      cancellationPolicy: _carPaymentBloc.state.cancellationStatus,
      noOfSeats: _carPaymentArgumentModel?.seatNbr,
      pickUpDate: _carPaymentArgumentModel?.pickupDate ?? DateTime.now(),
      returnDate: _carPaymentArgumentModel?.returnDate ?? DateTime.now(),
      totalPrice: _carPaymentArgumentModel?.pricePerDay?.toDouble(),
      imageUrl: _carPaymentArgumentModel?.imageUrl,
    );
  }

  Widget _getPickUpReturnDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslated(context, AppLocalizationsStrings.infoAboutCar),
              style: AppTheme.kBodyMedium,
            ),
            OtaIconButton(
              key: const Key(_kPickupDropOffDetailsButton),
              icon: SvgPicture.asset(
                _arrowRight,
                width: kSize20,
                height: kSize20,
              ),
              onTap: () {
                _goToPickupDropOff(CarDetailInfoPickType.carDetailInfoPickup);
              },
            )
          ],
        ),
        Text(
          getTranslated(context, AppLocalizationsStrings.pickUp),
          style: AppTheme.kBodyMedium,
        ),
        Row(
          children: [
            Text(
              getTranslated(context, AppLocalizationsStrings.pickUpDate),
              style: AppTheme.kBodyRegular,
            ),
            const Spacer(),
            _pickUpdate(),
          ],
        ),
        Row(
          children: [
            Text(
              getTranslated(context, AppLocalizationsStrings.carPickupPoint),
              style: AppTheme.kBodyRegular,
            ),
            const SizedBox(width: _kSize),
            Expanded(
              child: Text('${_carPaymentArgumentModel?.pickUpPoint}',
                  style: AppTheme.kBodyMedium,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: kSize16),
          child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ),
        Text(
          getTranslated(context, AppLocalizationsStrings.dropOff),
          style: AppTheme.kBodyMedium,
        ),
        Row(
          children: [
            Text(
              getTranslated(context, AppLocalizationsStrings.dropOffDate),
              style: AppTheme.kBodyRegular,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            _returnDate()
          ],
        ),
        Row(
          children: [
            Text(getTranslated(context, AppLocalizationsStrings.dropOffPoint),
                style: AppTheme.kBodyRegular, overflow: TextOverflow.ellipsis),
            const SizedBox(width: _kSize),
            Expanded(
              child: Text(
                '${_carPaymentArgumentModel?.droffPoint}',
                style: AppTheme.kBodyMedium,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        if (_carPaymentBloc.state.returnExtraCharge != null &&
            _carPaymentBloc.state.returnExtraCharge! > 0)
          _setDropText(context),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: kSize16),
          child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ),
        _getRentalPeriod(),
        _getServiceProvider(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: kSize16),
          child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ),
        _getDriversName(),
        _getFlightNumber(),
        const SizedBox(
          height: kSize16,
        )
      ],
    );
  }

  _setDropText(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kSize8),
        Text(
          getTranslated(context, AppLocalizationsStrings.dropOffFeeText),
          style: AppTheme.kSmallRegular,
        ),
      ],
    );
  }

  void _goToPickupDropOff(CarDetailInfoPickType carDetailInfoPickType) {
    if (argument != null) {
      Navigator.pushNamed(
        context,
        AppRoutes.carDetailInfoScreen,
        arguments: CarDetailInfoArgumentModel(
          carDetailInfoCarInfo: CarDetailInfoCarInfo(
            carDetails: argument!.carDetailInfoDataViewModel.carDetails,
            facilityList: argument!.carDetailInfoDataViewModel.facilities,
            pricing: argument!.carDetailInfoDataViewModel.pricing,
          ),
          carDetailInfoDropOff: CarDetailInfoDropOff(
            carDetails: argument!.carDetailInfoDataViewModel.carDetailsDropOff,
            carInfo: argument!.carDetailInfoDataViewModel.carInfo,
            pricing: argument!.carDetailInfoDataViewModel.pricing,
          ),
          carDetailInfoPickup: CarDetailInfoPickup(
            carDetails: argument!.carDetailInfoDataViewModel.carDetailsPickUp,
            carInfo: argument!.carDetailInfoDataViewModel.carInfo,
            pricing: argument!.carDetailInfoDataViewModel.pricing,
          ),
          carDetailInfoPickType: carDetailInfoPickType,
        ),
      );
    }
  }

  Widget _pickUpdate() {
    return Text(
      "${Helpers.getwwddMMMyy(_carPaymentArgumentModel?.pickupDate ?? DateTime.now())},${Helpers.gethhmm(_carPaymentArgumentModel?.pickupDate ?? DateTime.now()).addLeadingSpace()}",
      style: AppTheme.kBodyMedium,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _returnDate() {
    return Text(
      "${Helpers.getwwddMMMyy(_carPaymentArgumentModel?.returnDate ?? DateTime.now())},${Helpers.gethhmm(_carPaymentArgumentModel?.returnDate ?? DateTime.now()).addLeadingSpace()}",
      style: AppTheme.kBodyMedium,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getRentalPeriod() {
    return Row(
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.rentalPeriod),
          style: AppTheme.kBodyRegular,
        ),
        const Spacer(),
        Text(
            '${_carPaymentArgumentModel?.duration} ${getTranslated(context, AppLocalizationsStrings.days)}',
            style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getServiceProvider() {
    return Row(
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.carSupplier),
          style: AppTheme.kBodyRegular,
        ),
        const SizedBox(width: _kSize),
        Expanded(
          child: Text('${_carPaymentArgumentModel?.serviceProvider}',
              style: AppTheme.kBodyMedium,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right),
        ),
      ],
    );
  }

  Widget _getDriversName() {
    String driverFirstName = _carPaymentArgumentModel?.driverFirstName ?? '';
    String driverLastName = _carPaymentArgumentModel?.driverLastName ?? '';
    if (driverFirstName.isEmpty && driverLastName.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.driversName),
          style: AppTheme.kBodyRegular,
        ),
        const Spacer(),
        Text(
          '$driverFirstName $driverLastName',
          style: AppTheme.kBodyMedium,
        ),
      ],
    );
  }

//needs to be implemented once flight number is available
  Widget _getFlightNumber() {
    String flightNumber = _carPaymentArgumentModel?.flightNumber ?? '';
    if (flightNumber.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.flightNumber),
          style: AppTheme.kBodyRegular,
        ),
        const SizedBox(width: _kSize),
        Expanded(
          child: Text(
            _carPaymentArgumentModel?.flightNumber ?? '',
            style: AppTheme.kBodyMedium,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _getMandatoryServices() {
    return CarPaymentMandatoryAddonService(
      extraCharge: _carPaymentArgumentModel?.extraCharge,
      numberOfDays: _carPaymentArgumentModel?.duration,
    );
  }

  Widget _getAdditionalServices() {
    return CarPaymentAdditionalServices(
        extraCharge: _carPaymentArgumentModel?.extraCharge,
        numberOfDays: _carPaymentArgumentModel?.duration);
  }

  Widget _getCarPaymentListSummery() {
    return BlocBuilder(
        bloc: _virtualPaymentBloc,
        builder: () {
          return CarPaymentListSummery(
            carRental: _carPaymentBloc.state.carRentalTotalPrice ?? 0,
            additionalServicePayOnline: _getTotalAdditionalPayOnline(),
            additionalServicePayAtPickUpPoint: _getTotalAdditionalPayOffline(),
            subTotalPrice: _carPaymentBloc.state.carRentalTotalPrice! +
                _getTotalAdditionalPayOnline() +
                _getTotalAdditionalPayOffline(),
            discountAmount: _carPaymentBloc.state.discount ?? 0,
            grandTotal: _carPaymentBloc.getGrandTotal(),
            payPickUpPoint: _getTotalAdditionalPayOffline(),
            payOnline: _getPayableAmountOnline(),
            pickupPoint: _carPaymentArgumentModel?.pickUpPoint,
            dropOffPoint: _carPaymentArgumentModel?.droffPoint,
            returnExtraCharge: _carPaymentBloc.state.returnExtraCharge,
            bookingUrn: argument?.bookingUrn ?? "",
            promoBloc: _promoWidgetBloc,
            mechantId: _carPaymentArgumentModel
                    ?.carReservationViewArgumentModel?.carId ??
                "",
            updateDiscount: (discount) {
              _updatePromoDataInProvider();
              _carPaymentBloc.updateDiscountAmount(discount);
              _virtualPaymentBloc.updateWalletPaidAmountAfterPromoApplied(
                  _carPaymentBloc.getWalletAmountTobeDeducted(
                      _virtualPaymentBloc.state.balance ?? 0.0,
                      _getTotalAdditionalPayOffline()));
            },
            virtualPaymentBloc: _virtualPaymentBloc,
            walletAmountTobeDeducted:
                _carPaymentBloc.getWalletAmountTobeDeducted(
                    _virtualPaymentBloc.state.balance ?? 0.0,
                    _getTotalAdditionalPayOffline()),
            grandTotalWithWalletAmount:
                _carPaymentBloc.getGrandTotalWithWalletApplied(
                    _virtualPaymentBloc.isWalletOn(),
                    _virtualPaymentBloc.state.balance ?? 0.0,
                    _getTotalAdditionalPayOffline()),
          );
        });
  }

  double _getPayableAmountOnline() {
    double totalPayOnlineAmount = _carPaymentBloc.getPayOnlineNow(
            _virtualPaymentBloc.isWalletOn(),
            _virtualPaymentBloc.state.balance ?? 0.0,
            _getTotalAdditionalPayOffline()) +
        _getTotalAdditionalPayOnline();
    return totalPayOnlineAmount > 0 ? totalPayOnlineAmount : 0.0;
  }

  double _getTotalAdditionalPayOnline() {
    List<ExtraChargeData>? addOnsToPay = _carPaymentArgumentModel?.extraCharge
        ?.where((element) => element.isCompulsory!)
        .toList();
    final value =
        Provider.of<CarReservationAddOnViewModel>(context, listen: false);
    double totalprice = 0;
    addOnsToPay?.forEach((element) {
      totalprice = element.chargeType == 0
          ? totalprice +
              (element.addonPriceToDisplay! *
                  value.getQuantityForAddOn(element.extraChargeGroup?.id) *
                  _carPaymentArgumentModel!.duration!)
          : totalprice +
              (element.addonPriceToDisplay! *
                  value.getQuantityForAddOn(element.extraChargeGroup?.id));
    });
    return totalprice;
  }

  double _getTotalAdditionalPayOffline() {
    List<ExtraChargeData>? addOnsToPay = _carPaymentArgumentModel?.extraCharge
        ?.where((element) => !element.isCompulsory!)
        .toList();
    final value =
        Provider.of<CarReservationAddOnViewModel>(context, listen: false);
    double totalprice = 0;
    addOnsToPay?.forEach((element) {
      totalprice = element.chargeType == 0
          ? totalprice +
              (element.addonPriceToDisplay! *
                  value.getQuantityForAddOn(element.extraChargeGroup?.id) *
                  _carPaymentArgumentModel!.duration!)
          : totalprice +
              (element.addonPriceToDisplay! *
                  value.getQuantityForAddOn(element.extraChargeGroup?.id));
    });
    return totalprice;
  }

  Widget _getBottomBar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: kSize20),
        child: OtaTextButton(
          title: getTranslated(context, AppLocalizationsStrings.paymentLabels),
          key: const Key("BookNowButton"),
          textHorizontalPadding: kSize70,
          onPressed: () {
            _launchAppFlyerClickEvent();
            _launchFirebaseParametersForClick();
            _checkNetPrice();
          },
        ),
      ),
    );
  }

  Widget getCancellationPolicyList() {
    return Container(
      color: AppColors.kLight100,
      padding: kPaddingHori24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kSize16,
          ),
          CarPaymentCancellationPolicy(
            carPaymentBloc: _carPaymentBloc,
          ),
        ],
      ),
    );
  }

  Widget getCardWidget() {
    return Container(
      color: AppColors.kLight100,
      child: BlocBuilder(
        bloc: _paymentMethodBloc,
        builder: () {
          return _paymentMethodBloc.state.paymentMethodViewState ==
                  PaymentMethodViewState.success
              ? Column(
                  children: [
                    HotelPaymentHeaderWidget(
                      headerText: getTranslated(context,
                          AppLocalizationsStrings.paymentMethodsPaymentMain),
                      height: kSize56,
                      tailingText: getTranslated(context,
                          AppLocalizationsStrings.selectPaymentMethods),
                      onTap: () {
                        _onPaymentSelectionTapped();
                      },
                    ),
                    HotelPaymentCardItem(
                      cardName: _paymentMethodBloc
                              .getDefaultPaymentMethod()
                              ?.nickname ??
                          '',
                      cardNumber: _paymentMethodBloc
                              .getDefaultPaymentMethod()
                              ?.cardMask ??
                          "",
                      paymentType: _paymentMethodBloc
                          .getDefaultPaymentMethod()
                          ?.paymentMethodType,
                    ),
                  ],
                )
              : const SizedBox();
        },
      ),
    );
  }

  void _launchAppFlyerViewEvent() {
    AppFlyerHelper.startCapturingEvent(
        AppFlyerEvent.carFirstOrderPaymentSuccessEvent);
    AppFlyerHelper.startCapturingEvent(
        AppFlyerEvent.carPurchasePaymentSuccessEvent);
  }

  Map<String, String> _getAppFlyerParameterClickData() {
    return {
      CarClickPaymentAppFlyer.carId:
          _carPaymentArgumentModel?.carReservationViewArgumentModel?.carId ??
              '',
      CarClickPaymentAppFlyer.carAgencyId: _carPaymentArgumentModel
              ?.carReservationViewArgumentModel?.supplierId ??
          '',
      CarClickPaymentAppFlyer.carDropOffLocation:
          _carPaymentArgumentModel?.droffPoint ?? '',
      CarClickPaymentAppFlyer.carPickUpLocation:
          _carPaymentArgumentModel?.pickUpPoint ?? '',
      CarClickPaymentAppFlyer.carPromoCode:
          _promoWidgetBloc.state.data?.promotion.promotionCode ?? '',
      CarClickPaymentAppFlyer.carPaymentType:
          _paymentMethodBloc.getSelectedPaymentMethod(),
      CarClickPaymentAppFlyer.carContentId:
          _carPaymentArgumentModel?.carReservationViewArgumentModel?.carId ??
              '',
    };
  }

  void _getAppFlyerParametersForClick() {
    appFlyerLogger.addParameters(_getAppFlyerParameterClickData());
    appFlyerLogger.addKeyValue(
        key: CarClickPaymentAppFlyer.carPickUpDate,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: _carPaymentArgumentModel
                ?.carReservationViewArgumentModel?.pickupDate));
    appFlyerLogger.addKeyValue(
        key: CarClickPaymentAppFlyer.carReturnDate,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: _carPaymentArgumentModel
                ?.carReservationViewArgumentModel?.returnDate));
    appFlyerLogger.addDoubleValue(
        key: CarClickPaymentAppFlyer.carRentalPrice,
        value: _carPaymentArgumentModel?.pricePerDay);
    appFlyerLogger.addIntValue(
        key: CarClickPaymentAppFlyer.carRentalPeriod,
        value: _carPaymentArgumentModel?.duration);
    appFlyerLogger.addIntValue(
        key: CarClickPaymentAppFlyer.carNoOfPassengers,
        value: _carPaymentArgumentModel?.seatNbr);
    appFlyerLogger.addIntValue(
        key: CarClickPaymentAppFlyer.carPromoId,
        value: _promoWidgetBloc.state.data?.promotion.promotionId);
    appFlyerLogger.addCommaSeparatedList(
        value: CarAppFlyerHelper().getAllAddOnItems(
            extraCharge: _carPaymentArgumentModel?.extraCharge ?? []),
        key: CarClickPaymentAppFlyer.carAddOnItems);
    appFlyerLogger.addDoubleValue(
        key: CarClickPaymentAppFlyer.carAddOnPrice,
        value:
            _getTotalAdditionalPayOnline() + _getTotalAdditionalPayOffline());
    appFlyerLogger.addDoubleValue(
        key: CarClickPaymentAppFlyer.carPayNowPrice,
        value: _getPayableAmountOnline());
    appFlyerLogger.addDoubleValue(
        key: CarClickPaymentAppFlyer.carPayLaterPrice,
        value: _getTotalAdditionalPayOffline());
    appFlyerLogger.addContentType(key: CarClickPaymentAppFlyer.carContentType);
    appFlyerLogger.addCurrency(key: CarClickPaymentAppFlyer.carCurrency);
    appFlyerLogger.addUserLocation();
  }

  void _launchAppFlyerClickEvent() {
    _getAppFlyerParametersForClick();
    appFlyerLogger.publishToSuperApp(AppFlyerEvent.carClickPaymentEvent);
  }

  void _getAppFlyerParameterForPaymentSuccessForFirstOrder() {
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carRevenuePrice,
        value: _carPaymentBloc.state.carRentalTotalPrice! +
            _getTotalAdditionalPayOnline() +
            _getTotalAdditionalPayOffline());

    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carAddOnPrice,
        value:
            _getTotalAdditionalPayOnline() + _getTotalAdditionalPayOffline());
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carPayNowPrice,
        value: _getPayableAmountOnline());
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carPayLaterPrice,
        value: _getTotalAdditionalPayOffline());
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carPromoId,
        value: _promoWidgetBloc.state.data?.promotion.promotionId);
    AppFlyerHelper.addCommaSeparatedList(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        value: CarAppFlyerHelper().getAllAddOnItems(
            extraCharge: _carPaymentArgumentModel?.extraCharge ?? []),
        key: CarPaymentSuccessFirstOrderAppFlyer.carAddOnItems);
  }

  void _getAppFlyerParameterForPaymentSuccessForPurchaseOrder() {
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carRevenuePrice,
        value: _carPaymentBloc.state.carRentalTotalPrice! +
            _getTotalAdditionalPayOnline() +
            _getTotalAdditionalPayOffline());

    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carAddOnPrice,
        value:
            _getTotalAdditionalPayOnline() + _getTotalAdditionalPayOffline());
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carPayNowPrice,
        value: _getPayableAmountOnline());
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carPayLaterPrice,
        value: _getTotalAdditionalPayOffline());
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carPromoId,
        value: _promoWidgetBloc.state.data?.promotion.promotionId);
    AppFlyerHelper.addCommaSeparatedList(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        value: CarAppFlyerHelper().getAllAddOnItems(
            extraCharge: _carPaymentArgumentModel?.extraCharge ?? []),
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carAddOnItems);
  }

  void _launchFirebaseParametersForClick() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carModelId,
        value:
            _carPaymentArgumentModel?.carReservationViewArgumentModel?.carId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carModelName,
        value: _carPaymentArgumentModel?.carName);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carBrand,
        value: _carPaymentArgumentModel?.brandName);
    FirebaseHelper.addIntValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carNumberDay,
        value: _carPaymentArgumentModel?.duration);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carSupplierId,
        value: _carPaymentArgumentModel
            ?.carReservationViewArgumentModel?.supplierId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carSupplierName,
        value: _carPaymentArgumentModel?.serviceProvider);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carType,
        value: _carPaymentArgumentModel?.craftType);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carDropOffLocation,
        value: _carPaymentArgumentModel?.droffPoint);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carPickUpLocation,
        value: _carPaymentArgumentModel?.pickUpPoint);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carPickUpDateTime,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: _carPaymentArgumentModel
                ?.carReservationViewArgumentModel?.pickupDate));
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carReturnUpDateTime,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: _carPaymentArgumentModel
                ?.carReservationViewArgumentModel?.returnDate));
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carPaymentChannel,
        value: _paymentMethodBloc.getSelectedPaymentMethodFirebase());
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carPromoAmount,
        value: _promoWidgetBloc.state.data?.priceViewModel?.effectiveDiscount);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carReferenceId,
        value: _carPaymentArgumentModel?.bookingUrn);
    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carTotalPrice,
        value: _carPaymentArgumentModel?.totalPrice);
    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.totalPrice,
        value: _carPaymentBloc.getGrandTotal());
    FirebaseHelper.addCommaSeparatedList(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carEnhancement,
        value: CarClickPaymentFirebase.addOnList);
    FirebaseHelper.addCommaSeparatedList(
        eventName: FirebaseEvent.carClickPaymentEvent,
        key: CarClickPaymentFirebase.carEnhancementPrice,
        value: CarClickPaymentFirebase.addOnPricesList);
    FirebaseHelper.stopCapturingEvent(FirebaseEvent.carClickPaymentEvent);
  }

  void getPaymentDataFirebase(String eventName) {
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentSuccessFirebase.paymentChannel,
        value: _paymentMethodBloc.getSelectedPaymentMethodFirebase());
    FirebaseHelper.addDoubleValue(
        eventName: eventName,
        key: CarPaymentSuccessFirebase.totalPrice,
        value: _carPaymentBloc.getGrandTotal());
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentSuccessFirebase.promoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    FirebaseHelper.addDoubleValue(
        eventName: eventName,
        key: CarPaymentSuccessFirebase.promoAmount,
        value: _promoWidgetBloc.state.data?.priceViewModel?.effectiveDiscount);
    FirebaseHelper.addCommaSeparatedList(
        eventName: eventName,
        value: CarClickPaymentFirebase.addOnList,
        key: CarPaymentSuccessFirebase.carEnhancement);
    FirebaseHelper.addCommaSeparatedList(
        eventName: eventName,
        value: CarClickPaymentFirebase.addOnPricesList,
        key: CarPaymentSuccessFirebase.carEnhancementPrice);
  }

  void _getFirebaseParametersForPaymentAndPromoError(String eventName) {
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carModelId,
        value:
            _carPaymentArgumentModel?.carReservationViewArgumentModel?.carId);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carModelName,
        value: _carPaymentArgumentModel?.carName);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carBrand,
        value: _carPaymentArgumentModel?.brandName);
    FirebaseHelper.addIntValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carNumberDay,
        value: _carPaymentArgumentModel?.duration);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carSupplierId,
        value: _carPaymentArgumentModel
            ?.carReservationViewArgumentModel?.supplierId);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carSupplierName,
        value: _carPaymentArgumentModel?.serviceProvider);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carType,
        value: _carPaymentArgumentModel?.craftType);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carDropOffLocation,
        value: _carPaymentArgumentModel?.droffPoint);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carPickUpLocation,
        value: _carPaymentArgumentModel?.pickUpPoint);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carPickUpDateTime,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: _carPaymentArgumentModel
                ?.carReservationViewArgumentModel?.pickupDate));
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carReturnUpDateTime,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: _carPaymentArgumentModel
                ?.carReservationViewArgumentModel?.returnDate));
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carReferenceId,
        value: _carPaymentArgumentModel?.bookingUrn);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carPromoId,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    FirebaseHelper.addDoubleValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carTotalPrice,
        value: _carPaymentArgumentModel?.totalPrice);
  }

  List<PaymentMethodTypeArgument> _getPaymentMethodDetails({
    required String paymentMethod,
    String? paymentMethodId,
    String? paymentType,
    String? cardType,
    String? cardRef,
    double? payablePrice,
    double? paidByWalletPrice,
  }) {
    List<PaymentMethodTypeArgument> paymentMethodList = [];
    if (payablePrice != null && payablePrice > 0) {
      paymentMethodList.add(
        PaymentMethodTypeArgument(
          cardType: cardType,
          paymentMethod: paymentMethod,
          paymentMethodId: paymentMethodId,
          cardRef: cardRef,
          paymentType: paymentType,
          price: payablePrice,
        ),
      );
    }
    if (paidByWalletPrice != null && paidByWalletPrice > 0) {
      paymentMethodList.add(
        PaymentMethodTypeArgument(
          paymentMethod: _kVa,
          paymentType: _kWallet,
          price: paidByWalletPrice,
        ),
      );
    }
    return paymentMethodList;
  }
}
