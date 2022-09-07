import 'dart:io';

import 'package:url_launcher/url_launcher_string.dart';

class OtaPhoneFunction {
  Future<void> makePhoneCall(String url) async {
    String number = "tel:$url";
    if (Platform.isIOS) number = "tel://$url";

    if (await canLaunchUrlString(number)) {
      await launchUrlString(number);
    } else {
      throw 'Could not launch $number';
    }
  }
}
