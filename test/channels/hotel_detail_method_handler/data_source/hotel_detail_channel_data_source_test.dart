import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/hotel_detail_method_handler/data_source/hotel_detail_channel_data_source.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      PropertyDetailHandlerDataSource propertyDetailHandlerDataSource =
          PropertyDetailHandlerDataSourceImpl(otaMethodChannel: otaChannel);
      // ignore: cancel_subscriptions
      final res = propertyDetailHandlerDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "hotelDetail");
      // ignore: unnecessary_null_comparison
      expect(res != null, true);
      PropertyDetailHandlerDataSourceImpl.setMock(otaChannel);
      propertyDetailHandlerDataSource.dispose();
    });
    test('hotel detail handler data source', () async {
      PropertyDetailHandlerDataSource propertyDetailHandlerDataSource =
          PropertyDetailHandlerDataSourceImpl(otaMethodChannel: null);
      // ignore: cancel_subscriptions
      propertyDetailHandlerDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "hotelDetail");
    });
  });
}
