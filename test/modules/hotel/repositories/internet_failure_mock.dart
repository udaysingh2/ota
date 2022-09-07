import 'package:ota/common/network/internet_info.dart';

class InternetFailureMock implements InternetConnectionInfo {
  @override
  Future<bool> get isConnected async => false;
}
