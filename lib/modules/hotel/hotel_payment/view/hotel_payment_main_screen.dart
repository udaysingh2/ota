import 'package:flutter/material.dart';
import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';
import 'package:ota/channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';
import 'package:ota/channels/payment_management_invoke/usecases/payment_management_use_cases.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/scb_easy_helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_info_parameters.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_parameters.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_success_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_list_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_timer.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/bloc/virtual_payment_bloc.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/bloc/promo_widget_bloc.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_payment_review_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_payment/bloc/hotel_payment_main_view_bloc.dart';
import 'package:ota/modules/hotel/hotel_payment/bloc/hotel_payment_min_max_bloc.dart';
import 'package:ota/modules/hotel/hotel_payment/bloc/payment_method_bloc.dart';
import 'package:ota/modules/hotel/hotel_payment/channels/ota_payment_details.dart';
import 'package:ota/modules/hotel/hotel_payment/helper/payment_method_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/helper/success_payment_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/view/widgets/hotel_payment_addon_service_tile.dart';
import 'package:ota/modules/hotel/hotel_payment/view/widgets/hotel_payment_card_item.dart';
import 'package:ota/modules/hotel/hotel_payment/view/widgets/hotel_payment_error_widget.dart';
import 'package:ota/modules/hotel/hotel_payment/view/widgets/hotel_payment_header_widget.dart';
import 'package:ota/modules/hotel/hotel_payment/view/widgets/hotel_payment_list_summery.dart';
import 'package:ota/modules/hotel/hotel_payment/view/widgets/hotel_payment_reservation_details.dart';
import 'package:ota/modules/hotel/hotel_payment/view/widgets/hotel_payment_room_info.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_main_argument_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_main_view_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';
import 'package:provider/provider.dart';

import '../../../../core_pack/custom_widgets/ota_room_promotion_widget/ota_room_special_promotion_widget.dart';

const double _kTopPadding = 16.0;
const double _kTopTimerPadding = 40.0;
const double _kCardBottomSpacing = 100.0;
const double _kAppBarHeight = 89.0;
const String _kPayWise = 'PAYWISE';
const String _kCard = 'CARD';
const String _kWallet = 'WALLET';
const String _kVa = 'VA';
const String _kServiceType = 'HOTEL';
const String _kPaymentInfoSuccess = 'TRUE';
const String _kPaymentInfoFailure = 'FALSE';

class HotelPaymentMainScreen extends StatefulWidget {
  const HotelPaymentMainScreen({Key? key}) : super(key: key);

  @override
  HotelPaymentMainScreenState createState() => HotelPaymentMainScreenState();
}

class HotelPaymentMainScreenState extends State<HotelPaymentMainScreen> {
  final HotelPaymentMinMaxBloc _hotelPaymentMinMaxBloc =
      HotelPaymentMinMaxBloc();
  final HotelPaymentMainBloc hotelPaymentMainBloc = HotelPaymentMainBloc();
  HotelPaymentMainArgumentModel? argument;
  final PaymentMethodBloc _paymentMethodBloc = PaymentMethodBloc();
  late OtaCountDownController _otaCountDownController;
  String? _bookingUrn;
  String _initialPaymentBookingUrn = '';
  final SuperAppToOtaPayment superAppToOtaPayment = SuperAppToOtaPayment();
  final PaymentManagementUseCases paymentManagementUseCases =
      PaymentManagementUseCasesImpl();
  final PromoWidgetBloc _promoWidgetBloc = PromoWidgetBloc();
  final VirtualPaymentBloc _virtualPaymentBloc = VirtualPaymentBloc();
  PromoWidgetViewModel? _previousPromoAppliedModel;
  AppFlyerLogger appFlyerLogger = AppFlyerLogger();

  @override
  void dispose() {
    superAppToOtaPayment.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      argument = ModalRoute.of(context)?.settings.arguments
          as HotelPaymentMainArgumentModel;
      _otaCountDownController = argument!.otaCountDownController;
      hotelPaymentMainBloc.loadFromArgument(argument!);
      _bookingUrn = argument!.bookingUrn;
      superAppToOtaPayment.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );

      _previousPromoAppliedModel =
          Provider.of<PromoWidgetViewModel>(context, listen: false);
      _promoWidgetBloc.initPreviousAppliedPromo(_previousPromoAppliedModel);

      hotelPaymentMainBloc.stream.listen((event) {
        if (hotelPaymentMainBloc.state.state ==
            HotelPaymentMainViewModelState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        } else if (hotelPaymentMainBloc.state.state ==
            HotelPaymentMainViewModelState.loaded) {
          _getAppFlyerData();
        }
      });
    });
    _paymentMethodBloc.getPaymentMethodListData('');
    if (OtaServiceEnabledHelper.isWalletEnabled()) {
      _virtualPaymentBloc.getVirtualWalletBalance();
    }
  }

  void _initializePreviousAppliedPromo() {
    if (_previousPromoAppliedModel?.data != null) {
      hotelPaymentMainBloc.updateDiscountAmountNoEmit(
          _previousPromoAppliedModel?.data?.priceViewModel?.effectiveDiscount ??
              0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.confirmReservation),
        titleColor: AppColors.kGrey70,
        key: const Key("back_button_icon"),
      ),
      body: BlocBuilder(
          bloc: hotelPaymentMainBloc,
          builder: () {
            switch (hotelPaymentMainBloc.state.state) {
              case HotelPaymentMainViewModelState.initial:
                return defaultWidget();
              case HotelPaymentMainViewModelState.loaded:
                _initializePreviousAppliedPromo();
                return successWidget();
              case HotelPaymentMainViewModelState.loading:
                return loadIngWidget();
              case HotelPaymentMainViewModelState.failure:
              case HotelPaymentMainViewModelState.internetFailure:
                return failureState();
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

  Widget failureState() => HotelPaymentErrorWidget(
      height: MediaQuery.of(context).size.height - _kAppBarHeight,
      onRefresh: () async {
        _paymentMethodBloc.getPaymentMethodListData('');
        await hotelPaymentMainBloc.loadFromArgument(argument!);
      });

  Widget getReservationDetails() {
    return BlocBuilder(
        bloc: _hotelPaymentMinMaxBloc,
        builder: () {
          if (_hotelPaymentMinMaxBloc.state ==
              HotelPaymentMinMaxState.isExpanded) {
            return HotelPaymentReservationDetailsWidget(
              checkInDate: hotelPaymentMainBloc.state.fromDate,
              checkOutDate: hotelPaymentMainBloc.state.toDate,
              numberOfAdults: hotelPaymentMainBloc.state.getAdultCount(),
              numberOfNights: hotelPaymentMainBloc.state.nights,
              numberOfRooms: hotelPaymentMainBloc.state.rooms,
              numberOfChildren: hotelPaymentMainBloc.state.getChildCount(),
              guestName: (argument?.firstGuestName?.isEmpty ?? true)
                  ? hotelPaymentMainBloc.state.firstName.addTrailingSpace() +
                      hotelPaymentMainBloc.state.lastName
                  : argument!.firstGuestName!.addTrailingSpace() +
                      argument!.secondGuestName!,
              showDivider: false,
            );
          }
          return const SizedBox();
        });
  }

  Widget _getSpecialPromotion(BuildContext context) {
    return BlocBuilder(
        bloc: _hotelPaymentMinMaxBloc,
        builder: () {
          return _hotelPaymentMinMaxBloc.state ==
                  HotelPaymentMinMaxState.isExpanded
              ? Container(
                  color: AppColors.kLight100,
                  padding: kPaddingHori24,
                  child: OtaRoomSpecialPromotionWidget(
                    header: getTranslated(context,
                        AppLocalizationsStrings.specialPromotionPayment),
                    specialPromotionList:
                        hotelPaymentMainBloc.state.specialPromotionDetailList,
                    bottomDetail: getTranslated(
                        context, AppLocalizationsStrings.promotionTNCpayment),
                  ),
                )
              : const SizedBox();
        });
  }

  Widget successWidget() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              color: AppColors.kGrey4,
              child: ListView(
                padding: const EdgeInsets.only(top: _kTopTimerPadding),
                children: [
                  getRoomInfoWidget(),
                  getReservationDetails(),
                  if (hotelPaymentMainBloc.state.addonsModels.isNotEmpty)
                    const Padding(
                      padding: kPaddingHori24,
                      child:
                          OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                    ),
                  getHotelAddonService(),
                  if (hotelPaymentMainBloc
                      .state.specialPromotionDetailList.isNotEmpty) ...[
                    const Padding(
                      padding: kPaddingHori24,
                      child:
                          OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                    ),
                    _getSpecialPromotion(context),
                  ],
                  if (hotelPaymentMainBloc.state.freeFoodPromotions.isNotEmpty)
                    _privileges(),
                  HotelPaymentHeaderWidget(
                      headerText: getTranslated(
                          context, AppLocalizationsStrings.paymentDetail),
                      height: kSize56),
                  getListSummery(),
                  getCancellationPolicyList(),
                  getCardWidget(),
                  const HotelPaymentHeaderWidget(
                      headerText: "", height: _kCardBottomSpacing),
                ],
              ),
            ),
          ),
          SafeArea(child: _getBottomBar(context)),
          OtaCountDownTimer(
            label: AppLocalizationsStrings.countdownTitle,
            controller: _otaCountDownController,
          ),
        ],
      ),
    );
  }

  Widget getHotelAddonService() {
    return BlocBuilder(
        bloc: _hotelPaymentMinMaxBloc,
        builder: () {
          if (_hotelPaymentMinMaxBloc.state ==
              HotelPaymentMinMaxState.isExpanded) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.kLight100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSize24),
                    child: HotelPaymentAddonServiceTile(
                      name: hotelPaymentMainBloc.state.addonsModels
                          .elementAt(index)
                          .serviceName,
                      price: double.parse(hotelPaymentMainBloc
                          .state.addonsModels
                          .elementAt(index)
                          .cost),
                      quantity: hotelPaymentMainBloc.state.addonsModels
                          .elementAt(index)
                          .quantity,
                      requestDate: hotelPaymentMainBloc.state.addonsModels
                          .elementAt(index)
                          .selectedDate!,
                      currency: hotelPaymentMainBloc.state.currency,
                      showHeader: (index == 0) ? true : false,
                      showDivider: shouldShowAddonsDivider(index),
                    ),
                  ),
                );
              },
              itemCount: hotelPaymentMainBloc.state.addonsModels.length,
            );
          }
          return const SizedBox();
        });
  }

  bool shouldShowAddonsDivider(int index) {
    if (hotelPaymentMainBloc.state.addonsModels.length == 1) {
      return false;
    }
    if (index == hotelPaymentMainBloc.state.addonsModels.length - 1) {
      return false;
    }
    return true;
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
                        _launchAppFlyerPaymentInfoEvent();
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

  void _onPaymentSelectionTapped() async {
    ///todo : This comment can be removed permenantely when method " paymentManagementUseCases.invokeExampleMethod" is tested.
    // List<PaymentMethodArgumentModel>? paymentMethodArgsModelList =
    //     PlaymentMethodHelper.getPaymentMethodArgumentModelList(
    //         _paymentMethodBloc.getAllPaymentMethodList());
    // var selectedPaymentMethodId = await Navigator.pushNamed(
    //     context, AppRoutes.paymentMethodListScreen,
    //     arguments: paymentMethodArgsModelList);
    // if (selectedPaymentMethodId != null) {
    //   _paymentMethodBloc
    //       .setDefaultPaymentMethod(selectedPaymentMethodId as String);
    // }

    //
    LoginModel loginModel = getLoginProvider();
    paymentManagementUseCases.invokeExampleMethod(
        methodName: "paymentManagement",
        arguments: PaymentManagementArgumentModelChannel(
          serviceType: _kServiceType,
          env: loginModel.getEnv(),
          language: loginModel.getLanguage(),
          userId: loginModel.userId,
        ));
  }

  void waitForReplyFromSuperApp(OtaPaymentModelChannel data) async {
    _paymentMethodBloc.setDefaultPaymentMethodFromChannel(data);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
        key: HotelPaymentSuccessAppFlyer.hotelPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
        key: HotelPaymentSuccessAppFlyer.hotelPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());
  }

  Widget getListSummery() {
    return BlocBuilder(
        bloc: _virtualPaymentBloc,
        builder: () {
          return HotelPaymentListSummery(
            promoBloc: _promoWidgetBloc,
            showDivider: false,
            discountAmount: hotelPaymentMainBloc.state.discount,
            grandTotal: hotelPaymentMainBloc.state.getGrandTotalMinusDiscount(),
            subTotalPrice: double.parse(hotelPaymentMainBloc.state.totalCost),
            totalRoomPrice: hotelPaymentMainBloc.state.getTotalRoomCost(),
            totalServicePrice: hotelPaymentMainBloc.state.getTotalServiceCost(),
            bookingUrn: argument?.bookingUrn ?? "",
            merchantId: argument?.hotelId ?? "",
            updateDiscount: (discount) {
              _updatePromoDataInProvider();
              hotelPaymentMainBloc.updateDiscountAmount(discount);
              _virtualPaymentBloc.updateWalletPaidAmountAfterPromoApplied(
                  hotelPaymentMainBloc.state.getWalletAmountTobeDeducted(
                      _virtualPaymentBloc.state.balance ?? 0.0));
            },
            virtualPaymentBloc: _virtualPaymentBloc,
            walletAmountTobeDeducted: hotelPaymentMainBloc.state
                .getWalletAmountTobeDeducted(
                    _virtualPaymentBloc.state.balance ?? 0.0),
            grandTotalWithWalletAmount: hotelPaymentMainBloc.state
                .getGrandTotalWithWalletApplied(
                    _virtualPaymentBloc.isWalletOn(),
                    _virtualPaymentBloc.state.balance ?? 0.0),
          );
        });
  }

  Widget getRoomInfoWidget() {
    return Container(
      color: AppColors.kLight100,
      padding: const EdgeInsets.only(top: _kTopPadding),
      child: HotelPaymentReservationRoomInfo(
        cancellationPolicy: hotelPaymentMainBloc.state.cancellationPolicy,
        hotelPaymentMinMaxBloc: _hotelPaymentMinMaxBloc,
        facilityMap: hotelPaymentMainBloc.state.facilityList,
        roomDetailsList: hotelPaymentMainBloc.state.roomDetails,
        imageUrl: hotelPaymentMainBloc.state.imageUrl,
        offerName: hotelPaymentMainBloc.state.offerName,
        pricePerNight: double.parse(hotelPaymentMainBloc.state.perRoomCost),
        propertyName: hotelPaymentMainBloc.state.hotelName,
        checkInDate: hotelPaymentMainBloc.state.fromDate,
        checkOutDate: hotelPaymentMainBloc.state.toDate,
        night: hotelPaymentMainBloc.state.nights,
        room: hotelPaymentMainBloc.state.rooms,
        percentageDiscount: hotelPaymentMainBloc.state.percentageDiscount,
        priceBeforeDiscount: hotelPaymentMainBloc.state.priceBeforeDiscount,
        totalAmount: double.parse(hotelPaymentMainBloc.state.totalCost),
      ),
    );
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
            _triggerPaymentProceedingsFirebaseEvent(FirebaseEvent.hotelPayment);
            FirebaseHelper.stopCapturingEvent(FirebaseEvent.hotelPayment);
            _checkNetPrice();
          },
        ),
      ),
    );
  }

  void _checkNetPrice() {
    bool isValidationFailed = PlaymentMethodHelper.isMinAmountValidationFailed(
      isWalletEnabled: _virtualPaymentBloc.isWalletOn(),
      paidByWallet: _virtualPaymentBloc.state.walletPaidAmmount,
      onlinePayableAmount: hotelPaymentMainBloc.state
          .getGrandTotalWithWalletApplied(_virtualPaymentBloc.isWalletOn(),
              _virtualPaymentBloc.state.balance ?? 0.0),
    );

    AppFlyerHelper.stopCapturingEvent(AppFlyerEvent.hotelPaymentEvent);
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
      _triggerPaymentProceedingsFirebaseEvent(
          FirebaseEvent.hotelPromoRedeemError);
      _triggerPaymentProceedingsFirebaseEvent(FirebaseEvent.hotelPaymentError);
      navigateToLoadingScreen();
    }
  }

  void _checkEasyAppInstalled() async {
    SCBEasyAppState result = await SCBEasyHelper.launchSCBEasyApp(context);
    switch (result) {
      case SCBEasyAppState.installInitiated:
        break;
      case SCBEasyAppState.success:
        navigateToLoadingScreen();
        break;
      case SCBEasyAppState.anotherPaymentSelected:
        _onPaymentSelectionTapped();
        break;
    }
  }

  void navigateToLoadingScreen() async {
    HotelSuccessPaymentArgumentModel argumentModel =
        HotelSuccessPaymentArgumentModel();

    argumentModel.addonsModels = SuccessPaymentHelper.generateAdddon(
        hotelPaymentMainBloc.state.addonsModels);
    argumentModel.cancellationPolicyStatus =
        hotelPaymentMainBloc.state.cancellationPolicy;
    argumentModel.checkInDate = hotelPaymentMainBloc.state.fromDate;
    argumentModel.checkOutDate = hotelPaymentMainBloc.state.toDate;
    argumentModel.currency = hotelPaymentMainBloc.state.currency;
    argumentModel.facilityMap = SuccessPaymentHelper.generateFacilityList(
        hotelPaymentMainBloc.state.facilityList);
    argumentModel.hotelId = argumentModel.hotelId;
    argumentModel.imageUrl = hotelPaymentMainBloc.state.imageUrl;
    argumentModel.numberOfAdults = hotelPaymentMainBloc.state.getAdultCount();
    argumentModel.numberOfChildren = hotelPaymentMainBloc.state.getChildCount();
    argumentModel.roomCode = argumentModel.roomCode;
    argumentModel.roomDetailsList = SuccessPaymentHelper.generateRoomDetails(
        hotelPaymentMainBloc.state.roomDetails);
    argumentModel.numberOfRooms = hotelPaymentMainBloc.state.rooms;
    argumentModel.pricePerNight =
        double.parse(hotelPaymentMainBloc.state.perRoomCost);
    argumentModel.numberOfNights = hotelPaymentMainBloc.state.nights;
    argumentModel.offerName = hotelPaymentMainBloc.state.offerName;
    argumentModel.propertyName = hotelPaymentMainBloc.state.hotelName;
    argumentModel.bookingUrn = _bookingUrn;

    Provider.of<HotelSuccessPaymentArgumentModel>(context, listen: false)
        .getFromProvider(argumentModel);

    PaymentMethodInitiateArgument paymentMethodInitiateArgument =
        PaymentMethodInitiateArgument(
      currency: AppConfig().currency,
      screenComingFrom: ScreenToPayment.hotel,
      otaCountDownController: _otaCountDownController,
      bookingUrn: _bookingUrn!,
      newbookingUrn: _initialPaymentBookingUrn,
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
        paymentMethodId:
            (_paymentMethodBloc.getDefaultPaymentMethod()?.paymentMethodType ??
                        PaymentMethodType.scb) ==
                    PaymentMethodType.scb
                ? ''
                : _paymentMethodBloc.getDefaultPaymentMethod()!.paymentMethodId,
        payablePrice: hotelPaymentMainBloc.state.getGrandTotalWithWalletApplied(
            _virtualPaymentBloc.isWalletOn(),
            _virtualPaymentBloc.state.balance ?? 0.0),
        paidByWalletPrice: _virtualPaymentBloc.state.walletPaidAmmount,
      ),
    );
    final bookingUrn = await Navigator.pushNamed(
      context,
      AppRoutes.paymentLoadingScreen,
      arguments: paymentMethodInitiateArgument,
    );
    updateInitialPaymentUrn(bookingUrn);

    _otaCountDownController.isTimeOutDisabled = false;
    if (!_otaCountDownController.isTimerActive) {
      _otaCountDownController.showTimeOut();
    }
  }

  void updateInitialPaymentUrn(Object? bookingUrn) {
    if (bookingUrn is String) _initialPaymentBookingUrn = bookingUrn;
  }

  Widget getCancellationPolicyList() {
    return Container(
      color: AppColors.kLight100,
      padding: kPaddingHori24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OtaHorizontalDivider(
            dividerColor: AppColors.kGrey10,
          ),
          const SizedBox(
            height: kSize16,
          ),
          OtaCancellationPolicyListWidget(
            cancellationPolicyModel:
                hotelPaymentMainBloc.state.cancellationPolicyList,
          ),
        ],
      ),
    );
  }

  Widget _privileges() {
    return BlocBuilder(
        bloc: _hotelPaymentMinMaxBloc,
        builder: () {
          if (_hotelPaymentMinMaxBloc.state ==
              HotelPaymentMinMaxState.isExpanded) {
            return Container(
                padding: kPaddingHori24,
                color: AppColors.kLight100,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const OtaHorizontalDivider(
                          dividerColor: AppColors.kGrey10),
                      const SizedBox(
                        height: kSize16,
                      ),
                      Text(
                        getTranslated(context,
                            AppLocalizationsStrings.robinhoodPrivileges),
                        style: AppTheme.kHeading1Medium
                            .copyWith(color: AppColors.kGrey70),
                      ),
                      const SizedBox(
                        height: kSize16,
                      ),
                      OtaFreeFoodBannerWidget(
                        freeFoodPromotionList:
                            hotelPaymentMainBloc.state.freeFoodPromotions,
                      ),
                      const SizedBox(
                        height: kSize24,
                      ),
                    ]));
          }
          return const SizedBox();
        });
  }

  void _getAppFlyerData() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelId,
        value: argument?.hotelId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelCurrency,
        value: hotelPaymentMainBloc.state.currency);

    AppFlyerHelper.addUserLocation(eventName: AppFlyerEvent.hotelPaymentEvent);

    AppFlyerHelper.addCommaSeparatedList(
      eventName: AppFlyerEvent.hotelPaymentEvent,
      key: HotelPaymentAppFlyer.hotelRoomClass,
      value: hotelPaymentMainBloc.state.roomDetails
          .map((e) => e.category)
          .toList(),
    );

    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelRoomPrice,
        value: double.tryParse(hotelPaymentMainBloc.state.perRoomCost));
    AppFlyerHelper.addDateValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelCheckInDate,
        value: hotelPaymentMainBloc.state.fromDate);
    AppFlyerHelper.addDateValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelCheckOutDate,
        value: hotelPaymentMainBloc.state.toDate);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelStayPeriod,
        value: hotelPaymentMainBloc.state.nights);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelAdultCount,
        value: hotelPaymentMainBloc.state.getAdultCount());
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelChildCount,
        value: hotelPaymentMainBloc.state.getChildCount());
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelPromoId,
        value: _promoWidgetBloc.state.data?.promotion.promotionId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.promoType,
        value: _promoWidgetBloc.state.data?.promotion.promotionType);

    AppFlyerHelper.addCommaSeparatedList(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        value: hotelPaymentMainBloc.state.freeFoodPromotions
            .map((e) => e.line1)
            .toList(),
        key: HotelPaymentAppFlyer.hotelPromoType);

    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());

    // add parameters for other event
    _getHotelPaymentSuccessAppFlyerParameters(
        AppFlyerEvent.hotelPaymentSuccessEvent);
    _getHotelPaymentSuccessAppFlyerParameters(
        AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent);
  }

  _getHotelPaymentSuccessAppFlyerParameters(String eventName) {
    AppFlyerHelper.addKeyValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelId,
        value: argument?.hotelId);
    AppFlyerHelper.addKeyValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelContentId,
        value: argument?.hotelId);
    AppFlyerHelper.addKeyValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelCurrency,
        value: hotelPaymentMainBloc.state.currency);
    AppFlyerHelper.addKeyValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    AppFlyerHelper.addIntValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelPromoId,
        value: _promoWidgetBloc.state.data?.promotion.promotionId);
    AppFlyerHelper.addKeyValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.promoType,
        value: _promoWidgetBloc.state.data?.promotion.promotionType);

    AppFlyerHelper.addCommaSeparatedList(
        eventName: eventName,
        value: hotelPaymentMainBloc.state.freeFoodPromotions
            .map((e) => e.line1)
            .toList(),
        key: HotelPaymentSuccessAppFlyer.hotelPromoType);

    AppFlyerHelper.addCommaSeparatedList(
      eventName: eventName,
      key: HotelPaymentSuccessAppFlyer.hotelRoomClass,
      value: hotelPaymentMainBloc.state.roomDetails
          .map((e) => e.category)
          .toList(),
    );
    AppFlyerHelper.addKeyValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());
  }

  String _getPaymentStatusForAppFLyer() {
    return _paymentMethodBloc.state.paymentMethodViewState ==
            PaymentMethodViewState.success
        ? _kPaymentInfoSuccess
        : _kPaymentInfoFailure;
  }

  void _getAppFlyerDataForPaymentInfo() {
    appFlyerLogger.addKeyValue(
        key: HotelPaymentInfoAppFlyer.paymentCardType,
        value: _paymentMethodBloc
                .getDefaultPaymentMethod()
                ?.paymentMethodType
                .value ??
            '');
    appFlyerLogger.addKeyValue(
        key: HotelPaymentInfoAppFlyer.paymentMethodType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());

    appFlyerLogger.addKeyValue(
        key: HotelPaymentInfoAppFlyer.paymentMethodSuccess,
        value: _getPaymentStatusForAppFLyer());
  }

  void _launchAppFlyerPaymentInfoEvent() {
    _getAppFlyerDataForPaymentInfo();
    appFlyerLogger.publishToSuperApp(AppFlyerEvent.hotelPaymentInfoEvent);
  }

  void _triggerPaymentProceedingsFirebaseEvent(String eventName) {
    FirebaseHelper.addCommaSeparatedList(
        key: HotelPaymentReviewFirebase.hotelRoomClass,
        value: hotelPaymentMainBloc.state.roomDetails
            .map((e) => e.roomType)
            .toList(),
        eventName: eventName);

    FirebaseHelper.addKeyValue(
        key: HotelPaymentReviewFirebase.hotelRoomMealType,
        value: hotelPaymentMainBloc.state.offerName,
        eventName: eventName);
    FirebaseHelper.addDoubleValue(
        key: HotelPaymentReviewFirebase.hotelPricePerNight,
        value: double.tryParse(hotelPaymentMainBloc.state.perRoomCost),
        eventName: eventName);
    FirebaseHelper.addDoubleValue(
        key: HotelPaymentReviewFirebase.hotelTotalPrice,
        value: double.parse(hotelPaymentMainBloc.state.totalCost),
        eventName: eventName);
    FirebaseHelper.addDoubleWithPercentValue(
        key: HotelPaymentReviewFirebase.hotelDiscountPercent,
        value: hotelPaymentMainBloc.state.percentageDiscount,
        eventName: eventName);
    FirebaseHelper.addCommaSeparatedList(
        key: HotelPaymentReviewFirebase.hotelPromotionTag,
        value: hotelPaymentMainBloc.state.freeFoodPromotions
            .map((e) => e.line1)
            .toList(),
        eventName: eventName);
    FirebaseHelper.addKeyValue(
        key: HotelPaymentReviewFirebase.hotelReferenceId,
        value: _bookingUrn,
        eventName: eventName);
    FirebaseHelper.addKeyValue(
        key: HotelPaymentReviewFirebase.hotelPaymentChannel,
        value: _paymentMethodBloc.getSelectedPaymentMethodFirebase(),
        eventName: eventName);
    FirebaseHelper.addDoubleValue(
        key: HotelPaymentReviewFirebase.hotelTotalPriceAfterDiscount,
        value: hotelPaymentMainBloc.state.getGrandTotalMinusDiscount(),
        eventName: eventName);
    FirebaseHelper.addKeyValue(
        key: HotelPaymentReviewFirebase.hotelPromoDiscount,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode,
        eventName: eventName);
    FirebaseHelper.addDoubleValue(
        key: HotelPaymentReviewFirebase.hotelPromoAmount,
        value: _promoWidgetBloc.state.data?.priceViewModel?.effectiveDiscount,
        eventName: eventName);
    if (eventName != FirebaseEvent.hotelPayment) {
      FirebaseHelper.addIntValue(
          key: HotelPaymentReviewFirebase.hotelPromoId,
          value: _promoWidgetBloc.state.data?.promotion.promotionId,
          eventName: eventName);
    }
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
