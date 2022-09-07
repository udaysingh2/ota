import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_detail/data_source/car_detail_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_argument_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/check_favourite_domain_model.dart';

import '../../../favourites/models/unfavourite_model_domain.dart';
import '../model/add_favourite_model_domain.dart';

/// Interface for CarDetailRepository repository.
abstract class CarDetailRepository {
  Future<Either<Failure, CarDetailDomainModel>> getCarDetail(
      CarDetailDomainArgumentModel argument);

  Future<Either<Failure, CheckFavouriteDomainModel>> checkFavouriteCar({
    required String supplierId,
    required String carId,
    required String serviceName,
  });

  Future<Either<Failure, UnFavouriteModelDomain>> unfavouritesCar({
    required String id,
    required String supplierId,
    required String serviceName,
  });

  Future<Either<Failure, AddfavouriteModelDomain>?> addFavouriteCar(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel,
      required String serviceName});
}

class CarDetailRepositoryImpl implements CarDetailRepository {
  CarDetailRemoteDataSource? _carDetailRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarDetailRepositoryImpl(
      {CarDetailRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      _carDetailRemoteDataSource = CarDetailRemoteDataSourceImpl();
      //_carDetailRemoteDataSource = CarDetailMockDataSourceImpl();
    } else {
      _carDetailRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, CarDetailDomainModel>> getCarDetail(
      CarDetailDomainArgumentModel argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final carResult =
            await _carDetailRemoteDataSource?.getCarDetail(argument);
        return Right(carResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, AddfavouriteModelDomain>?> addFavouriteCar(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel,
      required String serviceName}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final carResult = await _carDetailRemoteDataSource?.addFavouriteCar(
            favoriteArgumentModel: favoriteArgumentModel,
            serviceName: serviceName);
        return Right(carResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, CheckFavouriteDomainModel>> checkFavouriteCar(
      {required String supplierId,
      required String carId,
      required String serviceName}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final carResult = await _carDetailRemoteDataSource?.checkFavouriteCar(
            serviceName: serviceName, supplierId: supplierId, carId: carId);
        return Right(carResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, UnFavouriteModelDomain>> unfavouritesCar(
      {required String id,
      required String supplierId,
      required String serviceName}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final carResult = await _carDetailRemoteDataSource?.unfavouritesCar(
            id: id, serviceName: serviceName, supplierId: supplierId);
        return Right(carResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
