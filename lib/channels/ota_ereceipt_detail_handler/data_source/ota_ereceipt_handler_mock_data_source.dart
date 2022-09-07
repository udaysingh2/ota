import 'dart:async';

import 'package:ota/channels/ota_ereceipt_detail_handler/data_source/ota_ereceipt_handler_data_source.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/models/ota_ereceipt_handler_model_channel.dart';

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class OtaEReceiptHandlerMockDataSourceImpl
    implements OtaEReceiptHandlerDataSource {
  static String _responseMock = """
  {
      "userId": "55bdb958-97e8-4c10-bfa0-7ed1d8d6973b-02E0JPDV",
      "userType": "GUEST",
      "idToken": "",
      "accessToken": "",
      "orderId": "5465735",
      "confirmationNo": "",
      "bookingType": "",
      "language": "TH",
      "env": "ALPHA"
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
      {required Function(OtaEReceiptHandlerModelChannel) nativeResponse,
      required String methodName}) {
    Future.delayed(const Duration(seconds: 3), () {
      //nativeResponse(OtaEReceiptHandlerModelChannel.fromJson(_responseMock));
    });
    return const Stream.empty().listen((event) {});
  }

  @override
  void dispose() {}
}
