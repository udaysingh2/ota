import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/tours/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/tours/service_card/data_sources/service_cards_remote_data_source_mock.dart';
import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/tours/service_card/repositories/service_card_repository_impl.dart';

import '../../../../modules/hotel/repositories/Internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/Internet_success_mock.dart';

class ServiceCardRemoteDataSourceFailureMock
    implements ServiceCardRemoteDataSource {
  Future<ServiceCardModelDomain> getTourServiceCards(
      ServiceCardModelDomain argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<ServiceCardModelDomain> getServiceCardData() {
    throw UnimplementedError();
  }
}

void main() {
  ServiceCardRepository? serviceCardRepositoryMock;
  ServiceCardRepository? serviceCardRepositoryServerException;

  setUpAll(() async {
    serviceCardRepositoryMock = ServiceCardRepositoryImpl();

    serviceCardRepositoryMock = ServiceCardRepositoryImpl(
        remoteDataSource: ServiceCardMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    serviceCardRepositoryServerException = ServiceCardRepositoryImpl(
        remoteDataSource: ServiceCardMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test("Service Card Repository" 'With Success response', () async {
    final result = await serviceCardRepositoryMock!.getServiceCardData();
    final ServiceCardModelDomain? serviceData = result.right;
    expect(serviceData!.getTourServiceCards != null, true);
  });

  test("Service Card Repository" 'With Server Exception response data',
      () async {
    final result =
        await serviceCardRepositoryServerException!.getServiceCardData();
    expect(result.isLeft, true);
  });
}
