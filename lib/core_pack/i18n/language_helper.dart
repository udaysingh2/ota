import 'package:either_dart/either.dart';
import 'package:flutter/widgets.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core_pack/caching/ota_preference.dart';
import 'package:ota/domain/translation/models/english_translation_data_model.dart';
import 'package:ota/domain/translation/models/thai_translation_data_model.dart';
import 'package:ota/domain/translation/usecases/translation_use_cases.dart';
import 'package:ota/main.dart';

import 'language_codes.dart';
import 'localization.dart';

///Language Helper is a singleton that can be accessed anywhere.
///Without creating any instance
class LanguageHelper {
  static final LanguageHelper shared = LanguageHelper._internal();
  Map<String, String> cachedEnglishTranscription = {};
  Map<String, String> cachedThaiTranscription = {};
  LanguageHelper._internal();
  factory LanguageHelper() {
    return shared;
  }
}

///[LanguageHelperSetter] is responsible to get the Localised string
///from API in json format.
///and store in shared preference and also update that to memory.
extension LanguageHelperSetter on LanguageHelper {
  ///[_updateToMemory] will get the translation data from shared preference
  ///and then will be stored in
  ///[cachedEnglishTranscription] and [cachedThaiTranscription]
  Future<void> _updateToMemory() async {
    await _updateThaiDataToMemory();
    await _updateEnglishDataToMemory();
  }

  ///[_updateEnglishDataToMemory] will get the english translation
  ///data from shared preference
  ///and then will be stored in [cachedEnglishTranscription]
  Future<void> _updateEnglishDataToMemory() async {
    List<En>? eng =
        (await _getEnglishCachedData())?.data?.loadTranslation?.data?.en;
    if (eng != null) {
      cachedEnglishTranscription.clear();
      for (var element in eng) {
        if (element.value != null && element.name != null) {
          if (element.name?.trim().isNotEmpty ?? false) {
            if (!cachedEnglishTranscription.containsKey(element.name)) {
              cachedEnglishTranscription[element.name ?? ""] =
                  element.value ?? "";
            }
          }
        }
      }
    }
  }

  ///[_updateThaiDataToMemory] will get the english translation
  ///data from shared preference
  ///and then will be stored in [cachedThaiTranscription]
  Future<void> _updateThaiDataToMemory() async {
    List<Th>? thai =
        (await _getThaiCachedData())?.data?.loadTranslation?.data?.th;
    if (thai != null) {
      cachedThaiTranscription.clear();
      for (var element in thai) {
        if (element.value != null && element.name != null) {
          if (element.name?.trim().isNotEmpty ?? false) {
            if (!cachedThaiTranscription.containsKey(element.name)) {
              cachedThaiTranscription[element.name ?? ""] = element.value ?? "";
            }
          }
        }
      }
    }
  }

  ///[updateRawTranslation] will get the translation from Shared preference
  ///[IF] data in shared preference  its empty [Then]
  ///Wait until translation  Is Downloaded from API and Then Used [Else]
  ///Don't wait to Download translation from API instead Use translation from
  ///Shared preference.
  Future<void> updateRawTranslation(
      {TranslationUseCases? translationUseCasesImpl}) async {
    await _updateToMemory();
    if (cachedEnglishTranscription.isNotEmpty &&
        cachedThaiTranscription.isNotEmpty) {
      _getFromServer(translationUseCasesImpl);
      return;
    }
    await _getFromServer(translationUseCasesImpl);
  }

  ///[_getFromServer] will  Download the translation from API
  ///and Then  store in shared preference
  Future<void> _getFromServer(
      TranslationUseCases? translationUseCasesImpl) async {
    TranslationUseCases translationUseCases =
        translationUseCasesImpl ?? TranslationUseCasesImpl();
    List<Either?>? data = await translationUseCases.getTranslation();
    try {
      await _validateAndFillEnglish(data);
      await _validateAndFillThai(data);
    } catch (ex) {
      printDebug(ex.toString());
    }
    await _updateToMemory();
  }

  ///[_validateAndFillEnglish] will validate the downloaded
  ///English translation
  Future<void> _validateAndFillEnglish(List<Either?>? data) async {
    if (data?[0]?.isRight ?? false) {
      EnglishTranslationDataModel english =
          data?[0]?.right as EnglishTranslationDataModel;
      if (english.data?.loadTranslation?.data?.en?.isNotEmpty ?? false) {
        await _fillEnglishInPreference(english);
      }
    }
  }

  ///[_validateAndFillThai] will validate the downloaded
  ///Thai translation
  Future<void> _validateAndFillThai(List<Either?>? data) async {
    if (data?[1]?.isRight ?? false) {
      ThaiTranslationDataModel thai =
          data?[1]?.right as ThaiTranslationDataModel;
      if (thai.data?.loadTranslation?.data?.th?.isNotEmpty ?? false) {
        await _fillThaiInPreference(thai);
      }
    }
  }

  ///[_fillEnglishInPreference] will store store
  ///English translation in Shared preference
  Future<void> _fillEnglishInPreference(
      EnglishTranslationDataModel english) async {
    String json = english.toJson();
    await OtaPreference.shared.setEnglishLanguageData(json);
  }

  ///[_fillThaiInPreference] will store store
  ///Thai translation in Shared preference
  Future<void> _fillThaiInPreference(ThaiTranslationDataModel thai) async {
    await OtaPreference.shared.setThaiLanguageData(thai.toJson());
  }

  ///[_getThaiCachedData] will get The stored Thai translation from the
  ///Shared preference.
  Future<ThaiTranslationDataModel?>? _getThaiCachedData() async {
    String? cachedData = await OtaPreference.shared.getThaiLanguageData();
    if (cachedData == null || cachedData.isEmpty) {
      return null;
    }
    return ThaiTranslationDataModel.fromJson(cachedData);
  }

  ///[_getEnglishCachedData] will get The stored English
  ///translation from the Shared preference.
  Future<EnglishTranslationDataModel?>? _getEnglishCachedData() async {
    String? cachedData = await OtaPreference.shared.getEnglishLanguageData();
    if (cachedData == null || cachedData.isEmpty) {
      return null;
    }
    return EnglishTranslationDataModel.fromJson(cachedData);
  }
}

///[LanguageHelperGetter] is responsible to get the Localised string
///from memory.
extension LanguageHelperGetter on LanguageHelper {
  ///[getTranslated] will first check the current locale and then
  ///It will check in the Memory
  ///[IF] the translation is found in memory with the key [then]
  ///In memory translation will be used in app [ELSE]
  ///translation will be taken from [en.dart] or [th.dart]
  ///based on lacale.
  String getTranslated(BuildContext context, String key) {
    final currentLocale = MyApp.getLocal(context);
    if (LanguageCodes.thai.code == currentLocale.languageCode) {
      return getTranslatedThai(key) ?? getLocalisedLocalData(context, key);
    } else {
      return getTranslatedEnglish(key) ?? getLocalisedLocalData(context, key);
    }
  }

  ///[getLocalisedLocalData]  will be take translation from
  ///[en.dart] or [th.dart]
  String getLocalisedLocalData(BuildContext context, String key) {
    return Localization?.of(context)?.translate(key) ?? "";
  }

  ///[getTranslatedThai] will take the translation from memory
  String? getTranslatedThai(String key) {
    if (cachedThaiTranscription.containsKey(key)) {
      return cachedThaiTranscription[key];
    }
    return null;
  }

  ///[getTranslatedEnglish] will take the translation from memory
  String? getTranslatedEnglish(String key) {
    if (cachedEnglishTranscription.containsKey(key)) {
      return cachedEnglishTranscription[key];
    }
    return null;
  }
}
