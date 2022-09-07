enum LanguageCodes {
  english,
  thai,
}

/* To get codes language codes associated with each language like
   ENGLISH - en
 */
extension LanguageCodeExtension on LanguageCodes {
  static LanguageCodes fromChannelData({required String language}) {
    switch (language.toLowerCase()) {
      case _th:
        return LanguageCodes.thai;
      default:
        return LanguageCodes.english;
    }
  }

  String get code {
    switch (this) {
      case LanguageCodes.english:
        return _en;
      default:
        return _th;
    }
  }

  /* To get codes country codes associated with each language like
   ENGLISH - US
 */
  String get countryCode {
    switch (this) {
      case LanguageCodes.english:
        return _enCountryCode;
      default:
        return _thCountryCode;
    }
  }
}

const String _en = "en";
const String _enCountryCode = "US";
const String _th = "th";
const String _thCountryCode = "TH";
