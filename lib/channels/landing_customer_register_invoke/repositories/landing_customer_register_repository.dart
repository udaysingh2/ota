import 'package:either_dart/either.dart';
import 'package:ota/channels/landing_customer_register_invoke/data_sources/landing_customer_register_data_source.dart';
import 'package:ota/channels/landing_customer_register_invoke/data_sources/landing_customer_register_mock_data_source.dart';
import 'package:ota/channels/landing_customer_register_invoke/models/landing_customer_register_argument_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class LandingCustomerRegisterRepository extends Disposer {
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required LandingCustomerRegisterArgumentModelChannel arguments});
}

class LandingCustomerRegisterRepositoryImpl
    implements LandingCustomerRegisterRepository {
  LandingCustomerRegisterDataSource? landingCustomerRegisterDataSource;

  LandingCustomerRegisterRepositoryImpl(
      {LandingCustomerRegisterDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      landingCustomerRegisterDataSource = OtaChannelConfig.isModule
          ? LandingCustomerRegisterDataSourceImpl()
          : LandingCustomerRegisterMockDataSourceImpl();
    } else {
      landingCustomerRegisterDataSource = remoteDataSource;
    }
  }

  @override
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required LandingCustomerRegisterArgumentModelChannel arguments}) async {
    try {
      SuccessResponse? response = await landingCustomerRegisterDataSource
          ?.invokeExampleMethod(methodName: methodName, arguments: arguments);
      return Right(response!);
    } on Exception catch (error) {
      return Left(ChannelFailure(error.toString()));
    }
  }

  @override
  void dispose() {
    landingCustomerRegisterDataSource?.dispose();
  }
}
