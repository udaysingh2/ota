import 'package:ota/core_pack/i18n/language_constants.dart';

class TranslationArgumentModel {
  TranslationType translationType;
  TranslationArgumentModel({required this.translationType});
}

extension TranslationTypeExtender on TranslationType {
  String langCode() {
    switch (this) {
      case TranslationType.thai:
        return "th";
      case TranslationType.english:
        return "en";
      default:
        return kDefaultLanguageCode;
    }
  }
}

enum TranslationType {
  english,
  thai,
}
