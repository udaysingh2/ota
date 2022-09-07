import 'package:either_dart/either.dart';
import 'package:ota/channels/get_cognito_token_invoke/data_sources/get_cognito_data_source.dart';
import 'package:ota/channels/get_cognito_token_invoke/data_sources/get_cognito_mock_data_source.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_argument_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_response_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class GetCognitoRepository extends Disposer {
  Future<Either<Failure, GetCognitoResponseModelChannel>> invokeExampleMethod(
      {required String methodName,
      required GetCognitoArgumentModelChannel arguments});
}

class GetCognitoRepositoryImpl implements GetCognitoRepository {
  GetCognitoChannelDataSource? cognitoChannelDataSource;

  GetCognitoRepositoryImpl({GetCognitoChannelDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      cognitoChannelDataSource = OtaChannelConfig.isModule
          ? GetCognitoChannelDataSourceImpl()
          : GetCognitoMockDataSourceImpl();
    } else {
      cognitoChannelDataSource = remoteDataSource;
    }
  }

  @override
  Future<Either<Failure, GetCognitoResponseModelChannel>> invokeExampleMethod(
      {required String methodName,
      required GetCognitoArgumentModelChannel arguments}) async {
    try {
      GetCognitoResponseModelChannel? response = await cognitoChannelDataSource
          ?.invokeExampleMethod(methodName: methodName, arguments: arguments);
      return Right(response!);
    } on Exception catch (error) {
      return Left(ChannelFailure(error.toString()));
    }
  }

  @override
  void dispose() {
    cognitoChannelDataSource?.dispose();
  }
}
