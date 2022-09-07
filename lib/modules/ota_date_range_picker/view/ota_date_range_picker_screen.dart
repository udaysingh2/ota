import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_period_selector/ota_date_range_picker.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/ota_date_range_picker/view_model/ota_date_range_picker_argument_model.dart';

class OtaDateRangePickerScreen extends StatelessWidget {
  const OtaDateRangePickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argumet = ModalRoute.of(context)?.settings.arguments
        as OtaDateRangePickerArgumentModel;
    return Scaffold(
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.checkInCheckOutDate),
      ),
      body: OTADateRangePicker(
        isBottomSheet: false,
        preSetCheckinDate: argumet.checkInDate,
        preSetCheckoutDate: argumet.checkOutDate,
        buttonText: getTranslated(context, AppLocalizationsStrings.ok),
        onSumbit: (checkinDate, checkoutDate) {
          Navigator.of(context).pop(OtaDateRangePickerArgumentModel(
            checkInDate: checkinDate,
            checkOutDate: checkoutDate,
          ));
        },
      ),
    );
  }
}
