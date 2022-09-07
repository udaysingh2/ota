import 'dart:async';

import 'package:ota/channels/register_confirm_landing_handler/data_source/register_confirm_landing_data_source.dart';
import 'package:ota/channels/register_confirm_landing_handler/models/register_confirm_landing_response_model_channel.dart';

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class RegisterConfirmLandingMockDataSourceImpl
    implements RegisterConfirmLandingDataSource {
  static String _responseMock = """
  {
    "userId": "55bdb958-97e8-4c10-bfa0-7ed1d8d6973b-02E0JPDV",
    "userType": "GUEST",
    "language": "TH",
    "env": "DEV",
    "idToken":"",
    "accessToken":"",
    "userName":"",
    "existingCust":"no"
  }
  """;

  static String getMockData() {
    return _responseMock;
  }

  static void setMock(String mock) {
    _responseMock = mock;
  }

  ///Use [StreamSubscription] to cancel the listener
  @override
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmLandingModelChannel) nativeResponse,
      required String methodName}) {
    Future.delayed(const Duration(seconds: 5), () {
      // nativeResponse(
      //     RegisterConfirmLandingModelChannel.fromJson(_responseMock));
    });
    return const Stream.empty().listen((event) {});
  }

  @override
  void dispose() {}
}
