import 'package:either_dart/either.dart';
import 'package:ota/channels/log_crashlytics_invoke/models/log_crashlytics_argument_model_channel.dart';
import 'package:ota/channels/log_crashlytics_invoke/repositories/log_crashlytics_repository.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';

/// Interface for ExampleUseCases.
abstract class LogCrashlyticsUseCases extends Disposer {
  Future<Either<Failure, SuccessResponse>> invokeMethod(
      {required String methodName,
      required LogCrashlyticsArgumentModelChannel arguments});
}

class LogCrashlyticsUseCasesImpl implements LogCrashlyticsUseCases {
  LogCrashlyticsRegisterRepository? logCrashlyticsRepository;

  /// Dependence injection via constructor
  LogCrashlyticsUseCasesImpl({LogCrashlyticsRegisterRepository? repository}) {
    if (repository == null) {
      logCrashlyticsRepository = LogCrashlyticsRepositoryImpl();
    } else {
      logCrashlyticsRepository = repository;
    }
  }

  @override
  Future<Either<Failure, SuccessResponse>> invokeMethod(
      {required String methodName,
      required LogCrashlyticsArgumentModelChannel arguments}) async {
    return await logCrashlyticsRepository!
        .invokeMethod(methodName: methodName, arguments: arguments);
  }

  @override
  void dispose() {
    logCrashlyticsRepository?.dispose();
  }
}
