import 'dart:async';

import 'package:ota/channels/register_confirm_booking_handler/data_source/register_confirm_booking_data_source.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class RegisterConfirmBookingMockDataSourceImpl
    implements RegisterConfirmBookingDataSource {
  static String _responseMock = """
  {
    "userId": "55bdb958-97e8-4c10-bfa0-7ed1d8d6973b-02E0JPDV",
    "userType": "ACTIVE",
    "language": "TH",
    "env": "DEV",
    "idToken":"eyJraWQiOiI4cmJ6ZnhNdGwrbHptdnU4dW5NMXdhVWZ0cVdzZjczUm4xODlITVwvT1Zzaz0iLCJhbGciOiJSUzI1NiJ9.eyJvcmlnaW5fanRpIjoiNGQyOGRhNGQtNjljYS00MTBlLWI0YzItMTliMjgyOTJkMDRhIiwic3ViIjoiNDAzOGYzMWUtY2Y2Mi00MzAxLTg2YTEtOGY1YzU2MmI5OWRkIiwiYXVkIjoiMWdzYzZrbjNkZnUxaTA3azdwcTR2NHJjYnIiLCJldmVudF9pZCI6ImQ3YjkzNTE0LTkyZDktNDQ2Zi04ZGIxLTIzMjhmNzg4ZWFiOSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNjM2NTMyMjM1LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfNHdIUXdNUDN2IiwiY29nbml0bzp1c2VybmFtZSI6ImNhMDUxYmRkLWEwZGYtNDA3NC1hMWQ4LTljYjIxYjFjNzVhZC02VFRTUHJpbiIsImV4cCI6MTYzNjUzNTgzNSwiaWF0IjoxNjM2NTMyMjM1LCJqdGkiOiI2ZmJlMmViMS1kNzIxLTQ1OTAtOTVjYy1mMzExOTJkNzFlNjYifQ.bf7QE7xlRrwRwG438lcDAEl8TAA5SS2GxINRe8lMxLOUDS2bIiEKyCslRuVlIOz5W7Dl5TWhJ4k33N48VeoA9uZUYK34xEMLGU_DXq68-UF637v-mZIcsAM4iQJP0jjelRvKS1RbAbX5BUaavSYkM_y4om-QfPhUY64Kz-gInwE95fus0W1P5r4aDrHmgm4Ds5haO_JN04EuAfKyp-TPiDQGBay_IsL06FQbQQ_Guqnhh1hmYyQaLO-7NDjhuO0L1j28v29QJLD0Jm-ncrb2_OZTMDJ4H52c-FoSEo3v9NCLQA1xJExQ3xpqq1Y5OsfQYHbZzo38-6vQ_aumBcOiSw",
    "accessToken":"eyJraWQiOiJmazRSXC9rYzBnWEplY0ZKRmVyUEdHSkVwamxkaFhUSWZGelFHNUl1MktnST0iLCJhbGciOiJSUzI1NiJ9.eyJvcmlnaW5fanRpIjoiNGQyOGRhNGQtNjljYS00MTBlLWI0YzItMTliMjgyOTJkMDRhIiwic3ViIjoiNDAzOGYzMWUtY2Y2Mi00MzAxLTg2YTEtOGY1YzU2MmI5OWRkIiwiZXZlbnRfaWQiOiJkN2I5MzUxNC05MmQ5LTQ0NmYtOGRiMS0yMzI4Zjc4OGVhYjkiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6ImF3cy5jb2duaXRvLnNpZ25pbi51c2VyLmFkbWluIiwiYXV0aF90aW1lIjoxNjM2NTMyMjM1LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfNHdIUXdNUDN2IiwiZXhwIjoxNjM2NTYxMDM1LCJpYXQiOjE2MzY1MzIyMzUsImp0aSI6IjRjNDA1MGRjLTI5ODUtNDM4NC1iYTQ2LWRlOWIwZDk4ZjI5NSIsImNsaWVudF9pZCI6IjFnc2M2a24zZGZ1MWkwN2s3cHE0djRyY2JyIiwidXNlcm5hbWUiOiJjYTA1MWJkZC1hMGRmLTQwNzQtYTFkOC05Y2IyMWIxYzc1YWQtNlRUU1ByaW4ifQ.ihFQvWSOrX2ZztmLdiIGzyYlcRgCtN6kr8xVyfu2ahZ-xKpu--QhTAAvwAvrpaQCON0r7SjIZ3RvvcHZi3_ix_gFE0JT0D-Ughmz4ilBbd44vZTY7PPLCqg63id1STMUyyJ_IYb0C_bZDsbWjE7x3FofmAl99-4wN5GezwzJSGIws1vj_RCYglwR8hAQxpaLRyJ9Kk5_wGQq9ieGuLkpCq8V6wAs0lSjiUgyvNmDhZb4EunaoRRJrby32eyz_sscvI3SircW8grfe46Mjp05J86JXVs2a3GpiAyGsw5mZDVh2DO0Bz63PUOQzpDakKLi3233Vb1QrLHhEkjNtuqMUA",
    "userName":"",
    "existingCust":"NO"
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
      {required Function(RegisterConfirmBookingModelChannel) nativeResponse,
      required String methodName}) {
    Future.delayed(const Duration(seconds: 1), () {
      // nativeResponse(
      //     RegisterConfirmBookingModelChannel.fromJson(_responseMock));
    });
    return const Stream.empty().listen((event) {});
  }

  @override
  void dispose() {}
}
