import 'package:shared_preferences/shared_preferences.dart';

///[OtaPreferenceExtender] create your shared preference function here.
extension OtaPreferenceExtender on OtaPreference {
  static const kPrefKeyThaiLanguageData = "kPrefKeyThaiLanguageData";
  static const kPrefKeyEnglishLanguageData = "kPrefKeyEnglishLanguageData";
  static const kLoadingApiFetchedDate = "kLoadingApiFetchedDate";
  static const kLoadingJsonData = "kLoadingJsonData";
  static const kPrefKeyConfigData = "kPrefKeyConfigData";
  static const kScbDeepLinkUrl = "kScbDeepLinkUrl";

  ///[setThaiLanguageData] store Thai json data in Shared Preference.
  ///[jsonData] jsonData should a json string value.
  Future<void> setThaiLanguageData(String? jsonData) async {
    final SharedPreferences prefs = await otaPreference;
    await OtaPreferenceParser<String>(prefs).setPreference(
      kPrefKeyThaiLanguageData,
      jsonData,
    );
  }

  ///[setEnglishLanguageData] store English json data in Shared Preference.
  ///[jsonData] jsonData should a json string value.
  Future<void> setEnglishLanguageData(String? jsonData) async {
    final SharedPreferences prefs = await otaPreference;
    await OtaPreferenceParser<String>(prefs).setPreference(
      kPrefKeyEnglishLanguageData,
      jsonData,
    );
  }

  ///[getThaiLanguageData] get Thai json data from Shared Preference.
  ///[String] function will return json string value.
  Future<String?> getThaiLanguageData() async {
    final SharedPreferences prefs = await otaPreference;
    return OtaPreferenceParser<String>(prefs).getPreference(
      kPrefKeyThaiLanguageData,
    );
  }

  ///[getEnglishLanguageData] get English json data from Shared Preference.
  ///[String] function will  return json string value.
  Future<String?> getEnglishLanguageData() async {
    final SharedPreferences prefs = await otaPreference;
    return OtaPreferenceParser<String>(prefs).getPreference(
      kPrefKeyEnglishLanguageData,
    );
  }

  ///[setLoadingApiFetchedDate] store currentDate in Shared Preference.
  ///[date] jsonData should a string date value.
  Future<void> setLoadingApiFetchedDate(String? date) async {
    final SharedPreferences prefs = await otaPreference;
    await OtaPreferenceParser<String>(prefs).setPreference(
      kLoadingApiFetchedDate,
      date,
    );
  }

  ///[getLoadingApiFetchedDate] get currentDate from Shared Preference.
  ///[String] function will return String Date value.
  Future<String?> getLoadingApiFetchedDate() async {
    final SharedPreferences prefs = await otaPreference;
    return OtaPreferenceParser<String>(prefs).getPreference(
      kLoadingApiFetchedDate,
    );
  }

  ///[setLoadingJsonData] store json response for loading Screen Data in Shared Preference.
  ///[jsonData] jsonData should a string value.
  Future<void> setLoadingJsonData(String? jsonData) async {
    final SharedPreferences prefs = await otaPreference;
    await OtaPreferenceParser<String>(prefs).setPreference(
      kLoadingJsonData,
      jsonData,
    );
  }

  ///[getLoadingJsonData] get json response for loading Screen Data from Shared Preference.
  ///[String] function will return String Json response.
  Future<String?> getLoadingJsonData() async {
    final SharedPreferences prefs = await otaPreference;
    return OtaPreferenceParser<String>(prefs).getPreference(
      kLoadingJsonData,
    );
  }

  ///[setConfigData] store Thai json data in Shared Preference.
  ///[jsonData] jsonData should a json string value.
  Future<void> setConfigData(String jsonData) async {
    final SharedPreferences prefs = await otaPreference;
    await OtaPreferenceParser<String>(prefs).setPreference(
      kPrefKeyConfigData,
      jsonData,
    );
  }

  ///[getConfigData] get Thai json data from Shared Preference.
  ///[String] function will return json string value.
  Future<String?> getConfigData() async {
    final SharedPreferences prefs = await otaPreference;
    return OtaPreferenceParser<String>(prefs).getPreference(
      kPrefKeyConfigData,
    );
  }
}

///[OtaPreference] is A Singleton that will be used throughout the APP.
class OtaPreference {
  Future<SharedPreferences> otaPreference;
  OtaPreference._internal(this.otaPreference);
  static OtaPreference shared =
      OtaPreference._internal(SharedPreferences.getInstance());
  factory OtaPreference() {
    return shared;
  }
}

///[OtaPreferenceParser] is A class responsible for storing in shared
///preference and to get from shared preference.
///[OtaPreferenceParser] class will handle the error and null will be returned
///in case of any exception.
class OtaPreferenceParser<T> {
  SharedPreferences sharedPreferences;
  OtaPreferenceParser(this.sharedPreferences);

  ///[setPreference] is responsible for storing in shared preference
  ///[setPreference] method will handle the error so
  ///no exception will be thrown.
  Future<void> setPreference(String key, T? value) async {
    if (key.isEmpty) {
      return;
    }
    if (value == null) {
      return;
    }
    try {
      switch (T) {
        case String:
          await sharedPreferences.setString(key, value as String);
          break;
        case int:
          await sharedPreferences.setInt(key, value as int);
          break;
        case bool:
          await sharedPreferences.setBool(key, value as bool);
          break;
        case double:
          await sharedPreferences.setDouble(key, value as double);
          break;
        case List:
          await sharedPreferences.setStringList(key, value as List<String>);
          break;
        default:
          await sharedPreferences.setString(key, value.toString());
          break;
      }
    } catch (ex) {
      return;
    }
  }

  ///[getPreference] is responsible for getting data from shared preference
  ///[getPreference] method will handle the error
  ///so no exception will be thrown.
  T? getPreference(String key) {
    if (key.isEmpty) {
      return null;
    }
    try {
      switch (T) {
        case String:
          return sharedPreferences.getString(key) as T;
        case int:
          return sharedPreferences.getInt(key) as T;
        case bool:
          return sharedPreferences.getBool(key) as T;
        case double:
          return sharedPreferences.getDouble(key) as T;
        case List:
          return sharedPreferences.getStringList(key) as T;
        default:
          return sharedPreferences.getString(key) as T;
      }
    } catch (ex) {
      return null;
    }
  }
}
