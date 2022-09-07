import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';
import 'package:ota/domain/tours/ota_contact_information/use_cases/ota_update_customer_use_cases.dart';

import '../repositories/ota_update_customer_repository_impl_success_mock.dart';

void main() {
  OtaUpdateCustomerUseCases? customerUseCases;
  OtaUpdateCustomerDetailsArgumentDomain argument = OtaUpdateCustomerDetailsArgumentDomain(
      lastName: "Smith",
      firstName: "Steve"
  );
  setUpAll(() async {
    /// Code coverage for default implementation.
    customerUseCases = OtaUpdateCustomerUseCasesImpl();

    /// Code coverage for mock class
    customerUseCases =
        OtaUpdateCustomerUseCasesImpl(repository: OtaUpdateCustomerRepositoryImplSuccessMock());
  });

  test(
      'Ota Update Customer analytics usecases '
          'When calling updateCustomerUrlData '
          'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await customerUseCases!
        .updateCustomerDetails(argument);

    /// Get model from mock data.
    final OtaUpdateCustomerDetailsData model = consentResult!.right;

    /// Condition check for hotel value null
    expect(model.updateCustomerDetails != null, true);
  });

}
