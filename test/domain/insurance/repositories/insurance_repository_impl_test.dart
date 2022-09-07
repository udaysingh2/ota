import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/insurance/data_source/insurance_data_source.dart';
import 'package:ota/domain/insurance/data_source/insurance_mock_data_source.dart';
import 'package:ota/domain/insurance/models/insurance_argument_domain.dart';
import 'package:ota/domain/insurance/models/insurance_model_domain.dart';
import 'package:ota/domain/insurance/repositories/insurance_repository.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class InsuranceDataSourceFailureMock implements InsuranceRemoteDataSource {
  Future<InsuranceModelDomain> getPromoCards(InsuranceModelDomain argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<InsuranceModelDomain> getInsuranceData(
      InsuranceArgumentDomain argumentModel) {
    throw UnimplementedError();
  }
}

void main() {
  InsuranceRepository? insuranceRepositoryMock;
  InsuranceRepository? insuranceRepositoryServerException;
  InsuranceArgumentDomain argument =
      InsuranceArgumentDomain(limit: 0, offset: 0, recommendedServices: "");

  setUpAll(() async {
    insuranceRepositoryMock = InsuranceRepositoryImpl();

    insuranceRepositoryMock = InsuranceRepositoryImpl(
        remoteDataSource: InsuranceMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    insuranceRepositoryServerException = InsuranceRepositoryImpl(
        remoteDataSource: InsuranceMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test("Insurance Repository" 'With Success response', () async {
    final result = await insuranceRepositoryMock!.getInsuranceData(argument);
    final insuranceData = result.right;
    expect(insuranceData.getInsurance == null, false);
  });

  test("Insurance Repository" 'With Server Exception response data', () async {
    final result =
        await insuranceRepositoryServerException!.getInsuranceData(argument);
    expect(result.isLeft, true);
  });
}
