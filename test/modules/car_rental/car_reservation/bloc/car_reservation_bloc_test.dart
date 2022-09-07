import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/car_rental/car_reservation/data_source/car_reservation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_argument_model.dart';
import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_domain_model.dart';
import 'package:ota/domain/car_rental/car_reservation/repositories/car_reservation_repository_impl.dart';
import 'package:ota/domain/car_rental/car_reservation/usecases/car_reservation_usecases.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_bloc.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';

import '../../../../mocks/fixture_reader.dart';

class CarReservationMockUseCase implements CarReservationRepositoryImpl {
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
  group("Car Reservation Bloc Test", () {
    CarReservationBloc carReservationBloc = CarReservationBloc();
    carReservationBloc.carReservationUseCases =
        CarReservationUseCasesImpl(repository: CarReservationMockUseCase());
    test("Testing Mock Data", () {
      carReservationBloc.saveCarReservationData(CarReservationViewArgumentModel(
        carId: "2",
        pickupLocationId: "MA05110001",
        returnLocationId: "MA05110001",
        pickupDate: Helpers().parseDateTime("2021-12-12"),
        returnDate: Helpers().parseDateTime("2021-11-11"),
        supplierId: "MA2111000062",
        includeDriver: "false",
        currency: "THB",
        rentalType: "",
        pickupCounter: "",
        returnCounter: "",
        age: 25,
        rateKey: "eNqLVjI0U9KJNjaN1THUMTLQMTPQMdAxNokFAEBXBRw=",
        refCode: "CL213",
        lastPrice: 1000,
      ));
      expect(
          carReservationBloc.state.pageState, CarReservationPageState.loading);
    });

    test("Testing Mock Data", () {
      carReservationBloc.saveCarReservationData(null);
      expect(
          carReservationBloc.state.pageState, CarReservationPageState.failure);
    });
  });
}
