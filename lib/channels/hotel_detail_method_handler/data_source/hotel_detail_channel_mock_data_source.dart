import 'dart:async';

import 'package:ota/channels/hotel_detail_method_handler/data_source/hotel_detail_channel_data_source.dart';
import 'package:ota/channels/hotel_detail_method_handler/models/hotel_detail_reponse_model_channel.dart';

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class PropertyDetailHandlerMockDataSourceImpl
    implements PropertyDetailHandlerDataSource {
  static String _responseMock = """
  {
    "userId": "55bdb958-97e8-4c10-bfa0-7ed1d8d6973b-02E0JPDV",
    "userType": "GUEST",
    "hotelId":"MA1809001981",
    "cityId":"MA05110027",
    "countryId":"MA05110001",
    "language": "TH",
    "env": "ALPHA",
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
      {required Function(PropertyDetailHandlerModelChannel) nativeResponse,
      required String methodName}) {
    Future.delayed(const Duration(seconds: 2), () {
      //nativeResponse(PropertyDetailHandlerModelChannel.fromJson(_responseMock));
    });
    return const Stream.empty().listen((event) {});
  }

  @override
  void dispose() {}
}
