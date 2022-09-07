import 'dart:async';

import 'package:ota/channels/hotel_detail_method_handler/models/hotel_detail_reponse_model_channel.dart';
import 'package:ota/channels/hotel_detail_method_handler/repositories/hotel_detail_channel_repository_impl.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class PropertyDetailHandlerUseCase extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(PropertyDetailHandlerModelChannel) nativeResponse,
      required String methodName});
}

class PropertyDetailHandlerUseCaseImpl implements PropertyDetailHandlerUseCase {
  PropertyDetailHandlerRepository? otaRepository;

  /// Dependence injection via constructor
  PropertyDetailHandlerUseCaseImpl(
      {PropertyDetailHandlerRepository? repository}) {
    if (repository == null) {
      otaRepository = PropertyDetailHandlerRepositoryImpl();
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
      {required Function(PropertyDetailHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
