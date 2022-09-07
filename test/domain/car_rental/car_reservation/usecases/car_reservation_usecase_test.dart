import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_reservation/data_source/car_reservation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_argument_model.dart';
import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_domain_model.dart';
import 'package:ota/domain/car_rental/car_reservation/repositories/car_reservation_repository_impl.dart';
import 'package:ota/domain/car_rental/car_reservation/usecases/car_reservation_usecases.dart';

import '../../../../mocks/fixture_reader.dart';

class CarReservationUsecase implements CarReservationRepositoryImpl {
  @override
  CarReservationRemoteDataSource? carReservationRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, CarReservationScreenDomainData>> getCarReservationData(
      CarReservationDomainArgumentModel argument) async {
    Map<String, dynamic> map =
        json.decode(fixture("car_reservation/car_reservation.json"));
    CarReservationScreenDomainData sort =
        CarReservationScreenDomainData.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Car Reservation case group", () {
    test('Car Reservation case', () async {
      CarReservationUseCasesImpl();

      CarReservationUseCases carReservationUseCases =
          CarReservationUseCasesImpl(repository: CarReservationUsecase());
      CarReservationDomainArgumentModel argumentModel =
          CarReservationDomainArgumentModel(
        lastPrice: 2.0,
        refCode: "",
        rateKey: "",
        age: 2,
        carId: "",
        currency: "",
        includeDriver: "",
        pickupCounter: "",
        pickupDate: "",
        pickupLocationId: "",
        rentalType: "",
        residenceCountry: "",
        returnCounter: "",
        returnDate: "",
        returnLocationId: "",
        supplierId: "",
      );
      carReservationUseCases.getCarReservationData(argumentModel);
    });
  });
}
