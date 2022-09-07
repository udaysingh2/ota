import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/landing/service_card/data_sources/service_card_mock_data_source.dart';
import 'package:ota/domain/landing/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/landing/service_card/repositories/service_card_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class ServiceCardRemoteDataSourceFailureMock
    implements ServiceCardRemoteDataSource {
  @override
  Future<ServiceCardModelDomainData> getServiceCardData() {
    throw exp.ServerException(null);
  }
}

void main() {
  ServiceCardRepository? serviceCardRepositoryMock;
  ServiceCardRepository? serviceCardRepositoryInternetFailure;
  ServiceCardRepository? serviceCardRepositoryServerException;

  setUpAll(() async {
    /// Code coverage for default implementation.
    serviceCardRepositoryMock = ServiceCardRepositoryImpl();

    /// Code coverage for mock class
    serviceCardRepositoryMock = ServiceCardRepositoryImpl(
        remoteDataSource: ServiceCardMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    serviceCardRepositoryServerException = ServiceCardRepositoryImpl(
        remoteDataSource: ServiceCardRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    serviceCardRepositoryInternetFailure = ServiceCardRepositoryImpl(
        remoteDataSource: ServiceCardRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Hotel landing dynamic playlist Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await serviceCardRepositoryMock!.getServiceCard();

    /// Get model from mock data.
    final ServiceCardModelDomainData? bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData?.getServiceCard != null, true);
  });

  test(
      'hotel Dynamic Playlist Repository Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await serviceCardRepositoryInternetFailure!.getServiceCard();

    expect(result.isLeft, true);
  });

  test(
      'hotel Dynamic Playlist Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await serviceCardRepositoryServerException!.getServiceCard();

    expect(result.isLeft, true);
  });
}
