import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/tours/service_card/data_sources/service_cards_remote_data_source_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("service card Group ", () {
    test("service card Data Source", () async {
      ServiceCardRemoteDataSource serviceCardMockDataSource =
          ServiceCardMockDataSourceImpl();
      serviceCardMockDataSource.getServiceCardData();
    });
    test("Service Card", () async {
      ServiceCardRemoteDataSource serviceCardMockData =
          ServiceCardMockDataSourceImpl();
      final result = await serviceCardMockData.getServiceCardData();
      expect(result.getTourServiceCards!.data != null, true);
    });
  });
}
