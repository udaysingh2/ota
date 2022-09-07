import 'dart:async';

import 'package:ota/channels/ota_property_method_handler/models/ota_property_reponse_model_channel.dart';
import 'package:ota/channels/ota_property_method_handler/repositories/ota_property_channel_repository_impl.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class OtaPropertyHandlerUseCase extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaPropertyHandlerModelChannel) nativeResponse,
      required String methodName});
}

class OtaPropertyHandlerUseCaseImpl implements OtaPropertyHandlerUseCase {
  OtaPropertyHandlerRepository? otaRepository;

  /// Dependence injection via constructor
  OtaPropertyHandlerUseCaseImpl({OtaPropertyHandlerRepository? repository}) {
    if (repository == null) {
      otaRepository = OtaPropertyHandlerRepositoryImpl();
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
      {required Function(OtaPropertyHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
