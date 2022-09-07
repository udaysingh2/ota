import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_booling_detail_handler/models/ota_booking_handler_model_channel.dart';
import 'package:ota/channels/ota_booling_detail_handler/repositories/ota_booking_detail_handler_repository.dart';
import 'package:ota/channels/ota_booling_detail_handler/usecases/ota_booking_detail_handler_use_cases.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      OtaBookingDetailHandlerUseCaseImpl getCognitoUseCasesImpl =
          OtaBookingDetailHandlerUseCaseImpl(
              repository: GetCognitoRepositoryMock());
      getCognitoUseCasesImpl.handleMethodChannel(
          methodName: "methodName", nativeResponse: (p1) {});
      getCognitoUseCasesImpl.dispose();
      OtaBookingDetailHandlerUseCaseImpl();
    });
  });
}

class GetCognitoRepositoryMock implements OtaBookingDetailHandlerRepository {
  @override
  void dispose() {}

  @override
  StreamSubscription handleMethodChannel(
      {required Function(OtaBookingDetailHandlerModelChannel p1) nativeResponse,
      required String methodName}) {
    return const Stream.empty().listen((event) {});
  }
}
