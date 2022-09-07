import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/data_source/ota_landing_noti_handler_data_source.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/models/ota_landing_noti_handler_model_channel.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/repositories/ota_landing_noti_handler_repository.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      OtaLandingNotiHandlerRepositoryImpl getCognitoRepositoryImpl =
          OtaLandingNotiHandlerRepositoryImpl(
              remoteDataSource: GetMockGetCognitoChannelDataSource());
      getCognitoRepositoryImpl.handleMethodChannel(
          nativeResponse: (pt) {}, methodName: "methodName");

      getCognitoRepositoryImpl.dispose();
      OtaLandingNotiHandlerRepositoryImpl();
      OtaChannelConfig.isModule = true;
      OtaLandingNotiHandlerRepositoryImpl();
    });
  });
}

class GetMockGetCognitoChannelDataSource
    implements OtaLandingNotiHandlerDataSource {
  @override
  void dispose() {}

  @override
  StreamSubscription handleMethodChannel(
      {required Function(OtaLandingNotiHandlerModelChannel p1) nativeResponse,
      required String methodName}) {
    return const Stream.empty().listen((event) {});
  }
}
