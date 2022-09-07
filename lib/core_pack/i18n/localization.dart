import 'package:flutter/material.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';

import 'en.dart';
import 'th.dart';

class Localization {
  Localization(
    this.locale, {
    this.isTest = false,
  });

  final bool isTest;
  final Locale locale;
  Map<String, String> _localizedValues = {};

  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  Future<Localization> loadTest(Locale locale) async {
    return Localization(locale);
  }

  Future<void> load() async {
    // String jsonStringValues =
    //     await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    // Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    if (locale.languageCode == 'th') {
      _localizedValues = i18nTh;
    } else {
      _localizedValues = i18nEn;
    }
  }

  String? translate(String key) {
    if (isTest) return key;
    if (!_localizedValues.containsKey(key)) {
      return key;
    }
    return _localizedValues[key] ?? key;
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<Localization> delegate =
      _DemoLocalizationsDelegate(isTest: false);
}

class _DemoLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  final bool isTest;

  const _DemoLocalizationsDelegate({
    required this.isTest,
  });

  @override
  bool isSupported(Locale locale) {
    return [
      LanguageCodes.english.code,
      LanguageCodes.thai.code,
    ].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    final Localization localizations = Localization(locale, isTest: isTest);
    if (isTest) {
      await localizations.loadTest(locale);
    } else {
      await localizations.load();
    }

    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}
