import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import '../models/car_reservation_argument_model.dart';
import '../models/car_reservation_domain_model.dart';
import '../repositories/car_reservation_repository_impl.dart';

abstract class CarReservationUseCases {
  Future<Either<Failure, CarReservationScreenDomainData>?>
      getCarReservationData(CarReservationDomainArgumentModel argument);
}

/// CarReservationUseCasesImpl will contain the CarReservationUseCases implementation.
class CarReservationUseCasesImpl implements CarReservationUseCases {
  CarReservationRepository? carReservationRepository;

  /// Dependence injection via constructor
  CarReservationUseCasesImpl({CarReservationRepository? repository}) {
    if (repository == null) {
      carReservationRepository = CarReservationRepositoryImpl();
    } else {
      carReservationRepository = repository;
    }
  }

  @override
  Future<Either<Failure, CarReservationScreenDomainData>?>
      getCarReservationData(CarReservationDomainArgumentModel? argument) async {
    return await carReservationRepository?.getCarReservationData(argument!);
  }
}
