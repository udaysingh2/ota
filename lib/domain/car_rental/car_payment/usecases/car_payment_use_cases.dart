import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_payment/repositories/car_payment_repository_impl.dart';

import '../models/car_payment_argument_model.dart';
import '../models/car_payment_model_domain.dart';

abstract class CarPaymentUseCases {
  Future<Either<Failure, CarPaymentDomainModelData>?> getCarPaymentData(
      CarPaymentDomainArgumentModel argument);
}

class CarPaymentUseCasesImpl implements CarPaymentUseCases {
  CarPaymentRepository? carPaymentRepository;

  CarPaymentUseCasesImpl({CarPaymentRepository? repository}) {
    if (repository == null) {
      carPaymentRepository = CarPaymentRepositoryImpl();
    } else {
      carPaymentRepository = repository;
    }
  }

  @override
  Future<Either<Failure, CarPaymentDomainModelData>?> getCarPaymentData(
      CarPaymentDomainArgumentModel argument) async {
    return carPaymentRepository?.getCarPaymentData(argument);
  }
}
