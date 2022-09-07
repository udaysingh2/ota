import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_payment/data_source/car_payment_remote_data_source.dart';

import '../../../../common/network/exceptions.dart';
import '../models/car_payment_argument_model.dart';
import '../models/car_payment_model_domain.dart';

abstract class CarPaymentRepository {
  Future<Either<Failure, CarPaymentDomainModelData>> getCarPaymentData(
      CarPaymentDomainArgumentModel argument);
}

class CarPaymentRepositoryImpl implements CarPaymentRepository {
  CarPaymentRemoteDataSource? carPaymentRemoteDataSource;

  InternetConnectionInfo? internetConnectionInfo;

 static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetConnectionInfo = internetConnectionInfo;
  }

  CarPaymentRepositoryImpl(
      {CarPaymentRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (_carPaymentRemoteDataSource != null) {
      carPaymentRemoteDataSource = _carPaymentRemoteDataSource;
    } else if (remoteDataSource == null) {
      carPaymentRemoteDataSource = CarPaymentRemoteDataSourceImpl();
      //carPaymentRemoteDataSource = CarPaymentMockDataSourceImpl();
    } else {
      carPaymentRemoteDataSource = remoteDataSource;
    }

    if (_internetConnectionInfo != null) {
      internetConnectionInfo = _internetConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, CarPaymentDomainModelData>> getCarPaymentData(
      CarPaymentDomainArgumentModel argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final carPaymentResult =
            await carPaymentRemoteDataSource?.getCarPaymentData(argument);

        return Right(carPaymentResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  CarPaymentRemoteDataSource? _carPaymentRemoteDataSource;
  static InternetConnectionInfo? _internetConnectionInfo;

  void mockDynamicPlaylistPageData(
      {CarPaymentRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    _carPaymentRemoteDataSource = remoteDataSource;
    _internetConnectionInfo = internetInfo;
  }
}
