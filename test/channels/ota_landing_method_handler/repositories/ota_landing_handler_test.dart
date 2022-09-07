import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_landing_method_handler/data_source/ota_landing_handler_data_source.dart';
import 'package:ota/channels/ota_landing_method_handler/models/ota_landing_handler_model_channel.dart';
import 'package:ota/channels/ota_landing_method_handler/repositories/ota_landing_handler_repository.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      OtaLandingHandlerRepositoryImpl getCognitoRepositoryImpl =
          OtaLandingHandlerRepositoryImpl(
              remoteDataSource: GetMockGetCognitoChannelDataSource());
      getCognitoRepositoryImpl.handleMethodChannel(
          nativeResponse: (pt) {}, methodName: "methodName");

      getCognitoRepositoryImpl.dispose();
      OtaLandingHandlerRepositoryImpl();
      OtaChannelConfig.isModule = true;
      OtaLandingHandlerRepositoryImpl();
    });
  });
}

class GetMockGetCognitoChannelDataSource
    implements OtaLandingHandlerDataSource {
  @override
  void dispose() {}

  @override
  StreamSubscription handleMethodChannel(
      {required Function(OtaLandingHandlerModelChannel p1) nativeResponse,
      required String methodName}) {
    return const Stream.empty().listen((event) {});
  }
}
