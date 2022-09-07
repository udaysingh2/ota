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
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tickets_payment_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tickets_payment_success_first_order_parameters.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tickets_payment_success_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_timer.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/bloc/virtual_payment_bloc.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/bloc/promo_widget_bloc.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
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
import 'package:ota/modules/tickets/confirm_booking/bloc/ticket_confirm_booking_bloc.dart';
import 'package:ota/modules/tickets/confirm_booking/bloc/ticket_confirm_booking_expand_bloc.dart';
import 'package:ota/modules/tickets/confirm_booking/helper/ticket_confirm_booking_helper.dart';
import 'package:ota/modules/tickets/confirm_booking/view/widget/ticket_confirm_booking_card_item.dart';
import 'package:ota/modules/tickets/confirm_booking/view/widget/ticket_confirm_booking_error_widget.dart';
import 'package:ota/modules/tickets/confirm_booking/view/widget/ticket_confirm_booking_header_widget.dart';
import 'package:ota/modules/tickets/confirm_booking/view/widget/ticket_confirm_booking_list_summery.dart';
import 'package:ota/modules/tickets/confirm_booking/view/widget/ticket_confirm_booking_reservation_details.dart';
import 'package:ota/modules/tickets/confirm_booking/view/widget/ticket_confirm_booking_reservation_info.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_main_view_model.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_model.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_view_model.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/confirm_booking_argument.dart';
import 'package:provider/provider.dart';

const double _kTopPadding = 16;
const double _kTopTimerPadding = 25;
const double _kCardHeaderSpacing = 56;
const double _kCardBottomSpacing = 76;
const double _kAppBarHeight = 89;
const String _kServiceType = 'TOUR';
const String _kWallet = 'WALLET';
const String _kVa = 'VA';

class TicketConfirmBookingScreen extends StatefulWidget {
  const TicketConfirmBookingScreen({Key? key}) : super(key: key);

  @override
  State<TicketConfirmBookingScreen> createState() =>
      _TicketConfirmBookingScreenState();
}

class _TicketConfirmBookingScreenState
    extends State<TicketConfirmBookingScreen> {
  late OtaCountDownController _otaCountDownController;
  final PaymentMethodBloc _paymentMethodBloc = PaymentMethodBloc();
  final TicketConfirmBookingExpandBloc _ticketConfirmBookingExpandBloc =
      TicketConfirmBookingExpandBloc();
  final TicketConfirmBookingBloc _ticketConfirmBookingBloc =
      TicketConfirmBookingBloc();
  final SuperAppToOtaPayment superAppToOtaPayment = SuperAppToOtaPayment();
  final PaymentManagementUseCases paymentManagementUseCases =
      PaymentManagementUseCasesImpl();
  final PromoWidgetBloc _promoWidgetBloc = PromoWidgetBloc();
  final VirtualPaymentBloc _virtualPaymentBloc = VirtualPaymentBloc();
  ConfirmBookingArgument? argument;
  String _initialPaymentBookingUrn = '';
  PromoWidgetViewModel? _previousPromoAppliedModel;
  final AppFlyerLogger _logger = AppFlyerLogger();

  @override
  void dispose() {
    superAppToOtaPayment.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppFlyerHelper.startCapturingEvent(
          AppFlyerEvent.ticketPaymentSuccessEvent);
      AppFlyerHelper.startCapturingEvent(
          AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent);
      TicketConfirmBookingArgumentModel argumentTemp = (ModalRoute.of(context)
          ?.settings
          .arguments as TicketConfirmBookingArgumentModel);
      argument = argumentTemp.argument;
      _otaCountDownController = argumentTemp.otaCountDownController;
      _ticketConfirmBookingBloc.loadFromArgument(argument);
      superAppToOtaPayment.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
    });
    _paymentMethodBloc.getPaymentMethodListData("");
    if (OtaServiceEnabledHelper.isWalletEnabled()) {
      _virtualPaymentBloc.getVirtualWalletBalance();
    }
    _previousPromoAppliedModel =
        Provider.of<PromoWidgetViewModel>(context, listen: false);
    _promoWidgetBloc.initPreviousAppliedPromo(_previousPromoAppliedModel);

    _ticketConfirmBookingBloc.stream.listen((event) {
      if (_ticketConfirmBookingBloc.state.state ==
          TicketConfirmBookingScreenState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
  }

  void _initializePreviousAppliedPromo() {
    if (_previousPromoAppliedModel?.data != null) {
      _ticketConfirmBookingBloc.updatePromoDiscountNoEmit(
          _previousPromoAppliedModel?.data?.priceViewModel?.effectiveDiscount ??
              0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLight100,
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.confirmReservation),
        key: const Key("back_button_icon"),
      ),
      body: BlocBuilder(
          bloc: _ticketConfirmBookingBloc,
          builder: () {
            switch (_ticketConfirmBookingBloc.state.state) {
              case TicketConfirmBookingScreenState.initial:
                return defaultWidget();
              case TicketConfirmBookingScreenState.success:
                _initializePreviousAppliedPromo();
                return successWidget();
              case TicketConfirmBookingScreenState.loading:
                return loadIngWidget();
              case TicketConfirmBookingScreenState.failure:
              case TicketConfirmBookingScreenState.internetFailure:
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
    return TicketConfirmBookingErrorWidget(
        height: MediaQuery.of(context).size.height - _kAppBarHeight,
        onRefresh: () async {
          _paymentMethodBloc.getPaymentMethodListData('');
          await _ticketConfirmBookingBloc.loadFromArgument(argument);
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
              children: [
                _getTicketInfoWidget(),
                _getBookingDetails(),
                TicketConfirmBookingHeaderWidget(
                    headerText: getTranslated(
                        context, AppLocalizationsStrings.paymentDetail),
                    height: kSize56),
                _getListSummery(),
                _getCardWidget(),
                const TicketConfirmBookingHeaderWidget(
                    headerText: "", height: _kCardBottomSpacing),
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

  Widget _getTicketInfoWidget() {
    TicketConfirmBookingModel data = _ticketConfirmBookingBloc.state.data!;
    return Container(
      color: AppColors.kLight100,
      padding: const EdgeInsets.only(top: _kTopPadding),
      child: TicketConfirmBookingReviewInfo(
        imageUrl: data.ticketImageUrl,
        ticketName: data.ticketName,
        packageName: data.packageName,
        bookingDate: data.bookingDate,
        ticketTypeList: data.ticketList,
        startTime: data.startTime,
        cancellationHeader:
            _ticketConfirmBookingBloc.state.data!.cancellationHeader,
        facilityMap: data.ticketHighLights,
        ticketConfirmBookingExpandBloc: _ticketConfirmBookingExpandBloc,
      ),
    );
  }

  Widget _getBookingDetails() {
    return BlocBuilder(
        bloc: _ticketConfirmBookingExpandBloc,
        builder: () {
          if (_ticketConfirmBookingExpandBloc.state ==
              TicketConfirmBookingMinMaxState.isExpanded) {
            return TicketConfirmBookingDetailsWidget(
              contactPerson: _ticketConfirmBookingBloc
                      .state.data!.customerInfo.firstName!
                      .addLeadingSpace() +
                  _ticketConfirmBookingBloc.state.data!.customerInfo.lastName!
                      .addLeadingSpace(),
              durationText: _ticketConfirmBookingBloc.state.data!.durationText,
              bookingDate: _ticketConfirmBookingBloc.state.data!.bookingDate,
              promotionData:
                  _ticketConfirmBookingBloc.state.data!.promotionData,
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

  Widget _getListSummery() {
    TicketConfirmBookingModel data = _ticketConfirmBookingBloc.state.data!;
    return BlocBuilder(
        bloc: _virtualPaymentBloc,
        builder: () {
          return TicketConfirmBookingListSummery(
            ticketTypeList: data.ticketList,
            discountAmount: data.totalDiscount,
            netPrice: data.getGrandTotalWithWalletApplied(
                _virtualPaymentBloc.isWalletOn(),
                _virtualPaymentBloc.state.balance ?? 0.0),
            totalServicePrice: data.totalAmount,
            cancellationHeader: data.cancellationHeader,
            cancellationPolicy: data.cancellationPolicy,
            bookingUrn: argument!.bookingUrn,
            promoBloc: _promoWidgetBloc,
            merchantId: data.ticketId,
            updatedPromoDiscount: (discount) {
              _updatePromoDataInProvider();
              _ticketConfirmBookingBloc.updatePromoDiscount(discount);
              _virtualPaymentBloc.updateWalletPaidAmountAfterPromoApplied(
                  data.getWalletAmountTobeDeducted(
                      _virtualPaymentBloc.state.balance ?? 0.0));
            },
            virtualPaymentBloc: _virtualPaymentBloc,
            walletAmountTobeDeducted: data.getWalletAmountTobeDeducted(
                _virtualPaymentBloc.state.balance ?? 0.0),
            grandTotalWithWalletAmount: data.getGrandTotalWithWalletApplied(
                _virtualPaymentBloc.isWalletOn(),
                _virtualPaymentBloc.state.balance ?? 0.0),
          );
        });
  }

  Widget _getCardWidget() {
    return Container(
      color: AppColors.kLight100,
      child: BlocBuilder(
        bloc: _paymentMethodBloc,
        builder: () {
          return _paymentMethodBloc.state.paymentMethodViewState ==
                  PaymentMethodViewState.success
              ? Column(
                  children: [
                    TicketConfirmBookingHeaderWidget(
                      headerText: getTranslated(context,
                          AppLocalizationsStrings.paymentMethodsPaymentMain),
                      height: _kCardHeaderSpacing,
                      tailingText: getTranslated(context,
                          AppLocalizationsStrings.selectPaymentMethods),
                      onTap: _onPaymentSelectionTapped,
                    ),
                    TicketConfirmBookingCardItem(
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

  Widget _getBottomBar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: kSize20),
        child: OtaTextButton(
          title: getTranslated(context, AppLocalizationsStrings.paymentLabels),
          key: const Key("BookNowButton"),
          textHorizontalPadding: kSize86,
          onPressed: () => _checkNetPrice(),
        ),
      ),
    );
  }

  void _checkNetPrice() {
    bool isValidationFailed =
        TicketConfirmBookingHelper.isMinAmountValidationFailed(
      isWalletEnabled: _virtualPaymentBloc.isWalletOn(),
      paidByWallet: _virtualPaymentBloc.state.walletPaidAmmount,
      onlinePayableAmount: _ticketConfirmBookingBloc.state.data!
          .getGrandTotalWithWalletApplied(_virtualPaymentBloc.isWalletOn(),
              _virtualPaymentBloc.state.balance ?? 0.0),
    );

    _getAppFlyerClickParameters();
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
      _getAppFlyerPaymentSuccessParameters();
      _getAppFlyerPaymentSuccessParametersForFirstOrder();
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
      AppRoutes.ticketGuestDetailScreen,
      arguments: _ticketConfirmBookingBloc.state.data!.participantList,
    );
  }

  void _navigateToPaymentLoadingPage() async {
    TicketConfirmBookingModel data = _ticketConfirmBookingBloc.state.data!;
    OtaReservationSuccessArgumentModel reservationArgumentModel =
        OtaReservationSuccessArgumentModel(
      id: data.ticketId,
      serviceCardType: ServiceCardType.tour,
      bookingForTicket: true,
      providerName: data.ticketName,
      packageName: data.packageName,
      imageUrl: data.ticketImageUrl,
      highlights:
          TicketConfirmBookingHelper.getHighLightList(data.ticketHighLights),
      tourOrTicketsType:
          TicketConfirmBookingHelper.getTourOrTicketTypeList(data.ticketList),
      bookingDate: data.bookingDate,
      noOfDays: int.tryParse(data.noOfDays),
      activityDuration: data.durationText,
      referenceId: data.bookingUrn,
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
      bookingUrn: _ticketConfirmBookingBloc.state.data!.bookingUrn,
      newbookingUrn: _initialPaymentBookingUrn,
      paymentDetails: _getPaymentMethodDetails(
        paymentMethod: _paymentMethodBloc.getSelectedPaymentMethod(),
        cardRef: _paymentMethodBloc.getDefaultPaymentMethod()!.cardRef,
        cardType: cardType,
        paymentMethodId: paymentMethodId,
        paidByWalletPrice: _virtualPaymentBloc.state.walletPaidAmmount,
        payablePrice: _ticketConfirmBookingBloc.state.data!
            .getGrandTotalWithWalletApplied(_virtualPaymentBloc.isWalletOn(),
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

  void _getAppFlyerClickParameters() {
    _logger.addKeyValue(
        key: TicketPaymentAppFlyer.ticketPlaceId,
        value: _ticketConfirmBookingBloc.state.data?.ticketId);
    _logger.addKeyValue(
        key: TicketPaymentAppFlyer.ticketActivityId,
        value: _ticketConfirmBookingBloc.state.data?.ticketId);
    _logger.addCurrency(key: TicketPaymentAppFlyer.ticketCurrency);
    _logger.addUserLocation();
    _logger.addKeyValue(
        key: TicketPaymentAppFlyer.ticketLocation,
        value: _ticketConfirmBookingBloc.state.data?.location);
    _getAppFlyerDefaultTicketTypes();
    _getAppFlyerTicketTypes(_ticketConfirmBookingBloc.state.data?.ticketList);
    _logger.addKeyValue(
        key: TicketPaymentAppFlyer.ticketPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    _logger.addDoubleValue(
        key: TicketPaymentAppFlyer.ticketPromoAmount,
        value: _promoWidgetBloc.state.data?.priceViewModel?.effectiveDiscount);
    _logger.addKeyValue(
        key: TicketPaymentAppFlyer.ticketPromoType,
        value: _promoWidgetBloc.state.data?.promotion.promotionType);
    _logger.addKeyValue(
        key: TicketPaymentAppFlyer.ticketPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());
    _logger.addKeyValue(
        key: TicketPaymentAppFlyer.ticketContentId,
        value: _ticketConfirmBookingBloc.state.data?.ticketId);
    _logger.addContentType(key: TicketPaymentAppFlyer.ticketContentType);
    _logger.publishToSuperApp(AppFlyerEvent.ticketPaymentEvent);
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
          _logger.addIntValue(
              key: TicketPaymentAppFlyer.ticketPaxAQuantity,
              value: ticketTypeList[i].noOfTickets);
          _logger.addDoubleValue(
              key: TicketPaymentAppFlyer.ticketPaxAPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        } else if (i == 1) {
          _logger.addIntValue(
              key: TicketPaymentAppFlyer.ticketPaxBQuantity,
              value: ticketTypeList[i].noOfTickets);
          _logger.addDoubleValue(
              key: TicketPaymentAppFlyer.ticketPaxBPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        } else if (i == 2) {
          _logger.addIntValue(
              key: TicketPaymentAppFlyer.ticketPaxCQuantity,
              value: ticketTypeList[i].noOfTickets);
          _logger.addDoubleValue(
              key: TicketPaymentAppFlyer.ticketPaxCPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        } else if (i == 3) {
          _logger.addIntValue(
              key: TicketPaymentAppFlyer.ticketPaxDQuantity,
              value: ticketTypeList[i].noOfTickets);
          _logger.addDoubleValue(
              key: TicketPaymentAppFlyer.ticketPaxDPerPrice,
              value: ticketTypeList[i].price);
          ticketQuantity = ticketQuantity + ticketTypeList[i].noOfTickets;
        }
      }
      _logger.addIntValue(
          key: TicketPaymentAppFlyer.ticketTotalQuantity,
          value: ticketQuantity);
    }
  }

  void _getAppFlyerDefaultTicketTypes() {
    for (int i = 0; i < 4; i++) {
      if (i == 0) {
        _logger.addIntValue(
            key: TicketPaymentAppFlyer.ticketPaxAQuantity, value: 0);
        _logger.addDoubleValue(
            key: TicketPaymentAppFlyer.ticketPaxAPerPrice, value: 0.0);
      } else if (i == 1) {
        _logger.addIntValue(
            key: TicketPaymentAppFlyer.ticketPaxBQuantity, value: 0);
        _logger.addDoubleValue(
            key: TicketPaymentAppFlyer.ticketPaxBPerPrice, value: 0.0);
      } else if (i == 2) {
        _logger.addIntValue(
            key: TicketPaymentAppFlyer.ticketPaxCQuantity, value: 0);
        _logger.addDoubleValue(
            key: TicketPaymentAppFlyer.ticketPaxCPerPrice, value: 0.0);
      } else if (i == 3) {
        _logger.addIntValue(
            key: TicketPaymentAppFlyer.ticketPaxDQuantity, value: 0);
        _logger.addDoubleValue(
            key: TicketPaymentAppFlyer.ticketPaxDPerPrice, value: 0.0);
      }
    }
  }

  void _getAppFlyerPaymentSuccessParameters() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
        key: TicketPaymentSuccessAppFlyer.ticketPlaceId,
        value: _ticketConfirmBookingBloc.state.data?.ticketId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
        key: TicketPaymentSuccessAppFlyer.ticketActivityId,
        value: _ticketConfirmBookingBloc.state.data?.ticketId);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
        key: TicketPaymentSuccessAppFlyer.ticketLocation,
        value: _ticketConfirmBookingBloc.state.data?.location);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
        key: TicketPaymentSuccessAppFlyer.ticketPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
        key: TicketPaymentSuccessAppFlyer.ticketPromoAmount,
        value: _promoWidgetBloc.state.data?.priceViewModel?.effectiveDiscount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
        key: TicketPaymentSuccessAppFlyer.ticketPromoType,
        value: _promoWidgetBloc.state.data?.promotion.promotionType);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
        key: TicketPaymentSuccessAppFlyer.ticketPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessEvent,
        key: TicketPaymentSuccessAppFlyer.ticketContentId,
        value: _ticketConfirmBookingBloc.state.data?.ticketId);
  }

  void _getAppFlyerPaymentSuccessParametersForFirstOrder() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
        key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPlaceId,
        value: _ticketConfirmBookingBloc.state.data?.ticketId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
        key: TicketPaymentSuccessFirstOrderAppFlyer.ticketActivityId,
        value: _ticketConfirmBookingBloc.state.data?.ticketId);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
        key: TicketPaymentSuccessFirstOrderAppFlyer.ticketLocation,
        value: _ticketConfirmBookingBloc.state.data?.location);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
        key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPromoCode,
        value: _promoWidgetBloc.state.data?.promotion.promotionCode);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
        key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPromoAmount,
        value: _promoWidgetBloc.state.data?.priceViewModel?.effectiveDiscount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
        key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPromoType,
        value: _promoWidgetBloc.state.data?.promotion.promotionType);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
        key: TicketPaymentSuccessFirstOrderAppFlyer.ticketPaymentType,
        value: _paymentMethodBloc.getSelectedPaymentMethod());
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketPaymentSuccessFirstBookingEvent,
        key: TicketPaymentSuccessFirstOrderAppFlyer.ticketContentId,
        value: _ticketConfirmBookingBloc.state.data?.ticketId);
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
