import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_booling_detail_handler/data_source/ota_booking_detail_handler_data_source.dart';
import 'package:ota/channels/ota_booling_detail_handler/models/ota_booking_handler_model_channel.dart';
import 'package:ota/channels/ota_booling_detail_handler/repositories/ota_booking_detail_handler_repository.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      OtaBookingDetailHandlerRepositoryImpl getCognitoRepositoryImpl =
          OtaBookingDetailHandlerRepositoryImpl(
              remoteDataSource: GetMockGetCognitoChannelDataSource());
      getCognitoRepositoryImpl.handleMethodChannel(
          nativeResponse: (pt) {}, methodName: "methodName");

      getCognitoRepositoryImpl.dispose();
      OtaBookingDetailHandlerRepositoryImpl();
      OtaChannelConfig.isModule = true;
      OtaBookingDetailHandlerRepositoryImpl();
    });
  });
}

class GetMockGetCognitoChannelDataSource
    implements OtaBookingDetailHandlerDataSource {
  @override
  void dispose() {}

  @override
  StreamSubscription handleMethodChannel(
      {required Function(OtaBookingDetailHandlerModelChannel p1) nativeResponse,
      required String methodName}) {
    return const Stream.empty().listen((event) {});
  }
}
