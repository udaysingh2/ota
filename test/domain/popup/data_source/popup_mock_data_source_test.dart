import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/popup/data_sources/popup_remote_data_source.dart';
import 'package:ota/domain/popup/data_sources/popup_remote_data_source_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Hotel method mock data source group", () {
    PopupRemoteDataSource popupRemoteDataSource = PopupMockDataSourceImpl();
    popupRemoteDataSource = PopupMockDataSourceImpl();

    test('pop up mock data source', () async {
      popupRemoteDataSource.getPopup();
    });

    test('pop up  mock data source', () async {
      String response = PopupMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('pop up mock data source', () async {
      String response = PopupMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('pop up  mock data source', () async {
      popupRemoteDataSource.getPopup();
    });
  });
}
