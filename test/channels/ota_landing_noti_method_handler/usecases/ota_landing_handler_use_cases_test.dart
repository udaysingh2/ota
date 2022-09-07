import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/models/ota_landing_noti_handler_model_channel.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/repositories/ota_landing_noti_handler_repository.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/usecases/ota_landing_noti_handler_use_cases.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      OtaLandingNotiHandlerUseCaseImpl getCognitoUseCasesImpl =
          OtaLandingNotiHandlerUseCaseImpl(
              repository: GetCognitoRepositoryMock());
      getCognitoUseCasesImpl.handleMethodChannel(
          methodName: "methodName", nativeResponse: (p1) {});
      getCognitoUseCasesImpl.dispose();
      OtaLandingNotiHandlerUseCaseImpl();
    });
  });
}

class GetCognitoRepositoryMock implements OtaLandingNotiHandlerRepository {
  @override
  void dispose() {}

  @override
  StreamSubscription handleMethodChannel(
      {required Function(OtaLandingNotiHandlerModelChannel p1) nativeResponse,
      required String methodName}) {
    return const Stream.empty().listen((event) {});
  }
}
