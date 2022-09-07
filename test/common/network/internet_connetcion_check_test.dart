import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_connection_check.dart';

void main() {
  test("AddressCheckResult test", () async {
    AddressCheckOptions options = AddressCheckOptions(InternetAddress.anyIPv4);
    options.toString();
    bool isSuccess = true;
    AddressCheckResult addressCheckResult =
        AddressCheckResult(options, isSuccess);
    addressCheckResult.toString();
  });

  test("InternetConnectionChecker test", () async {
    InternetConnectionChecker internetConnectionChecker =
        InternetConnectionChecker();
    AddressCheckOptions options = AddressCheckOptions(InternetAddress.anyIPv4);
    options.toString();

    AddressCheckResult addressCheckResult =
        await internetConnectionChecker.isHostReachable(options);
    addressCheckResult.toString();

    internetConnectionChecker.hasConnection;
    internetConnectionChecker.connectionStatus;
    internetConnectionChecker.lastTryResults;
    internetConnectionChecker.onStatusChange;
    internetConnectionChecker.hasListeners;
    internetConnectionChecker.isActivelyChecking;
  });
}
