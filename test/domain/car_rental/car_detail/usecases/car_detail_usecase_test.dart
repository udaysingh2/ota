import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favourite_model_domain.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_argument_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/check_favourite_domain_model.dart';
import 'package:ota/domain/car_rental/car_detail/repositories/car_detail_repository_impl.dart';
import 'package:ota/domain/car_rental/car_detail/usecases/car_detail_use_cases.dart';
import 'package:ota/domain/favourites/models/unfavourite_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

class CarDetailUseCase implements CarDetailRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, AddfavouriteModelDomain>?> addFavouriteCar(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel,
      required String serviceName}) {
    // TODO: implement addFavouriteCar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CheckFavouriteDomainModel>> checkFavouriteCar(
      {required String supplierId,
      required String carId,
      required String serviceName}) {
    // TODO: implement checkFavouriteCar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CarDetailDomainModel>> getCarDetail(
      CarDetailDomainArgumentModel argument) async {
    Map<String, dynamic> map =
        json.decode(fixture("car_detail/car_detail.json"));
    CarDetailDomainModel sort = CarDetailDomainModel.fromMap(map);
    return Right(sort);
  }

  @override
  Future<Either<Failure, UnFavouriteModelDomain>> unfavouritesCar(
      {required String id,
      required String supplierId,
      required String serviceName}) {
    // TODO: implement unfavouritesCar
    throw UnimplementedError();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Car Reservation case group", () {
    test('Car Reservation case', () async {
      CarDetailUseCasesImpl();
      CarDetailUseCases carDetailUseCases =
          CarDetailUseCasesImpl(repository: CarDetailUseCase());
      CarDetailDomainArgumentModel argumentModel = CarDetailDomainArgumentModel(
        supplierId: '',
        rentalType: '',
        carId: "",
        pickupLocationId: '',
        returnLocationId: '',
        pickupDate: '',
        returnDate: '',
        includeDriver: '',
        residenceCountry: '',
        currency: '',
        age: 2,
        pickupCounter: '',
        returnCounter: '',
      );
      carDetailUseCases.getCarDetail(argumentModel);
    });
  });
}
