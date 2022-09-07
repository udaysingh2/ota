import 'package:ota/common/utils/helper.dart';

class DateCheckHelper {
  static bool checkIfAfterToday(DateTime date) {
    DateTime now = DateTime.now();
    String dateString = Helpers.getYYYYmmddFromDateTime(date);
    String nowString = Helpers.getYYYYmmddFromDateTime(now);
    if (date.isAfter(now) && dateString != nowString) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkIfBeforeToday(DateTime date) {
    DateTime now = DateTime.now();
    String dateString = Helpers.getYYYYmmddFromDateTime(date);
    String nowString = Helpers.getYYYYmmddFromDateTime(now);
    if (date.isBefore(now) && dateString != nowString) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkIfTodayOrAfter(DateTime date) {
    DateTime now = DateTime.now();
    String dateString = Helpers.getYYYYmmddFromDateTime(date);
    String nowString = Helpers.getYYYYmmddFromDateTime(now);
    if (date.isAfter(now) || dateString == nowString) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkIfTodayOrBefore(DateTime date) {
    DateTime now = DateTime.now();
    String dateString = Helpers.getYYYYmmddFromDateTime(date);
    String nowString = Helpers.getYYYYmmddFromDateTime(now);
    if (date.isBefore(now) || dateString == nowString) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkIfToday(DateTime date) {
    DateTime now = DateTime.now();
    String dateString = Helpers.getYYYYmmddFromDateTime(date);
    String nowString = Helpers.getYYYYmmddFromDateTime(now);
    if (dateString == nowString) {
      return true;
    } else {
      return false;
    }
  }
}
