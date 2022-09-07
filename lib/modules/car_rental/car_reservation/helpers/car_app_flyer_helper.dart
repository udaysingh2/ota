import 'package:flutter/material.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';

class CarAppFlyerHelper {
  String addCarFormatDateValue({required DateTime? value}) {
    return value != null
        ? Helpers.getYYYYmmddFromDateTime(value).addTrailingSpace() +
            Helpers.gethhmm(value)
        : "";
  }

  String getDateTimeAsString({required DateTime? value}) {
    return value != null ? Helpers.getYYYYmmddFromDateTime(value) : '';
  }

  List<String> getAllAddOnItems({required List<ExtraChargeData> extraCharge}) {
    List<String> addOnItemString = [];

    for (int i = 0; i < extraCharge.length; i++) {
      addOnItemString.add(extraCharge[i].extraChargeGroup!.name ?? '');
    }
    return addOnItemString;
  }

  getAddOnsList(List<String> parameterList, String valueName) {
    if (parameterList.contains(valueName)) {
      parameterList.remove(valueName);
    }
    parameterList.add(valueName);
  }

  removeDeletedAddOns(List<String> parameterList, String valueName) {
    parameterList.remove(valueName);
  }

  static TimeOfDay getOnlyTimeFromDate(DateTime? dateTime) {
    return TimeOfDay(hour: dateTime!.hour, minute: dateTime.minute);
  }
}
