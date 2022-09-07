import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/tours/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';

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
