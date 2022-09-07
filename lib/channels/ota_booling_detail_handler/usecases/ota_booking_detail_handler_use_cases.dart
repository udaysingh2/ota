import 'dart:async';

import 'package:ota/channels/ota_booling_detail_handler/models/ota_booking_handler_model_channel.dart';
import 'package:ota/channels/ota_booling_detail_handler/repositories/ota_booking_detail_handler_repository.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class OtaBookingDetailHandlerUseCase extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaBookingDetailHandlerModelChannel) nativeResponse,
      required String methodName});
}

class OtaBookingDetailHandlerUseCaseImpl
    implements OtaBookingDetailHandlerUseCase {
  OtaBookingDetailHandlerRepository? otaRepository;

  /// Dependence injection via constructor
  OtaBookingDetailHandlerUseCaseImpl(
      {OtaBookingDetailHandlerRepository? repository}) {
    if (repository == null) {
      otaRepository = OtaBookingDetailHandlerRepositoryImpl();
    } else {
      otaRepository = repository;
    }
  }

  @override
  void dispose() {
    otaRepository?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(OtaBookingDetailHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
