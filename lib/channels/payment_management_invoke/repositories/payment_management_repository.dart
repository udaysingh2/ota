import 'package:either_dart/either.dart';
import 'package:ota/channels/payment_management_invoke/data_sources/payment_management_data_source.dart';
import 'package:ota/channels/payment_management_invoke/data_sources/payment_management_mock_data_source.dart';
import 'package:ota/channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class PaymentManagementRegisterRepository extends Disposer {
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required PaymentManagementArgumentModelChannel arguments});
}

class PaymentManagementRepositoryImpl
    implements PaymentManagementRegisterRepository {
  PaymentManagementDataSource? paymentManagementDataSource;

  PaymentManagementRepositoryImpl(
      {PaymentManagementDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      paymentManagementDataSource = OtaChannelConfig.isModule
          ? PaymentManagementDataSourceImpl()
          : PaymentManagementMockDataSourceImpl();
    } else {
      paymentManagementDataSource = remoteDataSource;
    }
  }

  @override
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required PaymentManagementArgumentModelChannel arguments}) async {
    try {
      SuccessResponse? response = await paymentManagementDataSource
          ?.invokeExampleMethod(methodName: methodName, arguments: arguments);
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
