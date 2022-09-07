import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kErrorNetwork = "Error_Network";

class InsuranceErrorWebViewScreen extends StatefulWidget {
  const InsuranceErrorWebViewScreen({Key? key}) : super(key: key);

  @override
  State<InsuranceErrorWebViewScreen> createState() =>
      _InsuranceWebViewScreenState();
}

class _InsuranceWebViewScreenState extends State<InsuranceErrorWebViewScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final String statusCode =
          ModalRoute.of(context)?.settings.arguments as String;
      if (statusCode == _kErrorNetwork) {
        _showInternetFailureAlert();
      } else {
        _showFailureAlert1999();
      }
    });

    super.initState();
  }

  Future<void> _showInternetFailureAlert() async => await OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.noInternet),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        useRootNavigator: false,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ).showAlertDialog(context);

  Future<void> _showFailureAlert1999() async => await OtaAlertDialog(
        errorMessage: getTranslated(context, AppLocalizationsStrings.error1999),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        useRootNavigator: false,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ).showAlertDialog(context);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox());
  }
}
