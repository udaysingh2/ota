import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/contact_information/data_sources/update_customer_mock.dart';
import 'package:ota/domain/car_rental/contact_information/data_sources/update_customer_remote_data_source.dart';
import 'package:ota/domain/car_rental/contact_information/repositories/update_customer_repository_impl.dart';
import 'package:ota/modules/car_rental/contact_information/view_model/contact_information_argument_model.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/update_customer_argument_mock.dart';

void main() {
  GraphQlResponse graphQlResponseMessage = GraphQlResponseMock(
      result: jsonDecode(UpdateCustomerMockDataSourceImpl.getMockData()));
  UpdateCustomerRepository? updateCustomerRepository;

  UpdateCustomerRemoteDataSourceImpl.setMock(graphQlResponseMessage);
  updateCustomerRepository = UpdateCustomerRepositoryImpl(
      remoteDataSource: UpdateCustomerRemoteDataSourceImpl());
  ContactInformationArgumentData contactInformationArgumentData =
      getContactInformationArgumentData();

  /// Code coverage for mock class
  updateCustomerRepository = UpdateCustomerRepositoryImpl(
      remoteDataSource: UpdateCustomerRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Message And Notification Data Source", () {
    UpdateCustomerRemoteDataSource updateCustomerRemoteDataSource =
        UpdateCustomerRemoteDataSourceImpl();
    UpdateCustomerRemoteDataSourceImpl.setMock(graphQlResponseMessage);

    updateCustomerRemoteDataSource
        .updateCustomerData(contactInformationArgumentData);
  });
  test(
      'Message And Notification analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResultNews = await updateCustomerRepository!
        .updateCustomerData(contactInformationArgumentData);

    expect(consentResultNews.isLeft, false);
  });
}
