import 'dart:async';

import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';
import 'package:ota/channels/ota_payment_handler/repositories/ota_payment_repository.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class OtaPaymentUseCases extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaPaymentModelChannel) nativeResponse,
      required String methodName});
}

class OtaPaymentUseCasesImpl implements OtaPaymentUseCases {
  OtaPaymentRepository? otaPaymentRepository;

  /// Dependence injection via constructor
  OtaPaymentUseCasesImpl({OtaPaymentRepository? repository}) {
    if (repository == null) {
      otaPaymentRepository = OtaPaymentRepositoryImpl();
    } else {
      otaPaymentRepository = repository;
    }
  }

  @override
  void dispose() {
    otaPaymentRepository?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(OtaPaymentModelChannel) nativeResponse,
      required String methodName}) {
    return otaPaymentRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
