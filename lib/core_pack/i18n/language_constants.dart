import 'package:flutter/widgets.dart';
import 'package:ota/core_pack/i18n/language_helper.dart';

import 'language_codes.dart';

const kDefaultLanguage = LanguageCodes.english;
const kDefaultLanguageCode = "en";

String getTranslated(BuildContext context, String key) {
  return LanguageHelper.shared.getTranslated(context, key);
}
