import 'package:ota/common/network/internet_info.dart';

class InternetSuccessMock implements InternetConnectionInfo {
  @override
  Future<bool> get isConnected async => true;
}
