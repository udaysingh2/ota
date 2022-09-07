import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ota/common/helpers/print_helper.dart';

class PlatformSpecificsHelper {
  static bool _showMaterialYouUi = false;

  static Future<void> checkForMaterialYou() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      printDebug('operatingSystemVersion: ${androidInfo.version.sdkInt}');
      if ((androidInfo.version.sdkInt ?? 0) >= 31) {
        _showMaterialYouUi = true;
      }
    }
  }

  static bool get useMaterialYouUi => _showMaterialYouUi;
}
