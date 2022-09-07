import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/splash/data_sources/splash_mock_data_source.dart';
import 'package:ota/domain/splash/data_sources/splash_remote_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Splash mock data source group", () {
    SplashRemoteDataSource splashRemoteDataSource = SplashMockDataSourceImpl();
    splashRemoteDataSource = SplashMockDataSourceImpl();

    test('splash mock data source', () async {
      splashRemoteDataSource.getSplashData();
    });

    test('Splash  mock data source', () async {
      String response = SplashMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('Splash mock data source', () async {
      String response = SplashMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('Splash  mock data source', () async {
      splashRemoteDataSource.getSplashData();
    });
  });
}
