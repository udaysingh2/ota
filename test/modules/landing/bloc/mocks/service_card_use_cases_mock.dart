import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/landing/service_card/usecases/service_card_usecases.dart';

class ServiceCardUseCasesAllSuccessMock extends ServiceCardUseCasesImpl {
  @override
  Future<Either<Failure, ServiceCardModelDomainData?>?> getServiceCard() async {
    return Right(
      ServiceCardModelDomainData(
        getServiceCard: GetServiceCard(
          data: GetServiceCardData(),
        ),
      ),
    );
  }
}

class ServiceCardUseCasesDataNullMock extends ServiceCardUseCasesImpl {
  @override
  Future<Either<Failure, ServiceCardModelDomainData?>?> getServiceCard() async {
    return Right(
      ServiceCardModelDomainData(
        getServiceCard: GetServiceCard(
          data: null,
        ),
      ),
    );
  }
}

class ServiceCardUseCasesFailureMock extends ServiceCardUseCasesImpl {
  @override
  Future<Either<Failure, ServiceCardModelDomainData?>?> getServiceCard() async {
    return Left(
      InternetFailure(),
    );
  }
}
