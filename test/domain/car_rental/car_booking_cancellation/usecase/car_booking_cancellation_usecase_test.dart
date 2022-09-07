import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/data_source/car_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/models/car_booking_cancellation_model.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/repositories/car_booking_cancellation_repository_impl.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/use_cases/car_booking_cancellation_use_cases.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';

import '../../../../mocks/fixture_reader.dart';

class CarBookinCancellationUsecase
    implements CarBookingCancellationRepositoryImpl {
  @override
  CarBookingCancellationRemoteDataSource?
      carBookingCancellationRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, CarBookingCancellationModelDomain>>
      getCarBookingCancellationData(
          CarBookingCancellationArgument argument) async {
    Map<String, dynamic> map =
        json.decode(fixture("car_reservation/car_reservation.json"));
    CarBookingCancellationModelDomain sort =
        CarBookingCancellationModelDomain.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Car Booking Cancellation case group", () {
    test('Car Booking Cancellation usecase', () async {
      CarBookingCancellationUseCasesImpl();

      CarBookingCancellationUseCases cancellationUseCases =
          CarBookingCancellationUseCasesImpl(
              repository: CarBookingCancellationRepositoryImpl());
      CarBookingCancellationArgument argumentModel =
          CarBookingCancellationArgument(confirmNo: '', reason: '');
      cancellationUseCases.getCarBookingCancellationData(argumentModel);
    });
  });
}
