import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/insurance/data_source/insurance_mock_data_source.dart';
import 'package:ota/domain/insurance/models/insurance_argument_domain.dart';
import 'package:ota/domain/insurance/models/insurance_model_domain.dart';
import 'package:ota/domain/insurance/repositories/insurance_repository.dart';
import 'package:ota/domain/insurance/usecases/insurance_usecases.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  InsuranceUseCases? insuranceUseCases;
  InsuranceArgumentDomain insuranceArgumentDomain =
      InsuranceArgumentDomain(limit: 0, offset: 0, recommendedServices: "");
  setUpAll(() async {
    insuranceUseCases = InsuranceUseCasesImpl(
        repository: InsuranceRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: InsuranceMockDataSourceImpl()));
  });
  test('Insurance UseCases ', () async {
    /// Consent user cases impl
    final insuranceResult =
        await insuranceUseCases?.getInsuranceData(insuranceArgumentDomain);

    /// Get model from mock data.
    final InsuranceModelDomain model = insuranceResult!.right;

    expect(model.getInsurance != null, true);
  });
}
