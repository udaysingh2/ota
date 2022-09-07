import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/contact_information/data_sources/update_customer_mock.dart';
import 'package:ota/domain/contact_information/models/update_customer_details_model.dart';
import 'package:ota/domain/contact_information/repositories/update_customer_repository_impl.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/view_model/contact_information_argument_model.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/update_customer_argument_mock.dart';
import '../repositories/update_customer_failure_data_source.dart';

void main() {
  UpdateCustomerRepository? updateCustomerRepositoryServerException;
  UpdateCustomerRepository? updateCustomerRepositoryMock;
  UpdateCustomerRepository? updateCustomerRepositoryInternetFailure;
  ContactInformationArgumentData contactInformationArgumentData =
      getContactInformationArgumentData();
  setUpAll(() async {
    /// Code coverage for default implementation.
    updateCustomerRepositoryMock = UpdateCustomerRepositoryImpl();

    /// Code coverage for mock class
    updateCustomerRepositoryMock = UpdateCustomerRepositoryImpl(
        remoteDataSource: UpdateCustomerMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    updateCustomerRepositoryServerException = UpdateCustomerRepositoryImpl(
        remoteDataSource: UpdateCustomerServerFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    updateCustomerRepositoryInternetFailure = UpdateCustomerRepositoryImpl(
        remoteDataSource: UpdateCustomerMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Message Repository analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResultNews = await updateCustomerRepositoryMock!
        .updateCustomerData(contactInformationArgumentData);

    /// Get model from mock data.
    final UpdateCustomerData customerData = consentResultNews.right;

    /// Condition check for hotel value null
    expect(customerData.updateCustomerDetails != null, false);
  });

  test(
      'Message And Notification analytics Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResultNews = await updateCustomerRepositoryInternetFailure!
        .updateCustomerData(contactInformationArgumentData);

    expect(consentResultNews.isLeft, true);
  });

  test(
      'Hotel Booking List analytics Repository '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResultNews = await updateCustomerRepositoryServerException!
        .updateCustomerData(contactInformationArgumentData);

    expect(consentResultNews.isLeft, true);
  });
}
