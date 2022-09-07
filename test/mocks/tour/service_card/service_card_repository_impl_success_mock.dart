import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/tours/service_card/repositories/service_card_repository_impl.dart';

import '../../fixture_reader.dart';

class ServiceCardRepositoryImplSuccessMock
    implements ServiceCardRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  ServiceCardRemoteDataSource? serviceCardRemoteDataSource;

  Future<Either<Failure, ServiceCardModelDomain>?> getTourServiceCards(
      ServiceCardModelDomain argument) async {
    String json = fixture("tour/service_card/service_card_mock.json");

    ///Convert into Model
    ServiceCardModelDomain model = ServiceCardModelDomain.fromJson(json);
    return Right(model);
  }

  @override
  Future<Either<Failure, ServiceCardModelDomain?>> getServiceCardData() {
    throw UnimplementedError();
  }
}
