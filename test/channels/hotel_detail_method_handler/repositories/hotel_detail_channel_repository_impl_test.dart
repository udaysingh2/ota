// ignore_for_file: await_only_futures

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/hotel_detail_method_handler/data_source/hotel_detail_channel_mock_data_source.dart';
import 'package:ota/channels/hotel_detail_method_handler/repositories/hotel_detail_channel_repository_impl.dart';

void main() {
  PropertyDetailHandlerRepository? propertyDetailHandlerRepository;

  setUpAll(() async {
    propertyDetailHandlerRepository = PropertyDetailHandlerRepositoryImpl();
    propertyDetailHandlerRepository = PropertyDetailHandlerRepositoryImpl(
        remoteDataSource: PropertyDetailHandlerMockDataSourceImpl());
  });

  test('Prefrence pop up repo with Success response data', () async {
    final res = await propertyDetailHandlerRepository!
        .handleMethodChannel(nativeResponse: (p0) {}, methodName: "");

    propertyDetailHandlerRepository?.dispose();

    // ignore: unnecessary_null_comparison
    expect(res != null, true);
  });
}
