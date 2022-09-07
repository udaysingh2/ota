import 'package:either_dart/either.dart';
import 'package:ota/channels/booking_customer_register_invoke/data_sources/booking_customer_register_data_source.dart';
import 'package:ota/channels/booking_customer_register_invoke/data_sources/booking_customer_register_mock_data_source.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class BookingCustomerRegisterRepository extends Disposer {
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required BookingCustomerRegisterArgumentModelChannel arguments});
}

class BookingCustomerRegisterRepositoryImpl
    implements BookingCustomerRegisterRepository {
  BookingCustomerRegisterDataSource? bookingCustomerRegisterDataSource;

  BookingCustomerRegisterRepositoryImpl(
      {BookingCustomerRegisterDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      bookingCustomerRegisterDataSource = OtaChannelConfig.isModule
          ? BookingCustomerRegisterDataSourceImpl()
          : BookingCustomerRegisterMockDataSourceImpl();
    } else {
      bookingCustomerRegisterDataSource = remoteDataSource;
    }
  }

  @override
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required BookingCustomerRegisterArgumentModelChannel arguments}) async {
    try {
      SuccessResponse? response = await bookingCustomerRegisterDataSource
          ?.invokeExampleMethod(methodName: methodName, arguments: arguments);
      return Right(response!);
    } on Exception catch (error) {
      return Left(ChannelFailure(error.toString()));
    }
  }

  @override
  void dispose() {
    bookingCustomerRegisterDataSource?.dispose();
  }
}
