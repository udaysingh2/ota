import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';
import 'package:ota/domain/tours/ota_contact_information/repositories/ota_update_customer_repository_impl.dart';

import '../../../../modules/hotel/repositories/Internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/Internet_success_mock.dart';
import '../repositories/ota_update_customer_remote_datasource_failure_mock.dart';
import '../repositories/ota_update_customer_remote_datasource_success_mock.dart';

void main() {
  OtaUpdateCustomerRepository? customerRepositoryServerException;
  OtaUpdateCustomerRepository? customerRepositoryMock;
  OtaUpdateCustomerRepository? customerRepositoryInternetFailure;
  OtaUpdateCustomerDetailsArgumentDomain argument = OtaUpdateCustomerDetailsArgumentDomain(
      lastName: "Smith",
      firstName: "Steve"
  );

  setUpAll(() async {
    /// Code coverage for default implementation.
    customerRepositoryMock = OtaUpdateCustomerRepositoryImpl();

    /// Code coverage for mock class
    customerRepositoryMock = OtaUpdateCustomerRepositoryImpl(
        remoteDataSource: OtaUpdateCustomerRepositoryImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    customerRepositoryServerException = OtaUpdateCustomerRepositoryImpl(
        remoteDataSource: OtaUpdateCustomerRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    customerRepositoryInternetFailure = OtaUpdateCustomerRepositoryImpl(
        remoteDataSource: OtaUpdateCustomerRepositoryImplSuccessMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Ota Update Customer Repository '
          'When calling update customer ResultModelUrlData '
          'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
    await customerRepositoryMock!.updateCustomerDetails(argument);

    /// Get model from mock data.
    final OtaUpdateCustomerDetailsData model = consentResult.right;

    /// Condition check for hotel value null
    expect(model.updateCustomerDetails != null, true);
  });

  test(
      'Ota Update Customer Repository '
          'When calling update customer ResultModelUrlData'
          'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await customerRepositoryInternetFailure!
        .updateCustomerDetails(argument);

    expect(consentResult.isLeft, true);
  });

  test(
      'Ota Update Customer Repository '
          'When calling update customer ResultModelUrlData'
          'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResult = await customerRepositoryServerException!
        .updateCustomerDetails(argument);

    expect(consentResult.isLeft, true);
  });
}
