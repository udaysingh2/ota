import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/i18n/en.dart';
import 'package:ota/core_pack/i18n/th.dart';

class AppLanguageHandles {
  static String getTranslatedKeyword(String value) {
    String appLanguage = AppConfig().appLocale.languageCode;
    String currentLangText;
    if (appLanguage == "th") {
      currentLangText = i18nTh[value].toString();
    } else {
      currentLangText = i18nEn[value].toString();
    }
    return currentLangText;
  }
}
