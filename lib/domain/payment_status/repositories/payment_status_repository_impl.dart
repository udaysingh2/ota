import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/payment_status/data_sources/payment_status_remote_data_source.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_argument_domain.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_new_model.dart';
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';

/// Interface for HotelDetailRepository repository.
abstract class PaymentStatusRepository {
  Future<Either<Failure, PaymentStatusModelDomain?>> getPaymentStatus(
      String bookingUrn);
  Future<Either<Failure, PaymentInitiateNewModelDomain?>?> getPaymentInitiateV2(
      PaymentInitiateArgumentModelDomain argument);
  Future<Either<Failure, PaymentNewBookingUrnModelDomain?>?> getNewBookingUrn(
      String bookingUrn);
  Future<Either<Failure, PaymentNewCarBookingUrnModelDomain?>?>
      getNewCarBookingUrn(String bookingUrn);
}

class PaymentStatusRepositoryImpl implements PaymentStatusRepository {
  PaymentStatusRemoteDataSource? paymentStatusRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  PaymentStatusRepositoryImpl(
      {PaymentStatusRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      paymentStatusRemoteDataSource = PaymentStatusRemoteDataSourceImpl();
      // paymentStatusRemoteDataSource = PaymentStatusMockDataSourceImpl();
    } else {
      paymentStatusRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, PaymentNewBookingUrnModelDomain?>> getNewBookingUrn(
      String bookingUrn) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final paymnetResult =
            await paymentStatusRemoteDataSource?.getNewBookingUrn(bookingUrn);
        return Right(paymnetResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, PaymentNewCarBookingUrnModelDomain?>>
      getNewCarBookingUrn(String bookingUrn) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final paymnetResult = await paymentStatusRemoteDataSource
            ?.getNewCarBookingUrn(bookingUrn);
        return Right(paymnetResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, PaymentStatusModelDomain?>> getPaymentStatus(
      String bookingUrn) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final paymnetResult =
            await paymentStatusRemoteDataSource?.getPaymentStatus(bookingUrn);
        return Right(paymnetResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, PaymentInitiateNewModelDomain?>?> getPaymentInitiateV2(
      PaymentInitiateArgumentModelDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final paymentResult =
            await paymentStatusRemoteDataSource?.getPaymentInitiateV2(argument);
        return Right(paymentResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
