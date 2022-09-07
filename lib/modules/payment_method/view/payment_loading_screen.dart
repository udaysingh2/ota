import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_payment_success_first_order_parameters.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_payment_success_purchase_order.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_success_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_payment_promo_error_parameters.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_payment_review_parameters.dart';
import 'package:ota/modules/car_rental/car_reservation/helpers/car_app_flyer_helper.dart';
import 'package:ota/modules/payment_method/bloc/payment_status_bloc.dart';
import 'package:ota/modules/payment_method/view/widgets/payment_loading_widget.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';
import 'package:ota/modules/payment_method/view_model/payment_status_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

// const _kSuccess = "SuccessScreen";

class PaymentLoadingScreen extends StatefulWidget {
  const PaymentLoadingScreen({Key? key}) : super(key: key);

  @override
  PaymentLoadingScreenState createState() => PaymentLoadingScreenState();
}

class PaymentLoadingScreenState extends State<PaymentLoadingScreen> {
  late OtaCountDownController _otaCountDownController;
  final PaymentMethodStatusViewBloc _paymentStatusBloc =
      PaymentMethodStatusViewBloc();
  PaymentMethodInitiateArgument? argument;
  AppFlyerHelper appFlyerHelper = AppFlyerHelper();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      argument = ModalRoute.of(context)?.settings.arguments
          as PaymentMethodInitiateArgument;
      if (argument!.newbookingUrn.isNotEmpty) {
        _paymentStatusBloc.getNewBookingUrn(argument);
      } else {
        _paymentStatusBloc.getInitialPaymentV2(argument, DateTime.now());
      }
      _otaCountDownController = argument!.otaCountDownController!;
      _otaCountDownController.isTimeOutDisabled = true;
      initialize();
    });
    super.initState();
  }

  @override
  void dispose() {
    _paymentStatusBloc.dispose();
    super.dispose();
  }

  void initialize() {
    _paymentStatusBloc.stream.listen((event) {
      if (_paymentStatusBloc.state.pageState ==
          PaymentStatusViewPageState.failure) {
        _launchFirebaseEventForPaymentFailure();
        _showPaymentFailureAlert();
      } else if (_paymentStatusBloc.isFailure3000) {
        _launchFirebaseEventForPromoFailure();
        _showPromoRedeemFailureAlert(
            AppLocalizationsStrings.failurePromoOnPayment3000);
      } else if (_paymentStatusBloc.state.pageState ==
          PaymentStatusViewPageState.internetFailure) {
        _showNoInternetAlert();
      } else if (_paymentStatusBloc.state.pageState ==
          PaymentStatusViewPageState.deeplinkFound) {
        _paymentStatusBloc.setDeepLinkAsFound();
        _openDeepLinkUrl(_paymentStatusBloc.state.data?.deeplinkUrl);
      } else if (_paymentStatusBloc.state.pageState ==
          PaymentStatusViewPageState.success) {
        _otaCountDownController.cancelTimer();
        if (argument?.screenComingFrom == ScreenToPayment.hotel) {
          HotelPaymentSuccessAppFlyer.isFirstOrder =
              _paymentStatusBloc.state.data?.isFirstOrder ?? false;
          Navigator.pushNamed(context, AppRoutes.hotelSuccessPaymentScreen);
        } else {
          _paymentStatusBloc.state.data?.isFirstOrder ?? false
              ? _launchAppFlyerEventForFirstOrder()
              : _launchAppFlyerEventForPurchaseOrder();
          FirebaseHelper.stopCapturingEvent(FirebaseEvent.carBookingSuccess);
          Navigator.pushNamed(context, AppRoutes.carPaymentSuccessScreen,
              arguments: argument?.carPaymentArgumentModel);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(body: Container(child: _getBody())));
  }

  Widget _getBody() {
    return _loadingWidget();
  }

  void _openDeepLinkUrl(String? url) async {
    if (url != null && await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  Widget _loadingWidget() {
    return const PaymentLoadingScreenWidget();
  }

  Future<void> _showPaymentFailureAlert() async {
    await OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.paymentErrorMessage),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        useRootNavigator: false,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pop(context, argument!.bookingUrn);
        }).showAlertDialog(context);
  }

  Future<void> _showNoInternetAlert() async {
    await OtaNoInternetAlertDialog().showAlertDialog(context, onOkClick: () {
      Navigator.of(context).pop();
      Navigator.pop(context, argument!.bookingUrn);
    });
  }

  Future<void> _showPromoRedeemFailureAlert(String appLocalizationKey) async {
    await OtaAlertDialog(
      errorTitle:
          getTranslated(context, AppLocalizationsStrings.unableToProceed),
      errorMessage: getTranslated(context, appLocalizationKey),
      buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
      useRootNavigator: false,
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.pop(context, argument!.bookingUrn);
      },
    ).showAlertDialog(context);
  }

  Map<String, String> _getAppFlyerParameterDataForFirstOrder() {
    return {
      CarPaymentSuccessFirstOrderAppFlyer.carId: argument
              ?.carPaymentArgumentModel
              ?.carReservationViewArgumentModel
              ?.carId ??
          '',
      CarPaymentSuccessFirstOrderAppFlyer.carAgencyId: argument
              ?.carPaymentArgumentModel
              ?.carReservationViewArgumentModel
              ?.supplierId ??
          '',
      CarPaymentSuccessFirstOrderAppFlyer.carPickUpLocation:
          argument?.carPaymentArgumentModel?.pickUpPoint ?? '',
      CarPaymentSuccessFirstOrderAppFlyer.carDropOffLocation:
          argument?.carPaymentArgumentModel?.droffPoint ?? '',
      CarPaymentSuccessFirstOrderAppFlyer.carPaymentType:
          argument?.paymentDetails?[0].paymentMethod ?? '',
      CarPaymentSuccessFirstOrderAppFlyer.carContentId: argument
              ?.carPaymentArgumentModel
              ?.carReservationViewArgumentModel
              ?.carId ??
          '',
    };
  }

  void _getAppFlyerParametersForFirstOrder() {
    AppFlyerHelper.addParameters(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        parameter: _getAppFlyerParameterDataForFirstOrder());

    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carPickUpDate,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: argument?.carPaymentArgumentModel
                ?.carReservationViewArgumentModel?.pickupDate));
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carReturnDate,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: argument?.carPaymentArgumentModel
                ?.carReservationViewArgumentModel?.returnDate));
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carRentalPrice,
        value: argument?.carPaymentArgumentModel?.pricePerDay);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carRentalPeriod,
        value: argument?.carPaymentArgumentModel?.duration);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carNoOfPassengers,
        value: argument?.carPaymentArgumentModel?.seatNbr);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carCurrency);
    AppFlyerHelper.addContentType(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent,
        key: CarPaymentSuccessFirstOrderAppFlyer.carContentType);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.carFirstOrderPaymentSuccessEvent);
  }

  Map<String, String> _getAppFlyerParameterDataForPurchaseOrder() {
    return {
      CarPaymentSuccessPurchaseOrderAppFlyer.carId: argument
              ?.carPaymentArgumentModel
              ?.carReservationViewArgumentModel
              ?.carId ??
          '',
      CarPaymentSuccessPurchaseOrderAppFlyer.carAgencyId: argument
              ?.carPaymentArgumentModel
              ?.carReservationViewArgumentModel
              ?.supplierId ??
          '',
      CarPaymentSuccessPurchaseOrderAppFlyer.carPickUpLocation:
          argument?.carPaymentArgumentModel?.pickUpPoint ?? '',
      CarPaymentSuccessPurchaseOrderAppFlyer.carDropOffLocation:
          argument?.carPaymentArgumentModel?.droffPoint ?? '',
      CarPaymentSuccessPurchaseOrderAppFlyer.carPaymentType:
          argument?.paymentDetails?[0].paymentMethod ?? '',
      CarPaymentSuccessPurchaseOrderAppFlyer.carContentId: argument
              ?.carPaymentArgumentModel
              ?.carReservationViewArgumentModel
              ?.carId ??
          '',
    };
  }

  void _getAppFlyerParametersForPurchaseOrder() {
    AppFlyerHelper.addParameters(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        parameter: _getAppFlyerParameterDataForPurchaseOrder());

    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carPickUpDate,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: argument?.carPaymentArgumentModel
                ?.carReservationViewArgumentModel?.pickupDate));
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carReturnDate,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: argument?.carPaymentArgumentModel
                ?.carReservationViewArgumentModel?.returnDate));
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carRentalPrice,
        value: argument?.carPaymentArgumentModel?.pricePerDay);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carRentalPeriod,
        value: argument?.carPaymentArgumentModel?.duration);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carNoOfPassengers,
        value: argument?.carPaymentArgumentModel?.seatNbr);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carCurrency);
    AppFlyerHelper.addContentType(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent,
        key: CarPaymentSuccessPurchaseOrderAppFlyer.carContentType);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.carPurchasePaymentSuccessEvent);
  }

  void _launchAppFlyerEventForFirstOrder() {
    _getAppFlyerParametersForFirstOrder();

    AppFlyerHelper.stopCapturingEvent(
        AppFlyerEvent.carFirstOrderPaymentSuccessEvent);
    AppFlyerHelper.clearEvent(AppFlyerEvent.carPurchasePaymentSuccessEvent);
  }

  void _launchAppFlyerEventForPurchaseOrder() {
    _getAppFlyerParametersForPurchaseOrder();
    AppFlyerHelper.stopCapturingEvent(
        AppFlyerEvent.carPurchasePaymentSuccessEvent);
    AppFlyerHelper.clearEvent(AppFlyerEvent.carFirstOrderPaymentSuccessEvent);
  }

  void _launchCarPaymentPromoFailureFirebase(
      String eventName, String clearEvent) {
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carPromoErrorCode,
        value: CarPaymentPromoErrorFirebase.errorCode);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: CarPaymentPromoErrorFirebase.carPromoErrorDesc,
        value: eventName == FirebaseEvent.carPaymentErrorEvent
            ? CarPaymentPromoErrorFirebase.errorDescription ??
                getTranslated(
                    context, AppLocalizationsStrings.paymentErrorMessage)
            : CarPaymentPromoErrorFirebase.errorDescription ??
                getTranslated(context,
                    AppLocalizationsStrings.failurePromoOnPayment3000));
    FirebaseHelper.stopCapturingEvent(eventName);
    FirebaseHelper.clearEvent(clearEvent);
  }

  void _triggerHotelPaymentPromoFailureFirebase(
      String eventName, String clearEvent) {
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: HotelPaymentReviewFirebase.hotelErrorCode,
        value: HotelPaymentReviewFirebase.errorCode);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: HotelPaymentReviewFirebase.hotelErrorDescription,
        value: eventName == FirebaseEvent.hotelPaymentError
            ? HotelPaymentReviewFirebase.errorDescription ??
                getTranslated(
                    context, AppLocalizationsStrings.paymentErrorMessage)
            : HotelPaymentReviewFirebase.errorDescription ??
                getTranslated(context,
                    AppLocalizationsStrings.failurePromoOnPayment3000));
    FirebaseHelper.stopCapturingEvent(eventName);
    FirebaseHelper.clearEvent(clearEvent);
  }

  void _launchFirebaseEventForPaymentFailure() {
    if (argument?.screenComingFrom == ScreenToPayment.hotel) {
      _triggerHotelPaymentPromoFailureFirebase(
          FirebaseEvent.hotelPaymentError, FirebaseEvent.hotelPromoRedeemError);
    } else {
      _launchCarPaymentPromoFailureFirebase(FirebaseEvent.carPaymentErrorEvent,
          FirebaseEvent.carAddPromoErrorEvent);
    }
  }

  void _launchFirebaseEventForPromoFailure() {
    if (argument?.screenComingFrom == ScreenToPayment.hotel) {
      _triggerHotelPaymentPromoFailureFirebase(
          FirebaseEvent.hotelPromoRedeemError, FirebaseEvent.hotelPaymentError);
    } else {
      _launchCarPaymentPromoFailureFirebase(FirebaseEvent.carAddPromoErrorEvent,
          FirebaseEvent.carPaymentErrorEvent);
    }
  }
}
