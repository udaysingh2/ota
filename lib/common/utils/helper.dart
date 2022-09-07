import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';

import 'consts.dart';

const _kddMMMyyyy = 'd MMM yyyy';
const _kddMMMyy = 'dd MMM yy';
const _kwwddMMMyyyy = 'E d MMM yyyy';
const _kwwddMMMyy = 'E d MMM yy';
const _kyyyyMMdd = 'yyyy-MM-dd';
const _kyyyyMMddhhmmss = 'yyyy-MM-dd hh:mm:ss';
const _kyyyyMMddhhmm = 'yyyy-MM-dd hh:mm';
const _kyyyyMMddHHmm = 'yyyy-MM-dd HH:mm';
const _kMMM = 'MMM';
const _kEEE = 'EEE';
const _kyyyy = 'yyyy';
const _kyy = 'yy';
const _kd = 'd';
const _kddMMMyyyykkmm = "d MMMM yyyy  kk:mm";
const _kddMMyyyy = 'dd/MM/yyyy';
const _khhmm = "HH:mm";
const _kyyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss";
const _kddMMMyyyyhhmm = "d MMMM yyyy, HH:mm";
const _khhmmss = "HH:mm:ss";
const _kwwddMMMyyhhmm = 'E d MMM yy, HH:mm';
const _kddMMMyyhhmm = "d MMM yy, HH:mm";

class Helpers {
  static int daysBetween({required String start, required String end}) {
    return (Helpers()
        .parseDateTime(end)
        .difference(Helpers().parseDateTime(start))
        .inDays);
  }

  static String getddMMMyyyy(DateTime date) {
    DateFormat d = DateFormat(_kddMMMyyyy, AppConfig().appLocale.languageCode);
    return getBuddhistDate(d.format(date), date.year);
  }

  ///Convert Date to Buddhist Calender Date for Thai.
  static String getBuddhistDate(String date, int year) {
    if (AppConfig().appLocale.languageCode == LanguageCodes.thai.code) {
      return date.replaceAll(year.toString(), getBuddhistYear(year).toString());
    }
    return date;
  }

  static int getBuddhistYear(int year) {
    return year + kBuddhistYearOffsetCalendar;
  }

  ///Convert Date to Buddhist Calender Date in "dd MMM yy" format for Thai and English.
  static String getddMMMyy(DateTime date) {
    DateFormat d = DateFormat(_kddMMMyy, AppConfig().appLocale.languageCode);
    return getBuddhistDateYY(d.format(date), date.year);
  }

  static String getBuddhistDateYY(String date, int year) {
    if (AppConfig().appLocale.languageCode == LanguageCodes.thai.code) {
      return date.replaceFirst(' ${year.toString().substring(2)}',
          ' ${getBuddhistYearYY(year).toString()}');
    }
    return date;
  }

  static int getBuddhistYearYY(int year) =>
      int.parse((year + kBuddhistYearOffsetCalendar).toString().substring(2));

  static int getEpochTime() {
    return (DateTime.now().millisecondsSinceEpoch / 1000).round();
  }

  static String getwwddMMMyy(DateTime date) {
    DateFormat d = DateFormat(_kwwddMMMyy, AppConfig().appLocale.languageCode);
    DateFormat year = DateFormat(_kyy, AppConfig().appLocale.languageCode);
    DateTime updatedBudDate = getDateTimeWithYearCorrection(date);
    return d
        .format(date)
        .replaceLast(year.format(date), year.format(updatedBudDate));
  }

  static String getwwddMMMyyyy(DateTime date) {
    DateFormat d =
        DateFormat(_kwwddMMMyyyy, AppConfig().appLocale.languageCode);
    return getBuddhistDate(d.format(date), date.year);
  }

  static String getMonthKey(int month) {
    switch (month) {
      case DateTime.january:
        return AppLocalizationsStrings.january;
      case DateTime.february:
        return AppLocalizationsStrings.february;
      case DateTime.march:
        return AppLocalizationsStrings.march;
      case DateTime.april:
        return AppLocalizationsStrings.april;
      case DateTime.may:
        return AppLocalizationsStrings.may;
      case DateTime.june:
        return AppLocalizationsStrings.june;
      case DateTime.july:
        return AppLocalizationsStrings.july;
      case DateTime.august:
        return AppLocalizationsStrings.august;
      case DateTime.september:
        return AppLocalizationsStrings.september;
      case DateTime.october:
        return AppLocalizationsStrings.october;
      case DateTime.november:
        return AppLocalizationsStrings.november;
      default:
        return AppLocalizationsStrings.december;
    }
  }

  static String getMonthShortKey(int month) {
    switch (month) {
      case DateTime.january:
        return AppLocalizationsStrings.januaryShort;
      case DateTime.february:
        return AppLocalizationsStrings.februaryShort;
      case DateTime.march:
        return AppLocalizationsStrings.marchShort;
      case DateTime.april:
        return AppLocalizationsStrings.aprilShort;
      case DateTime.may:
        return AppLocalizationsStrings.mayShort;
      case DateTime.june:
        return AppLocalizationsStrings.juneShort;
      case DateTime.july:
        return AppLocalizationsStrings.julyShort;
      case DateTime.august:
        return AppLocalizationsStrings.augustShort;
      case DateTime.september:
        return AppLocalizationsStrings.septemberShort;
      case DateTime.october:
        return AppLocalizationsStrings.octoberShort;
      case DateTime.november:
        return AppLocalizationsStrings.novemberShort;
      default:
        return AppLocalizationsStrings.decemberShort;
    }
  }

  static String getDayOfWeekShortKey(int dayOfWeek) {
    switch (dayOfWeek) {
      case DateTime.monday:
        return AppLocalizationsStrings.mondayShort;
      case DateTime.tuesday:
        return AppLocalizationsStrings.tuesdayShort;
      case DateTime.wednesday:
        return AppLocalizationsStrings.wednesdayShort;
      case DateTime.thursday:
        return AppLocalizationsStrings.thursdayShort;
      case DateTime.friday:
        return AppLocalizationsStrings.fridayShort;
      case DateTime.saturday:
        return AppLocalizationsStrings.saturdayShort;
      default:
        return AppLocalizationsStrings.sundayShort;
    }
  }

  static DateTime getOnlyDateFromDateTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static TimeOfDay getOnlyTimeFromTimeOfDay(TimeOfDay time) {
    return TimeOfDay(hour: time.hour, minute: time.minute);
  }

  static DateTime getOnlyMonthFromDateTime(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  DateTime parseDateTime(String date) {
    var inputFormat = DateFormat(_kyyyyMMdd);
    try {
      var inputDate = inputFormat.parse(date);
      return inputDate;
    } catch (exception) {
      return DateTime.now();
    }
  }

  DateTime parseDateAndTime(String date) {
    var inputFormat = DateFormat(_kyyyyMMddhhmmss);
    try {
      var inputDate = inputFormat.parse(date);
      return inputDate;
    } catch (exception) {
      return DateTime.now();
    }
  }

  static String getYYYYmmddFromDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat(_kyyyyMMdd).format(dateTime);
  }

  static String getyyyyMMddTHHmmFromDateTime(DateTime dateTime) {
    return DateFormat(_kyyyyMMddhhmm).format(dateTime);
  }

  static String getyyyyMMddTHHmmDateTime(DateTime dateTime) {
    return DateFormat(_kyyyyMMddHHmm).format(dateTime);
  }

  static String getDMMMFromDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return dateTime.day.toString().addTrailingSpace() +
        Helpers.getMonthFromDateTime(dateTime);
  }

  static String getMonthFromDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    DateFormat d = DateFormat(_kMMM, AppConfig().appLocale.languageCode);
    return d.format(dateTime);
  }

  static DateTime getDateTimeWithYearCorrection(DateTime date) {
    if (AppConfig().appLocale.languageCode == LanguageCodes.thai.code) {
      return DateTime(
        date.year + kBuddhistYearOffsetCalendar,
        date.month,
        date.day,
        date.hour,
        date.minute,
        date.second,
        date.millisecond,
        date.microsecond,
      );
    } else {
      return date;
    }
  }

  /// get formated date as Wed 18 May 2021
  static String getEEEdMMMyyyy(DateTime? dateTime) {
    DateFormat d = DateFormat(
      '$_kEEE $_kd $_kMMM $_kyyyy',
      AppConfig().appLocale.languageCode,
    );
    return d.format(dateTime ?? DateTime.now());
  }

  static getAddressString(String? locationName, String? cityName) {
    String address = '';
    if (locationName != null) {
      address = locationName;
    }
    if (cityName != null) {
      if (address.isNotEmpty) address = address.addTrailingComma();
      address = address + cityName;
    }
    return address;
  }

  static String getNumberWithPercentage(int value) {
    return '$value%';
  }

  static String getValueWithBrackets(String value) {
    return '($value)';
  }

  /// get formated date as  18 October 2021  14:35
  static String getddMMMMyyyykkmm(DateTime date) {
    DateFormat d =
        DateFormat(_kddMMMyyyykkmm, AppConfig().appLocale.languageCode);
    return getBuddhistDate(d.format(date), date.year);
  }

  static String getddMMyyyy(DateTime date) {
    DateFormat d = DateFormat(_kddMMyyyy, AppConfig().appLocale.languageCode);
    return getBuddhistDate(d.format(date), date.year);
  }

  static String? truncateString(String? text, int lenght) {
    if (text == null) {
      return null;
    }
    if (text.length <= lenght) {
      return text;
    }
    return text.substring(0, lenght);
  }

  /// get formated date as 14:35
  static String gethhmm(DateTime date) {
    DateFormat d = DateFormat(_khhmm, AppConfig().appLocale.languageCode);
    return getBuddhistDate(d.format(date), date.year);
  }

  static String getyyyyMMddTHHmmssFromDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat(_kyyyyMMddTHHmmss).format(dateTime);
  }

  static TimeOfDay getOnlyTimeFromDate(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  /// get formated date as  18 October 2021,  14:35
  static String getddMMMMyyyyhhmm(DateTime date) {
    DateFormat d =
        DateFormat(_kddMMMyyyyhhmm, AppConfig().appLocale.languageCode);
    return getBuddhistDate(d.format(date), date.year);
  }

  /// get formated date as  18 October 21,  14:35
  static String getddMMMMyyhhmm(DateTime date) {
    DateFormat d =
        DateFormat(_kddMMMyyhhmm, AppConfig().appLocale.languageCode);
    return getBuddhistDateYY(d.format(date), date.year);
  }

  /// get formated date as fri 18 October 2021,  14:35
  static String getwwddMMMyyhhmm(DateTime date) {
    DateFormat d =
        DateFormat(_kwwddMMMyyhhmm, AppConfig().appLocale.languageCode);
    return getBuddhistDateYY(d.format(date), date.year);
  }

  /// get formated date as 14:35:00
  static String gethhmmss(DateTime date) {
    DateFormat d = DateFormat(_khhmmss, AppConfig().appLocale.languageCode);
    return getBuddhistDate(d.format(date), date.year);
  }
}
