import 'dart:async';

import 'package:ota/channels/examplemethodhandler/models/example_response_model_channel.dart';
import 'package:ota/channels/examplemethodhandler/repositories/example_repository_impl.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class ExampleUseCases extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(ExampleResponseModelChannel) nativeResponse,
      required String methodName});
}

class ExampleUseCasesImpl implements ExampleUseCases {
  ExampleRepository? exampleRepository;

  /// Dependence injection via constructor
  ExampleUseCasesImpl({ExampleRepository? repository}) {
    if (repository == null) {
      exampleRepository = ExampleRepositoryImpl();
    } else {
      exampleRepository = repository;
    }
  }

  @override
  void dispose() {
    exampleRepository?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(ExampleResponseModelChannel) nativeResponse,
      required String methodName}) {
    return exampleRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
