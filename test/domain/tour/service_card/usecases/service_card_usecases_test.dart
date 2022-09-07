import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/service_card/data_sources/service_cards_remote_data_source_mock.dart';
import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/tours/service_card/repositories/service_card_repository_impl.dart';
import 'package:ota/domain/tours/service_card/usecases/service_card_usecases.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  ServiceCardUseCases? serviceCardUseCases;
  setUpAll(() async {
    serviceCardUseCases = ServiceCardUseCasesImpl(
        repository: ServiceCardRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: ServiceCardMockDataSourceImpl()));
  });
  test('Service Card UseCases ', () async {
    /// Consent user cases impl
    final serviceCardResult = await serviceCardUseCases!.getServiceCardData();

    /// Get model from mock data.
    final ServiceCardModelDomain? model = serviceCardResult!.right;

    expect(model!.getTourServiceCards != null, true);
  });
}
