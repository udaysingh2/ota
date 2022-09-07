import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';

class MockedBuildContext extends Mock implements BuildContext {}

final kThaiLocale =
    Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode);
final kEngLocale =
    Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode);

void main() {
  setUp(() async {
    initializeDateFormatting();
  });
  test("Helper Test", () {
    DateTime dateTime = DateTime(2022);
    DateTime dateTime1 = DateTime(2022, 10, 12);

    AppConfig().appLocale = kThaiLocale;
    String formattedString = Helpers.getddMMMyy(dateTime);
    expect(formattedString, '01 ม.ค. 65');

    AppConfig().appLocale = kEngLocale;
    String formattedString1 = Helpers.getddMMMyy(dateTime1);
    expect(formattedString1, '12 Oct 22');

    AppConfig().appLocale = kThaiLocale;
    String formattedString2 = Helpers.getddMMMyyyy(dateTime);
    expect(formattedString2, '1 ม.ค. 2565');

    AppConfig().appLocale = kEngLocale;
    String formattedString3 = Helpers.getddMMMyyyy(dateTime1);
    expect(formattedString3, '12 Oct 2022');

    AppConfig().appLocale = kThaiLocale;
    String formattedString4 = Helpers.getwwddMMMyyyy(dateTime);
    expect(formattedString4, 'ส. 1 ม.ค. 2565');

    AppConfig().appLocale = kEngLocale;
    String formattedString5 = Helpers.getwwddMMMyyyy(dateTime1);
    expect(formattedString5, 'Wed 12 Oct 2022');

    AppConfig().appLocale = kEngLocale;
    String formattedString6 = Helpers.getMonthShortKey(DateTime.november);
    expect(formattedString6, 'date_month_nov');

    AppConfig().appLocale = kEngLocale;
    String formattedString7 = Helpers.getDayOfWeekShortKey(DateTime.saturday);
    expect(formattedString7, 'date_day_sat');
  });
}
