import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/scb_alert_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';

const _kSCBEasyiOSAppstoreLink =
    'https://apps.apple.com/in/app/scb-easy/id568388474';
const _kSCBEasyAndroidPlaystoreLink =
    'https://play.google.com/store/apps/details?id=com.scb.phone&hl=en_IN&gl=US';

class SCBEasyHelper {
  static Future<SCBEasyAppState> launchSCBEasyApp(BuildContext context) async {
    final scbAppInstalled = await canLaunchOnAll();
    if (scbAppInstalled) {
      return SCBEasyAppState.success;
    } else {
      final dialogResult = await SCBAlertDialog().showAlertDialog(context);
      if (dialogResult == null) return SCBEasyAppState.installInitiated;
      if (dialogResult == SCBEasyAppState.installInitiated) {
        launchUrlString(
          Platform.isIOS
              ? _kSCBEasyiOSAppstoreLink
              : _kSCBEasyAndroidPlaystoreLink,
        );
        return SCBEasyAppState.installInitiated;
      } else {
        return SCBEasyAppState.anotherPaymentSelected;
      }
    }
  }

  static Future<bool> canLaunchOnAll() async {
    String deepLinkUrl = AppConfig().configModel.scbEasyDefaultDeepLink;
    return await canLaunchUrlString(deepLinkUrl);
  }
}

enum SCBEasyAppState { success, installInitiated, anotherPaymentSelected }
