import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/payment_method/data_sources/payment_method_remote_data_source.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';

/// Interface for PaymentMethodRepository repository.
abstract class PaymentMethodRepository {
  /// Call API to get the Payment Method Screen details.
  ///
  /// [userId] to get the Payment Method Data for users.
  /// [Either<Failure, PaymentMethodModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, PaymentMethodModelDomain>> getPaymentMethodListData(
      String userId);
}

/// PaymentMethodRepositoryImpl will contain the PaymentMethodRepository implementation.
class PaymentMethodRepositoryImpl implements PaymentMethodRepository {
  PaymentMethodRemoteDataSource? paymentMethodRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  PaymentMethodRepositoryImpl(
      {PaymentMethodRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      paymentMethodRemoteDataSource = PaymentMethodRemoteDataSourceImpl();
      // paymentMethodRemoteDataSource = PaymentMethodMockDataSourceImpl();
    } else {
      paymentMethodRemoteDataSource = remoteDataSource;
    }
    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Payment Method Screen details.
  ///
  /// [userId] to get the Payment Method Data for users.
  /// [Either<Failure, PaymentMethodModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, PaymentMethodModelDomain>> getPaymentMethodListData(
      String userId) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final paymentMethodResult = await paymentMethodRemoteDataSource
            ?.getPaymentMethodListData(userId);
        return Right(paymentMethodResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
