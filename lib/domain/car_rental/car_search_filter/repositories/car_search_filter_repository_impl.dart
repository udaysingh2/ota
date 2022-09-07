import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_search_filter/data_sources/car_search_filter_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_filter/model/car_search_filter_domain_model.dart';

abstract class CarSearchFilterRepository {
  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchFilterDomainModel>] to handle the Failure or result data.
  Future<Either<Failure, CarSearchFilterDomainModel>> getCarSearchFilterData();
}

/// CarSearchFilterRepositoryImpl will contain the CarSearchFilterRepository implementation.
class CarSearchFilterRepositoryImpl implements CarSearchFilterRepository {
  CarSearchFilterRemoteDataSource? carSearchFilterDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarSearchFilterRepositoryImpl(
      {CarSearchFilterRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      carSearchFilterDataSource = CarSearchFilterRemoteDataSourceImpl();
      // carSearchFilterDataSource = CarSearchFilterMockDataSourceImpl();
    } else {
      carSearchFilterDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchFilterDomainModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarSearchFilterDomainModel>>
      getCarSearchFilterData() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result =
            await carSearchFilterDataSource?.getCarSearchFilterData();
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
