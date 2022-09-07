import 'package:flutter/material.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_date_selector/ota_grid_vscroll_date_picker.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class OtaDateSelectionScreen extends StatelessWidget {
  const OtaDateSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime preSetDate =
        ModalRoute.of(context)?.settings.arguments as DateTime;
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.changeDate),
      ),
      body: OTAGridVScrollDateRangePicker(
        preSelectedDate: preSetDate,
        onSubmit: (date) async => await _isInternetConnected()
            ? Navigator.of(context).pop(date)
            : OtaNoInternetAlertDialog().showAlertDialog(context),
      ),
    );
  }

  Future<bool> _isInternetConnected() async {
    InternetConnectionInfo internetConnectionInfo =
        InternetConnectionInfoImpl();
    return await internetConnectionInfo.isConnected;
  }
}
