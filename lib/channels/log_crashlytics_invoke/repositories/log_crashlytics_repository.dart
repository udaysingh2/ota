import 'package:either_dart/either.dart';
import 'package:ota/channels/log_crashlytics_invoke/data_sources/log_crashlytics_data_source.dart';
import 'package:ota/channels/log_crashlytics_invoke/data_sources/log_crashlytics_mock_data_source.dart';
import 'package:ota/channels/log_crashlytics_invoke/models/log_crashlytics_argument_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class LogCrashlyticsRegisterRepository extends Disposer {
  Future<Either<Failure, SuccessResponse>> invokeMethod(
      {required String methodName,
      required LogCrashlyticsArgumentModelChannel arguments});
}

class LogCrashlyticsRepositoryImpl implements LogCrashlyticsRegisterRepository {
  LogCrashlyticsDataSource? paymentManagementDataSource;

  LogCrashlyticsRepositoryImpl({LogCrashlyticsDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      paymentManagementDataSource = OtaChannelConfig.isModule
          ? PaymentManagementDataSourceImpl()
          : LogCrashlyticsMockDataSourceImpl();
    } else {
      paymentManagementDataSource = remoteDataSource;
    }
  }

  @override
  Future<Either<Failure, SuccessResponse>> invokeMethod(
      {required String methodName,
      required LogCrashlyticsArgumentModelChannel arguments}) async {
    try {
      SuccessResponse? response = await paymentManagementDataSource
          ?.invokeMethod(methodName: methodName, arguments: arguments);
      return Right(response!);
    } on Exception catch (error) {
      return Left(ChannelFailure(error.toString()));
    }
  }

  @override
  void dispose() {
    paymentManagementDataSource?.dispose();
  }
}
