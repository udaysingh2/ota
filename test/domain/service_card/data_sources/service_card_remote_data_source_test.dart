import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/landing/service_card/data_sources/service_card_mock_data_source.dart';
import 'package:ota/domain/landing/service_card/data_sources/service_card_remote_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("service card  mock data source group", () {
    ServiceCardRemoteDataSource serviceCardRemoteDataSource =
        ServiceCardMockDataSourceImpl();
    serviceCardRemoteDataSource = ServiceCardMockDataSourceImpl();
    serviceCardRemoteDataSource.getServiceCardData();

    test('service card  mock data source', () async {
      String response = ServiceCardMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('service card  mock data source', () async {
      String response = ServiceCardMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
  });
}
