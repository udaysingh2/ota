import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/landing/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/landing/service_card/repositories/service_card_repository_impl.dart';
import 'package:ota/domain/landing/service_card/usecases/service_card_usecases.dart';

import '../../../mocks/fixture_reader.dart';

class ServiceCardUsecase implements ServiceCardRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  ServiceCardRemoteDataSource? serviceCardRemoteDataSource;

  @override
  Future<Either<Failure, ServiceCardModelDomainData?>> getServiceCard() async {
    Map<String, dynamic> map =
        json.decode(fixture("service_card/service_card.json"));
    ServiceCardModelDomainData sort = ServiceCardModelDomainData.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Service Card case group", () {
    test('Service card Use case', () async {
      ServiceCardUseCasesImpl();
      ServiceCardUseCases serviceCardUseCases =
          ServiceCardUseCasesImpl(repository: ServiceCardUsecase());
      serviceCardUseCases.getServiceCard();
    });
  });
}
