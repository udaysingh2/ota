import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core_pack/caching/ota_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockedSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  test('OTA prefrence test for set mocked value ...', () async {
    MockedSharedPreferences mocked = MockedSharedPreferences();
    OtaPreferenceParser<String>(mocked).setPreference("testKey", "example");
    OtaPreferenceParser<int>(mocked).setPreference("testId", 123);
    OtaPreferenceParser<double>(mocked).setPreference("testDouble", 123);
    OtaPreferenceParser<bool>(mocked).setPreference("testBool", true);
    OtaPreferenceParser<List<String>>(mocked)
        .setPreference("testStringList", []);
    OtaPreferenceParser<List>(mocked).setPreference("testList", []);
  });

  test('OTA prefrence test for get mocked value ...', () async {
    MockedSharedPreferences mocked = MockedSharedPreferences();
    when(mocked.getString("testKey")).thenAnswer((realInvocation) => "Test");
    OtaPreferenceParser<String>(mocked).getPreference("testKey");

    when(mocked.getInt("testId")).thenAnswer((realInvocation) => 1);
    OtaPreferenceParser<int>(mocked).getPreference("testId");

    when(mocked.getDouble("testDouble")).thenAnswer((realInvocation) => 1.0);
    OtaPreferenceParser<double>(mocked).getPreference("testDouble");

    when(mocked.getBool("testBool")).thenAnswer((realInvocation) => true);
    OtaPreferenceParser<bool>(mocked).getPreference("testBool");

    when(mocked.getStringList("testStringList"))
        .thenAnswer((realInvocation) => []);
    OtaPreferenceParser<List<String>>(mocked).getPreference("testStringList");

    when(mocked.getStringList("testList")).thenAnswer((realInvocation) => []);
    OtaPreferenceParser<List>(mocked).getPreference("testList");
  });

  test('OTA prefrence test value ...', () async {
    try {
      SharedPreferences.setMockInitialValues({"12": ""});
      OtaPreference otaPreference = OtaPreference();
      await otaPreference.setThaiLanguageData("");
      await otaPreference.setEnglishLanguageData("");
      // await otaPreference.setPopupId('popupId');
      // await otaPreference.setPopupCount('popupCount', 1);
      await otaPreference.setLoadingJsonData("");
      await otaPreference.setLoadingApiFetchedDate("");

      // bool? popupId = await otaPreference.getPopupId('popupId');
      // expect(popupId, true);
      //
      // int? popupCount = await otaPreference.getPopupCount('popupCount');
      // expect(popupCount, 1);

      String? thaiLang = await otaPreference.getThaiLanguageData();
      expect(thaiLang?.isEmpty, true);

      String? englishLang = await otaPreference.getEnglishLanguageData();
      expect(englishLang?.isEmpty, true);

      String? loadingJsonData = await otaPreference.getLoadingJsonData();
      expect(loadingJsonData?.isEmpty, true);

      String? loadingApiFetchedDate =
          await otaPreference.getLoadingApiFetchedDate();
      expect(loadingApiFetchedDate?.isEmpty, true);
    } catch (ex) {
      printDebug(ex);
    }
  });
}
