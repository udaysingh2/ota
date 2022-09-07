import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_payment_error_payment_parameters.dart';
import 'package:ota/modules/payment_method/view/widgets/payment_loading_widget.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';
import 'package:ota/modules/tours/payment_status/bloc/payment_status_bloc.dart';
import 'package:ota/modules/tours/payment_status/view_model/payment_status_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String _replacementString = ". ";
const String _nextLineString = ".\n";
bool isFirstOrder = false;

class NewPaymentLoadingScreen extends StatefulWidget {
  const NewPaymentLoadingScreen({Key? key}) : super(key: key);

  @override
  NewPaymentLoadingScreenState createState() => NewPaymentLoadingScreenState();
}

class NewPaymentLoadingScreenState extends State<NewPaymentLoadingScreen> {
  final PaymentStatusBloc _paymentStatusBloc = PaymentStatusBloc();
  late OtaCountDownController _otaCountDownController;
  PaymentMethodInitiateArgument? _argument;

  void _initialize() {
    _paymentStatusBloc.stream.listen((event) {
      if (_paymentStatusBloc.isInternetFailure) {
        _showInternetFailureAlert();
      } else if (_paymentStatusBloc.isFailure) {
        getPaymentErrorDataFirebase(FirebaseEvent.activityPaymentSubmitError,
            FirebaseEvent.activityPromoRedeemError);
        _showPaymentFailureAlert();
      } else if (_paymentStatusBloc.isFailure3000) {
        getPaymentErrorDataFirebase(FirebaseEvent.activityPromoRedeemError,
            FirebaseEvent.activityPaymentSubmitError);
        _showPromoRedeemFailureAlert(
            AppLocalizationsStrings.failurePromoOnPayment3000);
      } else if (_paymentStatusBloc.state.paymentStatusViewState ==
          PaymentStatusViewState.deeplinkFound) {
        _paymentStatusBloc.setDeepLinkAsFound();
        _openDeepLinkUrl(
            _paymentStatusBloc.state.paymentStatusModel?.deeplinkUrl);
      } else if (_paymentStatusBloc.isSuccess) {
        _otaCountDownController.cancelTimer();
        isFirstOrder =
            _paymentStatusBloc.state.paymentStatusModel?.isFirstOrder ?? false;
        Navigator.pushNamed(context, AppRoutes.otaReservationSuccessScreen,
            arguments: isFirstOrder);
      }
    });
  }

  void _openDeepLinkUrl(String? url) async {
    if (url != null && await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  @override
  void dispose() {
    _paymentStatusBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _argument = ModalRoute.of(context)?.settings.arguments
          as PaymentMethodInitiateArgument?;
      if (_argument != null && _argument!.newbookingUrn.isNotEmpty) {
        _paymentStatusBloc.getNewBookingUrnData(_argument!);
      } else {
        _paymentStatusBloc.getPaymentInitiateDataV2(_argument, DateTime.now());
      }
      if (_argument != null) {
        _otaCountDownController = _argument!.otaCountDownController!;
        _otaCountDownController.isTimeOutDisabled = true;
      }
      _initialize();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: PaymentLoadingScreenWidget(
          title: getTranslated(
              context, AppLocalizationsStrings.tourLoadingPaymentHeader)),
    );
  }

  Future<void> _showPaymentFailureAlert() async => await OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.paymentErrorMessage),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        useRootNavigator: false,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pop(context, _argument!.bookingUrn);
        },
      ).showAlertDialog(context);

  Future<void> _showInternetFailureAlert() async => await OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.noInternetConnection)
                .replaceAll(_replacementString, _nextLineString),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        useRootNavigator: false,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pop(context, _argument!.bookingUrn);
        },
      ).showAlertDialog(context);

  Future<void> _showPromoRedeemFailureAlert(String appLocalizationKey) async {
    await OtaAlertDialog(
      errorTitle:
          getTranslated(context, AppLocalizationsStrings.unableToProceed),
      errorMessage: getTranslated(context, appLocalizationKey),
      buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
      useRootNavigator: false,
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.pop(context, _argument!.bookingUrn);
      },
    ).showAlertDialog(context);
  }

  void getPaymentErrorDataFirebase(String eventName, String clearEvent) {
    FirebaseHelper.addKeyValue(
        key: ActivityPaymentErrorPaymentFirebase.activityErrorCode,
        eventName: eventName,
        value: ActivityPaymentErrorPaymentFirebase.errorCodePayment);
    FirebaseHelper.addKeyValue(
        key: ActivityPaymentErrorPaymentFirebase.activityErrorDescription,
        eventName: eventName,
        value: eventName == FirebaseEvent.activityPaymentSubmitError
            ? ActivityPaymentErrorPaymentFirebase.errorDescriptionPayment ??
                getTranslated(
                    context, AppLocalizationsStrings.paymentErrorMessage)
            : ActivityPaymentErrorPaymentFirebase.errorDescriptionPayment ??
                getTranslated(context,
                    AppLocalizationsStrings.failurePromoOnPayment3000));
    FirebaseHelper.stopCapturingEvent(eventName);
    FirebaseHelper.clearEvent(clearEvent);
  }
}
