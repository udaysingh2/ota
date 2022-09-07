import 'dart:io';

import 'package:url_launcher/url_launcher_string.dart';

class OtaMapLauncher {
  static Future<void> launchMap(
      {required double latitude, required double longitude}) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    String appleUrl = "https://maps.apple.com/?q=$latitude,$longitude";
    if (Platform.isIOS) {
      String iosGoogleUrl =
          'comgooglemaps://?q=$latitude,$longitude&$latitude,$longitude';
      if (await canLaunchUrlString(iosGoogleUrl)) {
        await launchUrlString(iosGoogleUrl);
      } else if (await canLaunchUrlString(appleUrl)) {
        await launchUrlString(appleUrl);
      } else {
        await launchUrlString(googleUrl);
      }
    } else {
      if (await canLaunchUrlString(googleUrl)) {
        await launchUrlString(googleUrl);
      } else {
        await launchUrlString(googleUrl);
      }
    }
  }
}
