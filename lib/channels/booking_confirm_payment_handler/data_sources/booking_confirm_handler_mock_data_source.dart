import 'dart:async';

import 'package:ota/channels/booking_confirm_payment_handler/data_sources/booking_confirm_handler_data_source.dart';
import 'package:ota/channels/booking_confirm_payment_handler/models/booking_confirm_handler_model_channel.dart';

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class BookingConfirmHandlerMockDataSourceImpl
    implements BookingConfirmHandlerDataSource {
  static String _responseMock = """
  {
    "orderId": "5465735",
    "language": "TH",
    "env": "DEV",
    "idToken":"",
    "accessToken":""
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
      {required Function(BookingConfirmHandlerModelChannel) nativeResponse,
      required String methodName}) {
    Future.delayed(const Duration(seconds: 6), () {
      // nativeResponse(BookingConfirmHandlerModelChannel.fromJson(_responseMock));
    });
    return const Stream.empty().listen((event) {});
  }

  @override
  void dispose() {}
}
