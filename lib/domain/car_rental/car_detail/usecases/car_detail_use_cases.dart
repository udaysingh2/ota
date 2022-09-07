import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_argument_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/check_favourite_domain_model.dart';
import 'package:ota/domain/car_rental/car_detail/repositories/car_detail_repository_impl.dart';

import '../../../favourites/models/unfavourite_model_domain.dart';
import '../model/add_favourite_model_domain.dart';

/// Interface for CarDetail use cases.
abstract class CarDetailUseCases {
  Future<Either<Failure, CarDetailDomainModel>?> getCarDetail(
      CarDetailDomainArgumentModel argument);

  Future<Either<Failure, CheckFavouriteDomainModel>?> checkFavouriteCar({
    required String supplierId,
    required String carId,
    required String serviceName,
  });

  Future<Either<Failure, UnFavouriteModelDomain>?> unfavouritesCar({
    required String id,
    required String supplierId,
    required String serviceName,
  });

  Future<Either<Failure, AddfavouriteModelDomain>?> addFavouriteCar(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel,
      required String serviceName});
}

class CarDetailUseCasesImpl implements CarDetailUseCases {
  CarDetailRepository? _carDetailRepository;

  /// Dependence injection via constructor
  CarDetailUseCasesImpl({CarDetailRepository? repository}) {
    if (repository == null) {
      _carDetailRepository = CarDetailRepositoryImpl();
    } else {
      _carDetailRepository = repository;
    }
  }

  @override
  Future<Either<Failure, AddfavouriteModelDomain>?> addFavouriteCar(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel,
      required String serviceName}) async {
    return await _carDetailRepository?.addFavouriteCar(
        favoriteArgumentModel: favoriteArgumentModel, serviceName: serviceName);
  }

  @override
  Future<Either<Failure, CheckFavouriteDomainModel>?> checkFavouriteCar(
      {required String supplierId,
      required String carId,
      required String serviceName}) async {
    return await _carDetailRepository?.checkFavouriteCar(
        supplierId: supplierId, carId: carId, serviceName: serviceName);
  }

  @override
  Future<Either<Failure, CarDetailDomainModel>?> getCarDetail(
      CarDetailDomainArgumentModel argument) async {
    return await _carDetailRepository?.getCarDetail(argument);
  }

  @override
  Future<Either<Failure, UnFavouriteModelDomain>?> unfavouritesCar(
      {required String id,
      required String supplierId,
      required String serviceName}) async {
    return await _carDetailRepository?.unfavouritesCar(
        id: id, supplierId: supplierId, serviceName: serviceName);
  }
}
