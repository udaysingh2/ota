import 'package:ota/channels/example/data_sources/example_channel_data_source.dart';
import 'package:ota/channels/example/models/example_argument_model_channel.dart';
import 'package:ota/channels/example/models/example_response_model_channel.dart';

class ExampleMockDataSourceImpl implements ExampleChannelDataSource {
  ExampleMockDataSourceImpl();
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

  @override
  Future<ExampleResponseModelChannel> invokeExampleMethod(
      {required String methodName,
      required ExampleArgumentModelChannel arguments}) async {
    return ExampleResponseModelChannel.fromJson(_responseMock);
  }

  @override
  void dispose() {}
}


