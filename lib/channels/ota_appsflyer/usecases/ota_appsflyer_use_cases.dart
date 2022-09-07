import 'package:ota/channels/ota_appsflyer/model/ota_appsflyer_model_channel.dart';
import 'package:ota/channels/ota_appsflyer/repositories/ota_appsflyer_repository_impl.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class GetAppsFlyerChannelUseCases extends Disposer {
  void invokeExampleMethod({
    required String methodName,
    required GetAppsFlyerModelChannel arguments,
  });
}

class GetAppsFlyerChannelUseCasesImpl implements GetAppsFlyerChannelUseCases {
  GetAppsFlyerChannelRepository? exampleRepository;

  /// Dependence injection via constructor
  GetAppsFlyerChannelUseCasesImpl({GetAppsFlyerChannelRepository? repository}) {
    if (repository == null) {
      exampleRepository = GetAppsFlyerChannelRepositoryImpl();
    } else {
      exampleRepository = repository;
    }
  }

  @override
  void invokeExampleMethod({
    required String methodName,
    required GetAppsFlyerModelChannel arguments,
  }) async {
    exampleRepository!.invokeExampleMethod(
      methodName: methodName,
      arguments: arguments,
    );
  }

  @override
  void dispose() {
    exampleRepository?.dispose();
  }
}
