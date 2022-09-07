import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_reservation/data_source/car_reservation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_argument_model.dart';
import 'package:ota/domain/car_rental/car_reservation/repositories/car_reservation_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/car_reservation_impl_success_mock.dart';

void main() {
  GraphQlResponse graphQlResponsePlayList = MockCarReservationStatusGraphQl();

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

  CarReservationRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
  CarReservationRepository carReservationRepository =
      CarReservationRepositoryImpl(
    internetInfo: InternetSuccessMock(),
    remoteDataSource: CarReservationRemoteDataSourceImpl(),
  );

  test("car reservation Data Source", () {
    CarReservationRemoteDataSource carReservationRemoteDataSource =
        CarReservationRemoteDataSourceImpl();

    CarReservationRemoteDataSourceImpl.setMock(graphQlResponsePlayList);

    carReservationRemoteDataSource.getCarReservationData(argumentModel);
  });
  test(
      'car reservation  Repository '
      'When calling get car reservation data '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult =
        await carReservationRepository.getCarReservationData(argumentModel);

    expect(consentResult.isRight, true);
  });
}
