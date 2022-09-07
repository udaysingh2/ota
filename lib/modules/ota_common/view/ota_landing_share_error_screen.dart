import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class OtaLandingShareErrorScreen extends StatefulWidget {
  const OtaLandingShareErrorScreen({Key? key}) : super(key: key);

  @override
  State<OtaLandingShareErrorScreen> createState() =>
      _OtaLandingShareErrorScreen();
}

class _OtaLandingShareErrorScreen extends State<OtaLandingShareErrorScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _showInvalidUrlAlert();
    });

    super.initState();
  }

  Future<void> _showInvalidUrlAlert() async => await OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.invalidShareingUrl),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.ok),
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
