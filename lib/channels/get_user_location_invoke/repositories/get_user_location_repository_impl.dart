import 'package:either_dart/either.dart';
import 'package:ota/channels/get_user_location_invoke/data_sources/get_user_location_data_source.dart';
import 'package:ota/channels/get_user_location_invoke/data_sources/get_user_location_mock_data_source.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_argument_model_channel.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_response_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class GetUserLocationRepository extends Disposer {
  Future<Either<Failure, GetUserLocationResponseModelChannel>>
      invokeExampleMethod(
          {required String methodName,
          required GetUserLocationArgumentModelChannel arguments});
}

class GetUserLocationRepositoryImpl implements GetUserLocationRepository {
  GetUserLocationChannelDataSource? cognitoChannelDataSource;

  GetUserLocationRepositoryImpl(
      {GetUserLocationChannelDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      cognitoChannelDataSource = OtaChannelConfig.isModule
          ? GetUserLocationChannelDataSourceImpl()
          : GetUserLocationMockDataSourceImpl();
    } else {
      cognitoChannelDataSource = remoteDataSource;
    }
  }

  @override
  Future<Either<Failure, GetUserLocationResponseModelChannel>>
      invokeExampleMethod(
          {required String methodName,
          required GetUserLocationArgumentModelChannel arguments}) async {
    try {
      GetUserLocationResponseModelChannel? response =
          await cognitoChannelDataSource?.invokeExampleMethod(
              methodName: methodName, arguments: arguments);
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
