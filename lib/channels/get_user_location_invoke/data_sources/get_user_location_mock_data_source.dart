import 'package:ota/channels/get_user_location_invoke/data_sources/get_user_location_data_source.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_argument_model_channel.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_response_model_channel.dart';

class GetUserLocationMockDataSourceImpl
    implements GetUserLocationChannelDataSource {
  GetUserLocationMockDataSourceImpl();
  static String _responseMock = """
  {
   "userId":"55bdb958-97e8-4c10-bfa0-7ed1d8d6973b-02E0JPDV",
   "userType":"ACTIVE",
   "idToken":"eyJraWQiOiI4cmJ6ZnhNdGwrbHptdnU4dW5NMXdhVWZ0cVdzZjczUm4xODlITVwvT1Zzaz0iLCJhbGciOiJSUzI1NiJ9.eyJvcmlnaW5fanRpIjoiNzE3YmRmMmUtZWJlNi00MmIyLTg5ZWQtNWExZGQ2YTA4NGE1Iiwic3ViIjoiMjA0ZGQwYzktNzA3ZS00NDFhLWFhZmMtODMxM2QyNDQxYzRmIiwiYXVkIjoiMWdzYzZrbjNkZnUxaTA3azdwcTR2NHJjYnIiLCJldmVudF9pZCI6ImJlMWVlNTliLTA1NjgtNGNjZC1hMGNkLWE5NTc1YzU5NWIyYSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNjM3MTM1MDY1LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfNHdIUXdNUDN2IiwiY29nbml0bzp1c2VybmFtZSI6IjYyMjdmZTFlLWFkYWUtNDEwYS1iYWE3LTgzZGE5NDgwZDNmMS0yZE9jazd5ayIsImV4cCI6MTYzNzEzODY2NSwiaWF0IjoxNjM3MTM1MDY1LCJqdGkiOiJmOTgxMmNhYy0xODE4LTRkYzAtYmJmNC0zZTQxYmJiMDMyOWEifQ.oyD43kumlemsJLBfqS8xWCIpRUF64_tHnUYt9euCb56yBmehOJa_IzIQ0nypDPMid3fIEtwVxCNcy8Ivby6hcnLsg_L-LaUy6OYufQAVKX9f9UI5aCThb9B5H8i_GxjUjlX5UFFVY70qV2PRZYg02SF9vxFmbn9CxHg8DCM6wZ7CbhO--6LvxvppQqsG1VeSDHK1XV3lumR_0FGMSjr6LnYeUsGapMaamMp9xdVBWtIn__y2Kxcx4Of6f3KuQtIzQAIPF1zliuFeJx6OzYdjDaX4N1_UeiL00B4KC7816v_hNL5hBd2iomdNZM9jJGYT2wMrxO8rOw5J4ZxoKHt_yQ",
   "accessToken":"eyJraWQiOiJmazRSXC9rYzBnWEplY0ZKRmVyUEdHSkVwamxkaFhUSWZGelFHNUl1MktnST0iLCJhbGciOiJSUzI1NiJ9.eyJvcmlnaW5fanRpIjoiNzE3YmRmMmUtZWJlNi00MmIyLTg5ZWQtNWExZGQ2YTA4NGE1Iiwic3ViIjoiMjA0ZGQwYzktNzA3ZS00NDFhLWFhZmMtODMxM2QyNDQxYzRmIiwiZXZlbnRfaWQiOiJiZTFlZTU5Yi0wNTY4LTRjY2QtYTBjZC1hOTU3NWM1OTViMmEiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6ImF3cy5jb2duaXRvLnNpZ25pbi51c2VyLmFkbWluIiwiYXV0aF90aW1lIjoxNjM3MTM1MDY1LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfNHdIUXdNUDN2IiwiZXhwIjoxNjM3MTYzODY1LCJpYXQiOjE2MzcxMzUwNjUsImp0aSI6ImY2MDNiOTI2LTQ1Y2YtNDE0OC1iNjkzLTcxYjAxMzEyZDk4NSIsImNsaWVudF9pZCI6IjFnc2M2a24zZGZ1MWkwN2s3cHE0djRyY2JyIiwidXNlcm5hbWUiOiI2MjI3ZmUxZS1hZGFlLTQxMGEtYmFhNy04M2RhOTQ4MGQzZjEtMmRPY2s3eWsifQ.cOIHXn1sUBcqLhVewXoELXz9MbgL7aEmUG9YbFYZH5xGE6ROMc62qY_R3Ti0USl2CoMo-ITwcrdN7HN8RYc7hdunOSu-8_wGLnVhjuywbF4U3cW_EiF1zuofK9UV2ed6mXpEeHvfISbpdy5zlyqhWeoCs_LOqxtnj9mjv3b4odlujQKkQQBFijC2aqUxGfeQLj5dngTNMinOWn-kmCJLhzuRKeTnfcMkIy_ESyv7P3JkMP_nc3FUpOFp6epV9GGQpT-5nEw9kOcnw5z31z0mGiEtuVJagi2tMtNv03Swv5nPhW7QYBrX8yA0GNqDR4wFx4yYKv124aLCkA8Bp5N8PA",
   "latitude":"7.8804",
   "longitude":"98.3923",
   "language":"TH",
   "env":"Alpha"
  }
  """;

  static String getMockData() {
    return _responseMock;
  }

  static void setMock(String mock) {
    _responseMock = mock;
  }

  @override
  Future<GetUserLocationResponseModelChannel> invokeExampleMethod(
      {required String methodName,
      required GetUserLocationArgumentModelChannel arguments}) async {
    return GetUserLocationResponseModelChannel.fromJson(_responseMock);
  }

  @override
  void dispose() {}
}
