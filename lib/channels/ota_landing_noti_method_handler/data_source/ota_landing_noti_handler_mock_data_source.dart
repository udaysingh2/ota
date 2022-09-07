import 'dart:async';

import 'package:ota/channels/ota_landing_noti_method_handler/models/ota_landing_noti_handler_model_channel.dart';

import 'ota_landing_noti_handler_data_source.dart';

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class OtaLandingNotiHandlerMockDataSourceImpl
    implements OtaLandingNotiHandlerDataSource {
  static String _responseMock = """
  {
    "userId": "55bdb958-97e8-4c10-bfa0-7ed1d8d6973b-02E0JPDV",
    "userType": "GUEST",
    "language": "TH",
    "env": "ALPHA",
    "idToken":"",
    "accessToken":"",
    "userName":"Test"
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
      {required Function(OtaLandingNotiHandlerModelChannel) nativeResponse,
      required String methodName}) {
    Future.delayed(const Duration(seconds: 2), () {
      // nativeResponse(OtaLandingNotiHandlerModelChannel.fromJson(_responseMock));
    });
    return const Stream.empty().listen((event) {});
  }

  @override
  void dispose() {}
}
