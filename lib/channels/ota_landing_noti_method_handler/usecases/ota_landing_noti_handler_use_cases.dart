import 'dart:async';

import 'package:ota/channels/ota_landing_noti_method_handler/models/ota_landing_noti_handler_model_channel.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/repositories/ota_landing_noti_handler_repository.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class OtaLandingNotiHandlerUseCase extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaLandingNotiHandlerModelChannel) nativeResponse,
      required String methodName});
}

class OtaLandingNotiHandlerUseCaseImpl implements OtaLandingNotiHandlerUseCase {
  OtaLandingNotiHandlerRepository? otaRepository;

  /// Dependence injection via constructor
  OtaLandingNotiHandlerUseCaseImpl(
      {OtaLandingNotiHandlerRepository? repository}) {
    if (repository == null) {
      otaRepository = OtaLandingNotiHandlerRepositoryImpl();
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
      {required Function(OtaLandingNotiHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
