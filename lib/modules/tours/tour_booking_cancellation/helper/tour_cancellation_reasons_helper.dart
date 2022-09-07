import 'package:ota/common/utils/app_localization_strings.dart';

int _kEightHours = 20;
int _kMinute = 00;
int _kSecond = 59;

class TourCancellationReasonsHelper {
  static List<String> cancellationReasons = [
    AppLocalizationsStrings.cancelResFoundAnotherPlaceGo,
    AppLocalizationsStrings.cancelResMyTourCancelled,
    AppLocalizationsStrings.cancelResUnableTravelCovid19,
    AppLocalizationsStrings.changeNumberOfTraveller,
    AppLocalizationsStrings.changeTravelDateOrDestination,
    AppLocalizationsStrings.cancelResOther,
  ];

  static bool checkBeforeEight(DateTime from, DateTime date) {
    var newHour = _kEightHours;
    var newMinute = _kMinute;
    DateTime fromDateTime =
        DateTime(from.year, from.month, from.day, newHour, newMinute);
    return date.isBefore(fromDateTime);
  }

  static bool checkAfterEight(DateTime from, DateTime date) {
    var newHour = _kEightHours;
    var newMinute = _kMinute;
    DateTime fromDateTime =
        DateTime(from.year, from.month, from.day, newHour, newMinute);
    return date.isAfter(fromDateTime);
  }

  static bool checkAfterEightToday(DateTime date) {
    var newHour = _kEightHours;
    var newMinute = _kMinute;
    var newSecond = _kSecond;
    DateTime fromDateTime = DateTime(
        date.year, date.month, date.day, newHour, newMinute, newSecond);
    return date.isAfter(fromDateTime);
  }

  static int getRemainingDuration(DateTime dateToCheck) {
    var newHour = _kEightHours;
    var newMinute = _kMinute;
    var newSecond = _kSecond;
    DateTime dateTime = DateTime(dateToCheck.year, dateToCheck.month,
        dateToCheck.day, newHour, newMinute, newSecond);
    return dateTime.millisecondsSinceEpoch -
        DateTime.now().millisecondsSinceEpoch;
  }
}
