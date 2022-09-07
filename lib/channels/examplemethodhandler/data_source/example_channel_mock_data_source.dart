import 'dart:async';

import 'package:ota/channels/examplemethodhandler/models/example_response_model_channel.dart';

import 'example_channel_data_source.dart';

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class ExampleMethodHandlerDataSourceImpl
    implements ExampleMethodHandlerDataSource {
  static String _responseMock = """
  {
    "from": "superapp_register",
    "to": "ota_landing",
    "userId": "55bdb958-97e8-4c10-bfa0-7ed1d8d6973b-02E0JPDV",
    "userType": "ACTIVE",
    "language": "TH",
    "envId": "DEV"
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
      {required Function(ExampleResponseModelChannel) nativeResponse,
      required String methodName}) {
    Future.delayed(const Duration(seconds: 1), () {
      nativeResponse(ExampleResponseModelChannel.fromJson(_responseMock));
    });
    return const Stream.empty().listen((event) {});
  }

  @override
  void dispose() {}
}
