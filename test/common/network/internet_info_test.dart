import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/network/internet_connection_check.dart';
import 'package:ota/common/network/internet_info.dart';

void main() {
  test("Internet info test", () async {
    InternetConnectionInfoImpl infoImpl = InternetConnectionInfoImpl();
    bool isConnected = await infoImpl.isConnected;
    printDebug(isConnected);
  });
  test("Internet info test with Internet ConnectionC hecker", () async {
    InternetConnectionInfoImpl infoImpl = InternetConnectionInfoImpl(
        connectionChecker: InternetConnectionChecker());
    bool isConnected = await infoImpl.isConnected;
    printDebug(isConnected);
  });
}
