import 'dart:io';

import 'package:ota/channels/ota_appsflyer/model/ota_appsflyer_model_channel.dart';
import 'package:ota/channels/ota_appsflyer/usecases/ota_appsflyer_use_cases.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/user_location.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';

class AppFlyerHelper {
  static final Map<String, Map<String, String>?> _parameterGlobal = {};
  static const String _kContentType = 'product';
  static const int _kEndIndex = 100;

  static startCapturingEvent(String eventName) {
    _parameterGlobal[eventName] = {};
  }

  static stopCapturingEvent(String eventName) {
    _publishToSuperApp(eventName);
  }

  static clearEvent(String eventName) {
    _parameterGlobal[eventName] = null;
  }

  static addKeyValue(
      {required String eventName,
      required String key,
      required String? value}) {
    if (_parameterGlobal[eventName] == null) {
      return;
    }
    _parameterGlobal[eventName]![key] = value ?? "";
  }

  static addDateValue(
      {required String eventName,
      required String key,
      required DateTime? value}) {
    if (_parameterGlobal[eventName] == null) {
      return;
    }
    _parameterGlobal[eventName]![key] =
        value != null ? Helpers.getYYYYmmddFromDateTime(value) : "";
  }

  static addDateTimeValue(
      {required String eventName,
      required String key,
      required DateTime? value}) {
    if (_parameterGlobal[eventName] == null) {
      return;
    }
    _parameterGlobal[eventName]![key] =
        value != null ? Helpers.getyyyyMMddTHHmmDateTime(value) : "";
  }

  static addIntValue(
      {required String eventName, required String key, required int? value}) {
    if (_parameterGlobal[eventName] == null) {
      return;
    }
    _parameterGlobal[eventName]![key] = value != null ? value.toString() : "0";
  }

  static addDoubleValue(
      {required String eventName,
      required String key,
      required double? value}) {
    if (_parameterGlobal[eventName] == null) {
      return;
    }
    _parameterGlobal[eventName]![key] =
        value != null ? value.toStringAsFixed(2) : "0.00";
  }

  static addCurrency({required String eventName, required String key}) {
    if (_parameterGlobal[eventName] == null) {
      return;
    }
    _parameterGlobal[eventName]![key] = AppConfig().currency;
  }

  static addUserLocation({required String eventName}) {
    if (_parameterGlobal[eventName] == null) {
      return;
    }
    _parameterGlobal[eventName]!["home_location_latitude"] =
        UserLocation().latitude;
    _parameterGlobal[eventName]!["home_location_longitude"] =
        UserLocation().longitude;
  }

  static addContentType({required String eventName, required String key}) {
    if (_parameterGlobal[eventName] == null) {
      return;
    }
    _parameterGlobal[eventName]![key] = _kContentType;
  }

  static addParameters(
      {required String eventName, required Map<String, String> parameter}) {
    if (_parameterGlobal[eventName] == null) {
      return;
    }
    _parameterGlobal[eventName]!.addAll(parameter);
  }

  static addCommaSeparatedList(
      {required String eventName,
      required List<String?>? value,
      required String key}) {
    if (_parameterGlobal[eventName] == null) {
      return;
    }
    String truncatedString = "";
    if (value != null) {
      List.generate(value.length, (index) {
        String? result = value.elementAt(index);
        if (result != null) {
          if (index == 0) {
            truncatedString = result;
          } else if ((truncatedString.length + result.length) < _kEndIndex) {
            truncatedString = truncatedString.isNotEmpty
                ? truncatedString + result.addLeadingComma()
                : result;
          }
        }
      });
    }
    _parameterGlobal[eventName]![key] = truncatedString;
  }

  static _publishToSuperApp(String eventName) {
    if (AppConfig().configModel.appFlyerEnabled.toLowerCase() == "false" ||
        _parameterGlobal[eventName] == null ||
        _parameterGlobal[eventName]!.keys.isEmpty) {
      return;
    }
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return;
    }
    GetAppsFlyerChannelUseCasesImpl appsFlyerUseCase =
        GetAppsFlyerChannelUseCasesImpl();
    appsFlyerUseCase.invokeExampleMethod(
        methodName: "otaAppsFlyer",
        arguments: GetAppsFlyerModelChannel(
          env: getLoginProvider().getEnv(),
          eventName: eventName,
          language: getLoginProvider().getLanguage(),
          parameters: _parameterGlobal[eventName]!,
        ));
  }
}
