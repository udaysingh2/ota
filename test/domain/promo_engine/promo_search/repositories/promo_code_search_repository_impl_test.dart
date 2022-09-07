import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/promo_engine/promo_search/data_sources/promo_code_search_remote_data_source.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/repositories/promo_code_search_repository_impl.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/repositories/remove_promo_code_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class MockedPromoCodeSearchDataSource extends PromoCodeSearchRemoteDataSource {
  @override
  Future<PromoCodeSearchModelDomain> searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain) async {
    Map<String, dynamic> map =
        json.decode(fixture("promo_engine/promo_code_search_mock.json"));
    return Future.value(PromoCodeSearchModelDomain.fromMap(map));
  }
}

class MockedPromoCodeSearchDataSourceException
    extends PromoCodeSearchRemoteDataSource {
  @override
  Future<PromoCodeSearchModelDomain> searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain) {
    throw Future.value(Exception());
  }
}

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

void main() {
  group('Search PromoCode Repository group test', () {
    test('Search Promo code repositories test for internet success', () async {
      RemovePromoCodeRepositoryImpl();

      PromoCodeSearchRepository repository = PromoCodeSearchRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedPromoCodeSearchDataSource(),
      );

      repository.searchPromoCode(
        PromoCodeArgumentDomain(applicationKey: 'applicationKey'),
      );
    });

    test('Promo code Search repositories test for internet failure', () async {
      PromoCodeSearchRepositoryImpl();

      PromoCodeSearchRepository repository = PromoCodeSearchRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: MockedPromoCodeSearchDataSource(),
      );

      repository.searchPromoCode(
        PromoCodeArgumentDomain(applicationKey: 'applicationKey'),
      );
    });

    test('Remove Promo code repositories Exception test', () async {
      PromoCodeSearchRepositoryImpl();

      RemovePromoCodeRepositoryImpl.setMockInternet(
          InternetConnectionInfoMocked());

      PromoCodeSearchRepository repository = PromoCodeSearchRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedPromoCodeSearchDataSourceException(),
      );

      try {
        await repository.searchPromoCode(
          PromoCodeArgumentDomain(applicationKey: 'applicationKey'),
        );
      } catch (error) {
        return (error);
      }
    });
  });
}
