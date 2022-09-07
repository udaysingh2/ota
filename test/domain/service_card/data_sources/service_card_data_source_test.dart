import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/landing/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/landing/service_card/repositories/service_card_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/service_card_impl_success_mock.dart';

void main() {
  GraphQlResponse graphQlResponsePlayList = MockServiceCardGraphQl();

  ServiceCardRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
  ServiceCardRepository serviceCardRepository = ServiceCardRepositoryImpl(
      remoteDataSource: ServiceCardRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());

  test("hotel landing dynamic Data Source", () {
    ServiceCardRemoteDataSource serviceCardRemoteDataSource =
        ServiceCardRemoteDataSourceImpl();
    ServiceCardRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
    serviceCardRemoteDataSource.getServiceCardData();
  });
  test(
      'service card Repository '
      'When calling service card '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult = await serviceCardRepository.getServiceCard();

    expect(consentResult.isRight, true);
  });
}
