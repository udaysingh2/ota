import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_period_selector/ota_date_time_picker/ota_date_time_range_picker.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_date_time_selection/model/car_date_time_selection_argument_model.dart';

class CarDateTimeSelectionScreen extends StatelessWidget {
  const CarDateTimeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argumet = ModalRoute.of(context)?.settings.arguments
        as CarDateTimePickerArgumentModel;
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(
            context, AppLocalizationsStrings.pickUpAndDropOffDate),
      ),
      body: OtaDateTimeRangePicker(
        titleKey: AppLocalizationsStrings.selectDataAndTime,
        preSetCheckinDate: argumet.pickUpDate,
        preSetCheckoutDate: argumet.dropOffDate,
        isBottomSheet: false,
        onSumbit: (checkinDate, checkoutDate) {
          Navigator.of(context).pop(
            CarDateTimePickerArgumentModel(
              pickUpDate: checkinDate,
              dropOffDate: checkoutDate,
            ),
          );
        },
      ),
    );
  }
}
