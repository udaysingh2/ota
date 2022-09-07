import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/hotel_detail_method_handler/data_source/hotel_detail_channel_data_source.dart';
import 'package:ota/channels/hotel_detail_method_handler/data_source/hotel_detail_channel_mock_data_source.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final String json = fixture(
      "channels/ota_hotel_detail_handler/ota_hotel_detail_handler.json");

  test('OTA hotel detail handler mock data source', () async {
    PropertyDetailHandlerDataSource propertyDetailHandlerDataSource =
        PropertyDetailHandlerMockDataSourceImpl();
    // ignore: cancel_subscriptions
    final res = propertyDetailHandlerDataSource.handleMethodChannel(
        nativeResponse: (p0) {}, methodName: "hotelDetail");
    // ignore: unnecessary_null_comparison
    expect(res != null, true);
    PropertyDetailHandlerMockDataSourceImpl.getMockData();
    PropertyDetailHandlerMockDataSourceImpl.setMock(json);
    propertyDetailHandlerDataSource.dispose();
  });
}
