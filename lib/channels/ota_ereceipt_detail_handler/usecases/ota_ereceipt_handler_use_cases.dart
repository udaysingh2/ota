import 'dart:async';

import 'package:ota/channels/ota_ereceipt_detail_handler/models/ota_ereceipt_handler_model_channel.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/repositories/ota_ereceipt_handler_repository.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class OtaEReceiptHandlerUseCase extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaEReceiptHandlerModelChannel) nativeResponse,
      required String methodName});
}

class OtaEReceiptHandlerUseCaseImpl implements OtaEReceiptHandlerUseCase {
  OtaEReceiptHandlerRepository? otaRepository;

  /// Dependence injection via constructor
  OtaEReceiptHandlerUseCaseImpl({OtaEReceiptHandlerRepository? repository}) {
    if (repository == null) {
      otaRepository = OtaEReceiptHandlerRepositoryImpl();
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
      {required Function(OtaEReceiptHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
