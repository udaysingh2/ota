import 'internet_connection_check.dart';

/// Interface for internet connection.
abstract class InternetConnectionInfo {
  /// Check Internet is connected or not.
  /// [Future<bool>] return type for hasConnection.
  Future<bool> get isConnected;
}

/// `InternetConnectionInfoImpl` contain the implementation of `InternetConnectionInfo`
///  We are using `InternetConnectionChecker` to check the internet has connected or not.
class InternetConnectionInfoImpl implements InternetConnectionInfo {
  InternetConnectionChecker? internetConnectionChecker;

  /// InternetConnectionInfoImpl constructor using for dependence.
  InternetConnectionInfoImpl({InternetConnectionChecker? connectionChecker}) {
    if (connectionChecker == null) {
      internetConnectionChecker = InternetConnectionChecker();
    } else {
      internetConnectionChecker = connectionChecker;
    }
  }

  /// Check Internet is connected or not.
  /// [Future<bool>] return type for hasConnection.
  @override
  Future<bool> get isConnected =>
      internetConnectionChecker?.hasConnection ?? Future.value(false);
}
