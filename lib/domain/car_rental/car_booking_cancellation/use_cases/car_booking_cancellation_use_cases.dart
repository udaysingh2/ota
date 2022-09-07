import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/models/car_booking_cancellation_model.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/repositories/car_booking_cancellation_repository_impl.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';

abstract class CarBookingCancellationUseCases {
  Future<Either<Failure, CarBookingCancellationModelDomain>?>
      getCarBookingCancellationData(CarBookingCancellationArgument argument);
}

class CarBookingCancellationUseCasesImpl
    implements CarBookingCancellationUseCases {
  CarBookingCancellationRepository? carBookingCancellationRepository;

  CarBookingCancellationUseCasesImpl(
      {CarBookingCancellationRepository? repository}) {
    if (repository == null) {
      carBookingCancellationRepository = CarBookingCancellationRepositoryImpl();
    } else {
      carBookingCancellationRepository = repository;
    }
  }

  @override
  Future<Either<Failure, CarBookingCancellationModelDomain>?>
      getCarBookingCancellationData(
          CarBookingCancellationArgument argument) async {
    return await carBookingCancellationRepository
        ?.getCarBookingCancellationData(argument);
  }
}
