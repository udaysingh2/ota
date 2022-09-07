import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/landing/service_card/repositories/service_card_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class ServiceCardUseCases {
  Future<Either<Failure, ServiceCardModelDomainData?>?> getServiceCard();
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
  Future<Either<Failure, ServiceCardModelDomainData?>?> getServiceCard() async {
    return await serviceCardRepository?.getServiceCard();
  }
}
