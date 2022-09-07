import 'package:flutter/material.dart';
import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';
import 'package:ota/channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';
import 'package:ota/channels/payment_management_invoke/usecases/payment_management_use_cases.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/scb_easy_helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_payment_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_payment_success_first_order_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_payment_success_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_timer.dart';
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
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_payment_error_payment_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_payment_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_payment_success_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_payment/bloc/payment_method_bloc.dart';
import 'package:ota/modules/hotel/hotel_payment/channels/ota_payment_details.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/ota_reservation_success/bloc/ota_reservation_success_bloc.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_success_argument_model.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';
import 'package:ota/modules/tours/confirm_booking/bloc/tour_confirm_booking_bloc.dart';
import 'package:ota/modules/tours/confirm_booking/bloc/tour_confirm_booking_collapse_expand_bloc.dart';
import 'package:ota/modules/tours/confirm_booking/helper/tour_booking_confirm_helper.dart';
import 'package:ota/modules/tours/confirm_booking/view/widgets/tour_coinfirm_booking_header_widget.dart';
import 'package:ota/modules/tours/confirm_booking/view/widgets/tour_confirm_booking_card_item.dart';
import 'package:ota/modules/tours/confirm_booking/view/widgets/tour_confirm_booking_detail_widget.dart';
import 'package:ota/modules/tours/confirm_booking/view/widgets/tour_confirm_booking_error_widget.dart';
import 'package:ota/modules/tours/confirm_booking/view/widgets/tour_confirm_booking_list_summery.dart';
import 'package:ota/modules/tours/confirm_booking/view/widgets/tour_confirm_booking_review_info.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_model.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_view_model.dart';
import 'package:ota/modules/tours/reservation/helper/tour_reservation_helper.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_booking_terms_widget.dart';
import 'package:provider/provider.dart';

const double _kTopPadding = 16;
const double _kTopTimerPadding = 25;
const double _kCardHeaderSpacing = 56;
const double _kCardBottomSpacing = 76;
const double _kAppBarHeight = 89;
const String _kServiceType = 'TOUR';
const String _kWallet = 'WALLET';
const String _kVa = 'VA';

class TourConfirmBookingScreen extends StatefulWidget {
  const TourConfirmBookingScreen({Key? key}) : super(key: key);

  @override
  TourConfirmBookingScreenState createState() =>
      TourConfirmBookingScreenState();
}

class TourConfirmBookingScreenState extends State<TourConfirmBookingScreen> {
  final SuperAppToOtaPayment superAppToOtaPayment = SuperAppToOtaPayment();
  final PaymentManagementUseCases paymentManagementUseCases =
      PaymentManagementUseCasesImpl();
  final TourConfirmBookingCollapseExpandBloc _tourCollapseExpandBloc =
      TourConfirmBookingCollapseExpandBloc();
  final TourConfirmBookingBloc _tourConfirmBookingBloc =
      TourConfirmBookingBloc();
  final OtaCancellationPolicyController _controller =
      OtaCancellationPolicyController();
  final PaymentMethodBloc _paymentMethodBloc = PaymentMethodBloc();
  final PromoWidgetBloc _promoWidgetBloc = PromoWidgetBloc();
  late OtaCountDownController _otaCountDownController;
  TourConfirmBookingModel? _argumentModel;
  String _initialPaymentBookingUrn = '';
  PromoWidgetViewModel? _previousPromoAppliedModel;
  FirebaseLogger firebaseLogger = FirebaseLogger();
  final VirtualPaymentBloc _virtualPaymentBloc = VirtualPaymentBloc();

  @override
  void dispose() {
    superAppToOtaPayment.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _argumentModel =
          ModalRoute.of(context)?.settings.arguments as TourConfirmBookingModel;
      _otaCountDownController = _argumentModel!.otaCountDownController;
      _tourConfirmBookingBloc.loadFromArgument(_argumentModel!);
      superAppToOtaPayment.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
    });
    _paymentMethodBloc.getPaymentMethodListData('');
    if (OtaServiceEnabledHelper.isWalletEnabled()) {
      _virtualPaymentBloc.getVirtualWalletBalance();
    }
    _tourConfirmBookingBloc.stream.listen((event) {
      if (_tourConfirmBookingBloc.state.state ==
          TourPaymentReviewViewModelStates.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });

    _previousPromoAppliedModel =
        Provider.of<PromoWidgetViewModel>(context, listen: false);
    _promoWidgetBloc.initPreviousAppliedPromo(_previousPromoAppliedModel);
  }

  void _initializePreviousAppliedPromo() {
    if (_previousPromoAppliedModel?.data != null) {
      _tourConfirmBookingBloc.updatePromoDiscountNoEmit(
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
        key: const Key("back_button_icon"),
      ),
      body: BlocBuilder(
          bloc: _tourConfirmBookingBloc,
          builder: () {
            switch (_tourConfirmBookingBloc.state.state) {
              case TourPaymentReviewViewModelStates.initial:
                return defaultWidget();
              case TourPaymentReviewViewModelStates.success:
                _initializePreviousAppliedPromo();
                return successWidget();
              case TourPaymentReviewViewModelStates.loading:
                return loadIngWidget();
              case TourPaymentReviewViewModelStates.failure:
              case TourPaymentReviewViewModelStates.internetFailure:
                return failureState();
            }
          }),
    );
  }

  void _updatePromoDataInProvider() {
    Provider.of<PromoWidgetViewModel>(context, listen: false)
        .setPromoWidgetViewModelData(_promoWidgetBloc.state);
  }

  Widget defaultWidget() {
    return const SizedBox();
  }

  Widget loadIngWidget() {
    return const OTALoadingIndicator();
  }

  Widget failureState() {
    return TourConfirmBookingErrorWidget(
        height: MediaQuery.of(context).size.height - _kAppBarHeight,
        onRefresh: () async {
          _paymentMethodBloc.getPaymentMethodListData('');
          await _tourConfirmBookingBloc.loadFromArgument(_argumentModel!);
        });
  }

  Widget _getBookingDetails() {
    return BlocBuilder(
        bloc: _tourCollapseExpandBloc,
        builder: () {
          if (_tourCollapseExpandBloc.state ==
              TourPaymentReviewCollapseExpandState.isExpanded) {
            return TourConfirmBookingDetailsWidget(
              bookingDate: _tourConfirmBookingBloc.state.bookingDate!,
              numberOfDays: _tourConfirmBookingBloc.state.noOfDays!,
              durationText:
                  _tourConfirmBookingBloc.state.packageDetail!.durationText!,
              numberOfAdults: _tourConfirmBookingBloc.state.adultCount!,
              numberOfChild: _tourConfirmBookingBloc.state.childCount!,
              contactPerson: _tourConfirmBookingBloc
                      .state.customerInfo!.firstName!
                      .addLeadingSpace() +
                  _tourConfirmBookingBloc.state.customerInfo!.lastName!
                      .addLeadingSpace(),
              showPromotionTag:
                  _tourConfirmBookingBloc.state.promotionData.isNotEmpty,
              promotionData: _tourConfirmBookingBloc.state.promotionData,
              openTravellersInfo: () => {
                _openTravellersInfo(),
              },
              openWebView: (String url) => {
                Navigator.pushNamed(context, AppRoutes.webViewScreen,
                    arguments: url)
              },
            );
          }
          return const SizedBox();
        });
  }

  Widget successWidget() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(top: _kTopTimerPadding),
              children: <Widget>[
                _getTourInfoWidget(),
                _getBookingDetails(),
                TourConfirmBookingHeaderWidget(
                    headerText: getTranslated(
                        context, AppLocalizationsStrings.paymentDetail),
                    height: kSize56),
                _getPriceListSummery(),
                _getBorder(),
                _getCancellationPolicyList(),
                _getCardWidget(),
              ],
            ),
          ),
          SafeArea(child: _getBottomBar(context)),
          OtaCountDownTimer(
            controller: _otaCountDownController,
          ),
        ],
      ),
    );
  }

  Widget _getCardWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: _kCardBottomSpacing),
      color: AppColors.kLight100,
      child: BlocBuilder(
        bloc: _paymentMethodBloc,
        builder: () {
          return _paymentMethodBloc.state.paymentMethodViewState ==
                  PaymentMethodViewState.success
              ? Column(
                  children: [
                    TourConfirmBookingHeaderWidget(
                      headerText: getTranslated(context,
                          AppLocalizationsStrings.paymentMethodsPaymentMain),
                      height: _kCardHeaderSpacing,
                      tailingText: getTranslated(context,
                          AppLocalizationsStrings.selectPaymentMethods),
                      onTap: _onPaymentSelectionTapped,
                    ),
                    TourConfirmBookingCardItem(
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
  }

  Widget _getPriceListSummery() {
    return BlocBuilder(
        bloc: _virtualPaymentBloc,
        builder: () {
          return TourConfirmBookingListSummery(
            subTotal: _tourConfirmBookingBloc.state.totalAmount!,
            discountAmount: _tourConfirmBookingBloc.state.totalDiscount!,
            grandTotal: _tourConfirmBookingBloc.getGrandTotalWithWalletApplied(
                _virtualPaymentBloc.isWalletOn(),
                _virtualPaymentBloc.state.balance ?? 0.0),
            adultCount: _tourConfirmBookingBloc.state.adultCount!,
            childCount: _tourConfirmBookingBloc.state.childCount!,
            adultTourPrice: _tourConfirmBookingBloc.state.adultPrice!,
            childTourPrice: _tourConfirmBookingBloc.state.childPrice ?? 0,
            bookingUrn: _argumentModel!.argument.bookingUrn,
            promoBloc: _promoWidgetBloc,
            merchantId: _tourConfirmBookingBloc.state.tourId!,
            updatedPromoDiscount: (discount) {
              _updatePromoDataInProvider();
              _tourConfirmBookingBloc.updatePromoDiscount(discount);
              _virtualPaymentBloc.updateWalletPaidAmountAfterPromoApplied(
                  _tourConfirmBookingBloc.getWalletAmountTobeDeducted(
                      _virtualPaymentBloc.state.balance ?? 0.0));
            },
            virtualPaymentBloc: _virtualPaymentBloc,
            walletAmountTobeDeducted:
                _tourConfirmBookingBloc.getWalletAmountTobeDeducted(
                    _virtualPaymentBloc.state.balance ?? 0.0),
            grandTotalWithWalletAmount:
                _tourConfirmBookingBloc.getGrandTotalWithWalletApplied(
                    _virtualPaymentBloc.isWalletOn(),
                    _virtualPaymentBloc.state.balance ?? 0.0),
          );
        });
  }

  Widget _getTourInfoWidget() {
    return Container(
      color: AppColors.kLight100,
      padding: const EdgeInsets.only(top: _kTopPadding),
      child: TourConfirmBookingReviewInfo(
        imageUrl: _tourConfirmBookingBloc.state.image,
        tourName: _tourConfirmBookingBloc.state.name,
        packageName: _tourConfirmBookingBloc.state.packageDetail!.name,
        noOfDays: _tourConfirmBookingBloc.state.noOfDays,
        cancellationHeader: TourConfirmBookingHelper.getCancellationHeader(
            _tourConfirmBookingBloc.state.packageDetail!.highlights),
        bookingDate: _tourConfirmBookingBloc.state.bookingDate,
        startTime: _tourConfirmBookingBloc.state.startTimeAmPm,
        facilityMap: _tourConfirmBookingBloc.state.packageDetail!.highlights,
        adultTourPrice: _tourConfirmBookingBloc.state.adultPrice!,
        childTourPrice: _tourConfirmBookingBloc.state.childPrice ?? 0,
        childCount: _tourConfirmBookingBloc.state.childCount,
        childInfo: _tourConfirmBookingBloc.state.childInfo,
        tourPaymentCollapseExpandBloc: _tourCollapseExpandBloc,
      ),
    );
  }

  Widget _getBottomBar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: kSize20),
        child: OtaTextButton(
            title:
                getTranslated(context, AppLocalizationsStrings.paymentLabels),
            key: const Key("BookNowButton"),
            textHorizontalPadding: kSize86,
            onPressed: () {
              getPromoCodeFirebase(FirebaseEvent.activityPaymentSubmitError);
              getPromoCodeFirebase(FirebaseEvent.activityPromoRedeemError);
              _checkNetPrice();
            }),
      ),
    );
  }

  void getPromoCodeFirebase(String eventName) {
    FirebaseHelper.addIntValue(
        key: ActivityPaymentErrorPaymentFirebase.activityPromoId,
        eventName: eventName,
        value: _promoWidgetBloc.state.data?.promotion.promotionId);
  }

  Widget _getBorder() {
    return const Padding(
      padding: kPaddingHori24,
      child: OtaHorizontalDivider(
        dividerColor: AppColors.kGrey10,
        height: 1,
      ),
    );
  }

  Widget _getCancellationPolicyList() {
    return PackageBookingTermsWidget(
      controller: _controller,
      showDivider: false,
      cancellationStatus: TourConfirmBookingHelper.getCancellationHeader(
          _tourConfirmBookingBloc.state.packageDetail!.highlights),
      bookingTermsList: TourReservationHelper.getCancellationPolicy(
          context,
          _tourConfirmBookingBloc.state.packageDetail!.cancellationPolicy,
          AppConfig().configModel.tourCancellationPercent),
    );
  }

  void _checkNetPrice() {
    _publishAppFlyerClickEvent();
    _publishFirebaseEvent();

    bool isValidationFailed =
        TourConfirmBookingHelper.isMinAmountValidationFailed(
            isWalletEnabled: _virtualPaymentBloc.isWalletOn(),
            paidByWallet: _virtualPaymentBloc.state.walletPaidAmmount,
            onlinePayableAmount:
                _tourConfirmBookingBloc.getGrandTotalWithWalletApplied(
                    _virtualPaymentBloc.isWalletOn(),
                    _virtualPaymentBloc.state.balance ?? 0.0));

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
      // SCB flow
    } else {
      _getAppFlyerPaymentSuccessParameters();
      _getAppFlyerPaymentSuccessParametersForFirstOrder();
      _getPaymentSuccessFirebaseParameters();
      _navigateToPaymentLoadingPage();
    }
  }

  void _checkEasyAppInstalled() async {
    SCBEasyAppState result = await SCBEasyHelper.launchSCBEasyApp(context);
    switch (result) {
      case SCBEasyAppState.installInitiated:
        break;
      case SCBEasyAppState.success:
        _navigateToPaymentLoadingPage();
        break;
      case SCBEasyAppState.anotherPaymentSelected:
        _onPaymentSelectionTapped();
        break;
    }
  }

  void _openTravellersInfo() async {
    Navigator.pushNamed(
      context,
      AppRoutes.guestDetailScreen,
      arguments: _tourConfirmBookingBloc.state.participantInfo,
    );
  }

  void _navigateToPaymentLoadingPage() async {
    List<TourOrTicketsType> tourOrTicketsType = [
      TourOrTicketsType(
        name: getTranslated(context, AppLocalizationsStrings.adults),
        price: _tourConfirmBookingBloc.state.adultPrice,
        count: _tourConfirmBookingBloc.state.adultCount,
      )
    ];
    if ((_tourConfirmBookingBloc.state.childCount ?? 0) != 0) {
      tourOrTicketsType.add(
        TourOrTicketsType(
          name: getTranslated(context, AppLocalizationsStrings.children),
          price: _tourConfirmBookingBloc.state.childPrice ?? 0,
          count: _tourConfirmBookingBloc.state.childCount ?? 0,
          maxAge: _tourConfirmBookingBloc.state.childInfo!.maxAge,
          minAge: _tourConfirmBookingBloc.state.childInfo!.minAge,
        ),
      );
    }

    OtaReservationSuccessArgumentModel reservationArgumentModel =
        OtaReservationSuccessArgumentModel(
      id: _tourConfirmBookingBloc.state.tourId!,
      serviceCardType: ServiceCardType.tour,
      bookingForTicket: false,
      providerName: _tourConfirmBookingBloc.state.name,
      packageName: _tourConfirmBookingBloc.state.packageDetail?.name,
      imageUrl: _tourConfirmBookingBloc.state.image,
      highlights: TourConfirmBookingHelper.generateHighlightList(
          _tourConfirmBookingBloc.state.packageDetail?.highlights),
      tourOrTicketsType: tourOrTicketsType,
      adultCount: _tourConfirmBookingBloc.state.adultCount,
      childCount: _tourConfirmBookingBloc.state.childCount,
      bookingDate: _tourConfirmBookingBloc.state.bookingDate,
      noOfDays: int.tryParse(_tourConfirmBookingBloc.state.noOfDays!),
      activityDuration:
          _tourConfirmBookingBloc.state.packageDetail!.durationText,
      referenceId: _tourConfirmBookingBloc.state.bookingUrn,
    );

    Provider.of<OtaReservationSuccessArgumentModel>(context, listen: false)
        .getFromProvider(reservationArgumentModel);

    final paymentMethodId =
        (_paymentMethodBloc.getDefaultPaymentMethod()?.paymentMethodType ??
                    PaymentMethodType.scb) ==
                PaymentMethodType.scb
            ? ''
            : _paymentMethodBloc.getDefaultPaymentMethod()!.paymentMethodId;
    final cardType =
        _paymentMethodBloc.getDefaultPaymentMethod()!.paymentMethodType.value;
    PaymentMethodInitiateArgument paymentInitiateArgumentModel =
        PaymentMethodInitiateArgument(
      currency: AppConfig().currency,
      otaCountDownController: _otaCountDownController,
      bookingUrn: _argumentModel!.argument.bookingUrn,
      newbookingUrn: _initialPaymentBookingUrn,
      paymentDetails: _getPaymentMethodDetails(
        paymentMethod: _paymentMethodBloc.getSelectedPaymentMethod(),
        cardRef: _paymentMethodBloc.getDefaultPaymentMethod()!.cardRef,
        cardType: cardType,
        paymentMethodId: paymentMethodId,
        paidByWalletPrice: _virtualPaymentBloc.state.walletPaidAmmount,
        payablePrice: _tourConfirmBookingBloc.getGrandTotalWithWalletApplied(
            _virtualPaymentBloc.isWalletOn(),
            _virtualPaymentBloc.state.balance ?? 0.0),
      ),
    );

    final bookingUrn = await Navigator.pushNamed(
      context,
      AppRoutes.newPaymentLoadingScreen,
      arguments: paymentInitiateArgumentModel,
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

  void _getAppFlyerPaymentSuccessParameters() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourPlaceId,
        value: _tourConfirmBookingBloc.state.tourId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourId,
        value: _tourConfirmBookingBloc.state.tourId);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourCurrency);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourContentId,
        value: _tourConfirmBookingBloc.state.tourId);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourPricePerAdult,
        value: _tourConfirmBookingBloc.state.adultPrice);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourPricePerChild,
        value: _tourConfirmBookingBloc.state.childPrice);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourPromoAmount,
        value: _promoWidgetBloc.state.data?.priceViewModel?.effectiveDiscount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourPromoType,
        value: _promoWidgetBloc.state.data?.promotion.promotionType);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessEvent,
        key: TourPaymentSuccessAppFlyer.tourPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());
  }

  void _getAppFlyerPaymentSuccessParametersForFirstOrder() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourPlaceId,
        value: _tourConfirmBookingBloc.state.tourId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourId,
        value: _tourConfirmBookingBloc.state.tourId);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourCurrency);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourContentId,
        value: _tourConfirmBookingBloc.state.tourId);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourPricePerAdult,
        value: _tourConfirmBookingBloc.state.adultPrice);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourPricePerChild,
        value: _tourConfirmBookingBloc.state.childPrice);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourPromoAmount,
        value: _promoWidgetBloc.state.data?.priceViewModel?.effectiveDiscount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourPromoType,
        value: _promoWidgetBloc.state.data?.promotion.promotionType);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentSuccessFirstBookingEvent,
        key: TourPaymentSuccessFirstOrderAppFlyer.tourPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());
  }

  void _getAppFlyerClickParameters() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourPlaceId,
        value: _tourConfirmBookingBloc.state.tourId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourId,
        value: _tourConfirmBookingBloc.state.tourId);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourCurrency);
    AppFlyerHelper.addUserLocation(eventName: AppFlyerEvent.tourPaymentEvent);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourNumberOfAdult,
        value: _tourConfirmBookingBloc.state.adultCount);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourNumberOfChild,
        value: _tourConfirmBookingBloc.state.childCount);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourPricePerAdult,
        value: _tourConfirmBookingBloc.state.adultPrice);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourPricePerChild,
        value: _tourConfirmBookingBloc.state.childPrice);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourPromoAmount,
        value: _promoWidgetBloc.state.data?.priceViewModel?.effectiveDiscount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourPromoType,
        value: _promoWidgetBloc.state.data?.promotion.promotionType);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourContentId,
        value: _tourConfirmBookingBloc.state.tourId);
    AppFlyerHelper.addContentType(
        eventName: AppFlyerEvent.tourPaymentEvent,
        key: TourPaymentAppFlyer.tourContentType);
  }

  void _publishAppFlyerClickEvent() {
    _getAppFlyerClickParameters();
    AppFlyerHelper.stopCapturingEvent(AppFlyerEvent.tourPaymentEvent);
  }

  void _getFirebaseParameters(String eventName) {
    int adultCount = _tourConfirmBookingBloc.state.adultCount ?? 0;
    int childCount = _tourConfirmBookingBloc.state.childCount ?? 0;
    int totalNumberOfTickets = adultCount + childCount;

    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityId,
        value: _tourConfirmBookingBloc.state.tourId);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityName,
        value: _tourConfirmBookingBloc.state.name);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityPackageName,
        value: _tourConfirmBookingBloc.state.packageDetail?.name);
    FirebaseHelper.addDateValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityDate,
        value: _tourConfirmBookingBloc.state.bookingDate);
    FirebaseHelper.addIntValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityNoOfAdult,
        value: adultCount);
    FirebaseHelper.addIntValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityNoOfChild,
        value: childCount);
    FirebaseHelper.addDoubleValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityPricePerAdult,
        value: _tourConfirmBookingBloc.state.adultPrice);
    FirebaseHelper.addDoubleValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityPricePerChild,
        value: _tourConfirmBookingBloc.state.childPrice);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityPaymentChannel,
        value: _paymentMethodBloc.getSelectedPaymentMethodFirebase());
    FirebaseHelper.addDoubleValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityPriceAfterDiscount,
        value: _tourConfirmBookingBloc.getPayablePrice);
    FirebaseHelper.addIntValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityPromotionId,
        value: _promoWidgetBloc.state.data?.promotion.promotionId);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityPromoDiscount,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    FirebaseHelper.addDoubleValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityPromoAmount,
        value: _promoWidgetBloc.state.data?.priceViewModel?.effectiveDiscount);
    FirebaseHelper.addIntValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityTicketNo,
        value: totalNumberOfTickets);

    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPaymentFirebase.activityService,
        value: _kServiceType);
  }

  void _publishFirebaseEvent() {
    _getFirebaseParameters(FirebaseEvent.activityPaymentEvent);
    FirebaseHelper.stopCapturingEvent(FirebaseEvent.activityPaymentEvent);
  }

  void _getPaymentSuccessFirebaseParameters() {
    FirebaseHelper.startCapturingEvent(FirebaseEvent.tourPaymentSuccess);

    int adultCount = _tourConfirmBookingBloc.state.adultCount ?? 0;
    int childCount = _tourConfirmBookingBloc.state.childCount ?? 0;
    int totalTravellers = adultCount + childCount;

    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourPaymentSuccess,
        key: TourPaymentSuccessFirebase.activityId,
        value: _tourConfirmBookingBloc.state.tourId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourPaymentSuccess,
        key: TourPaymentSuccessFirebase.activityName,
        value: _tourConfirmBookingBloc.state.name);
    FirebaseHelper.addDateValue(
        eventName: FirebaseEvent.tourPaymentSuccess,
        key: TourPaymentSuccessFirebase.activityDate,
        value: _tourConfirmBookingBloc.state.bookingDate);
    FirebaseHelper.addIntValue(
        eventName: FirebaseEvent.tourPaymentSuccess,
        key: TourPaymentSuccessFirebase.activityNumberOfAdult,
        value: adultCount);
    FirebaseHelper.addIntValue(
        eventName: FirebaseEvent.tourPaymentSuccess,
        key: TourPaymentSuccessFirebase.activityNumberOfChild,
        value: childCount);
    FirebaseHelper.addIntValue(
        eventName: FirebaseEvent.tourPaymentSuccess,
        key: TourPaymentSuccessFirebase.activityTotalTravellers,
        value: totalTravellers);
    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.tourPaymentSuccess,
        key: TourPaymentSuccessFirebase.activityTotalPrice,
        value: _tourConfirmBookingBloc.getPayablePrice);
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
