import 'dart:io';

import 'package:ota/channels/ota_appsflyer/model/ota_appsflyer_model_channel.dart';
import 'package:ota/channels/ota_appsflyer/usecases/ota_appsflyer_use_cases.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/user_location.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';

class AppFlyerLogger {
  final Map<String, String> _parameter = {};
  static const String _kContentType = 'product';
  static const int _kEndIndex = 100;

  void addKeyValue({required String key, required String? value}) {
    _parameter[key] = value ?? "";
  }

  void addDateValue({required String key, required DateTime? value}) {
    _parameter[key] =
        value != null ? Helpers.getYYYYmmddFromDateTime(value) : "";
  }

  void addDateTimeValue({required String key, required DateTime? value}) {
    _parameter[key] =
        value != null ? Helpers.getyyyyMMddTHHmmDateTime(value) : "";
  }

  void addIntValue({required String key, required int? value}) {
    _parameter[key] = value != null ? value.toString() : "0";
  }

  void addDoubleValue({required String key, required double? value}) {
    _parameter[key] = value != null ? value.toStringAsFixed(2) : "0.00";
  }

  void addCurrency({required String key}) {
    _parameter[key] = AppConfig().currency;
  }

  void addUserLocation() {
    _parameter["home_location_latitude"] = UserLocation().latitude;
    _parameter["home_location_longitude"] = UserLocation().longitude;
  }

  void addContentType({required String key}) {
    _parameter[key] = _kContentType;
  }

  void addParameters(Map<String, String> data) {
    _parameter.addAll(data);
  }

  void addCommaSeparatedList(
      {required List<String?>? value, required String key}) {
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
    _parameter[key] = truncatedString;
  }

  void publishToSuperApp(String eventName) {
    if (AppConfig().configModel.appFlyerEnabled.toLowerCase() == "false" ||
        _parameter.keys.isEmpty) {
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
          parameters: _parameter,
        ));
    _parameter.clear();
  }
}
