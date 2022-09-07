import 'package:flutter/material.dart';

class DateTimeHelper {
  static bool isSubmitDisabled(
    DateTime checkInDate,
    DateTime checkOutDate,
    TimeOfDay checkInTime,
    TimeOfDay checkOutTime,
  ) {
    if (checkInDate == checkOutDate) {
      int hour = checkOutTime.hour - checkInTime.hour;

      if (hour < 2) {
        return true;
      }
    }
    return false;
  }
}
