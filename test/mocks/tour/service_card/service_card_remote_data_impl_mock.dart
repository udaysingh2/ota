import 'package:ota/domain/tours/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

class ServiceCardRemoteDataSourceImplSuccessMock
    implements ServiceCardRemoteDataSource {
  Future<ServiceCardModelDomain> getTourServiceCards(
      ServiceCardModelDomain argument) async {
    String json = fixture("tour/service_card/service_card_mock.json");

    ///Convert into Model
    ServiceCardModelDomain model = ServiceCardModelDomain.fromJson(json);
    return model;
  }

  @override
  Future<ServiceCardModelDomain> getServiceCardData() {
    throw UnimplementedError();
  }
}
