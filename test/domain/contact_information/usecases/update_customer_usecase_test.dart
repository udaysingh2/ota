import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/contact_information/data_sources/update_customer_mock.dart';
import 'package:ota/domain/contact_information/models/update_customer_details_model.dart';
import 'package:ota/domain/contact_information/repositories/update_customer_repository_impl.dart';
import 'package:ota/domain/contact_information/use_cases/update_customer_use_cases.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/view_model/contact_information_argument_model.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/update_customer_argument_mock.dart';

void main() {
  ContactInformationArgumentData contactInformationArgumentData =
      getContactInformationArgumentData();
  UpdateCustomerUseCases? updateCustomerUseCases;
  setUpAll(() async {
    /// Code coverage for default implementation.
    updateCustomerUseCases = UpdateCustomerUseCasesImpl();

    /// Code coverage for mock class
    updateCustomerUseCases = UpdateCustomerUseCasesImpl(
        repository: UpdateCustomerRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: UpdateCustomerMockDataSourceImpl()));
  });

  test(
      'UpdateCustomer analytics usecases '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await updateCustomerUseCases!
        .updateCustomerData(contactInformationArgumentData);

    /// Get model from mock data.
    final UpdateCustomerData model = consentResult!.right;

    /// Condition check for notification Inquiry null
    expect(model.updateCustomerDetails != null, false);
  });
}
