import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/tours/service_card/repositories/service_card_repository_impl.dart';

/// Interface for ServiceCard use cases.
abstract class ServiceCardUseCases {
  Future<Either<Failure, ServiceCardModelDomain?>?> getServiceCardData();
}

class ServiceCardUseCasesImpl implements ServiceCardUseCases {
  ServiceCardRepository? serviceCardRepository;

  /// Dependence injection via constructor
  ServiceCardUseCasesImpl({ServiceCardRepository? repository}) {
    if (repository == null) {
      serviceCardRepository = ServiceCardRepositoryImpl();
    } else {
      serviceCardRepository = repository;
    }
  }

  @override
  Future<Either<Failure, ServiceCardModelDomain?>?> getServiceCardData() async {
    return await serviceCardRepository?.getServiceCardData();
  }
}
