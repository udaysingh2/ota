import 'package:either_dart/either.dart';
import 'package:ota/channels/example/data_sources/example_channel_data_source.dart';
import 'package:ota/channels/example/data_sources/example_mock_data_source.dart';
import 'package:ota/channels/example/models/example_argument_model_channel.dart';
import 'package:ota/channels/example/models/example_response_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class ExampleRepository extends Disposer {
  Future<Either<Failure, ExampleResponseModelChannel>> invokeExampleMethod(
      {required String methodName,
      required ExampleArgumentModelChannel arguments});
}

class ExampleRepositoryImpl implements ExampleRepository {
  ExampleChannelDataSource? exampleChannelDataSource;

  ExampleRepositoryImpl({ExampleChannelDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      exampleChannelDataSource = OtaChannelConfig.isModule
          ? ExampleMockDataSourceImpl()
          : ExampleChannelDataSourceImpl();
    } else {
      exampleChannelDataSource = remoteDataSource;
    }
  }

  @override
  Future<Either<Failure, ExampleResponseModelChannel>> invokeExampleMethod(
      {required String methodName,
      required ExampleArgumentModelChannel arguments}) async {
    try {
      ExampleResponseModelChannel? response = await exampleChannelDataSource
          ?.invokeExampleMethod(methodName: methodName, arguments: arguments);
      return Right(response!);
    } on Exception catch (error) {
      return Left(ChannelFailure(error.toString()));
    }
  }

  @override
  void dispose() {
    exampleChannelDataSource?.dispose();
  }
}
