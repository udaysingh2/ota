import 'dart:async';

import 'package:ota/channels/ota_landing_method_handler/models/ota_landing_handler_model_channel.dart';
import 'package:ota/channels/ota_landing_method_handler/repositories/ota_landing_handler_repository.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class OtaLandingHandlerUseCase extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaLandingHandlerModelChannel) nativeResponse,
      required String methodName});
}

class OtaLandingHandlerUseCaseImpl implements OtaLandingHandlerUseCase {
  OtaLandingHandlerRepository? otaRepository;

  /// Dependence injection via constructor
  OtaLandingHandlerUseCaseImpl({OtaLandingHandlerRepository? repository}) {
    if (repository == null) {
      otaRepository = OtaLandingHandlerRepositoryImpl();
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
      {required Function(OtaLandingHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
