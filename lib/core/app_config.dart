import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/caching/ota_preference.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/language_helper.dart';
import 'package:ota/domain/confi_api/models/config_model.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';
import 'package:ota/domain/confi_api/usecases/config_use_cases.dart';

class AppConfig {
  Locale appLocale =
      Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode);
  String currency = "THB";
  String userType = "ACTIVE";
  String rentalType = "day";
  ConfigModel configModel = ConfigModel.defaultValue();
  List<String> getCountryList() {
    List<String> countryList = [];
    if (appLocale.languageCode == LanguageCodes.thai.code) {
      countryList = configModel.countryListThai.split(",");
    } else {
      countryList = configModel.countryListEnglish.split(",");
    }
    return countryList;
  }

  AppConfig._appConfig();

  static final AppConfig _instance = AppConfig._appConfig();

  static AppConfig get shared => _instance;

  factory AppConfig() {
    return _instance;
  }

  Future<void> updateConfigAndTranslation() async {
    //This will wait untill both the operation is done.
    //Works parallel.
    await Future.wait(
        [LanguageHelper.shared.updateRawTranslation(), setConfigData()]);
  }

  Future<void> setConfigData() async {
    String? jsonData = await OtaPreference.shared.getConfigData();
    try {
      if (jsonData != null) {
        final Map<String, dynamic> configData = json.decode(jsonData);
        if (configData.containsKey('data') && configData['data'] != null) {
          ConfigResultModel resultModel =
              ConfigResultModel.fromJson(configData['data']!);
          _setAppConfigData(resultModel);
          _callConfigApi();
        } else {
          await _callConfigApi();
        }
      } else {
        await _callConfigApi();
      }
    } catch (_) {
      await _callConfigApi();
    }
  }

  Future<void> _callConfigApi() async {
    ConfigUseCases configUseCases = ConfigUseCasesImpl();
    Either<Failure, ConfigResultModel> result =
        (await configUseCases.getConfigDetails())!;
    if (result.isRight) {
      ConfigResultModel resultModel = result.right;
      if (resultModel.getConfigDetails != null) {
        final Map<String, String> configData = {
          "data": resultModel.toJson(),
          "dateAdded": Helpers.getYYYYmmddFromDateTime(DateTime.now()),
        };
        await OtaPreference.shared.setConfigData(json.encode(configData));
        _setAppConfigData(resultModel);
      }
    }
  }

  void _setAppConfigData(ConfigResultModel resultModel) {
    if (resultModel.getConfigDetails?.data != null) {
      ConfigModel configModel =
          ConfigModel.fromModel(resultModel.getConfigDetails!.data!);
      AppConfig().configModel = configModel;
    } else {
      AppConfig().configModel = ConfigModel.defaultValue();
    }
  }
}
