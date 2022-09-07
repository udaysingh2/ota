import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/insurance/models/insurance_argument_domain.dart';
import 'package:ota/domain/insurance/models/insurance_model_domain.dart';
import 'package:ota/domain/insurance/repositories/insurance_repository.dart';

abstract class InsuranceUseCases {
  Future<Either<Failure, InsuranceModelDomain>?> getInsuranceData(
      InsuranceArgumentDomain argumentModel);
}

class InsuranceUseCasesImpl implements InsuranceUseCases {
  InsuranceRepository? insuranceRepository;

  InsuranceUseCasesImpl({InsuranceRepository? repository}) {
    if (repository == null) {
      insuranceRepository = InsuranceRepositoryImpl();
    } else {
      insuranceRepository = repository;
    }
  }

  @override
  Future<Either<Failure, InsuranceModelDomain>?> getInsuranceData(
      InsuranceArgumentDomain argumentModel) async {
    return await insuranceRepository?.getInsuranceData(argumentModel);
  }
}
