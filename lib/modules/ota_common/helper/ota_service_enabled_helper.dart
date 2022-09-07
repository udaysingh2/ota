import 'package:ota/core/app_config.dart';

const String _kTourKey = "tour_key";
const String _kCarKey = "car_key";
const String _kTrueKey = "true";

class OtaServiceEnabledHelper {
  static bool isWalletEnabled() {
    return AppConfig().configModel.otaServices.toLowerCase() == _kTrueKey;
  }

  static bool isCarEnabled() {
    String optionsKey = AppConfig().configModel.otaServices;
    return optionsKey.contains(_kCarKey);
  }

  static bool isTourEnabled() {
    String optionsKey = AppConfig().configModel.otaServices;
    return optionsKey.contains(_kTourKey);
  }
}
