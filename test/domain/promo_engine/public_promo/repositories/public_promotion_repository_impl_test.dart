import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/promo_engine/public_promo/data_source/public_promotiom_remote_data_source.dart';
import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/repositories/public_promotion_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class MockedPublicPromoCodeDataSource extends PublicPromotionRemoteDataSource {
  @override
  Future<PublicPromotionModelDomain> getPublicPromotionData(
      PublicPromotionArgumentDomain argumentDomain) async {
    Map<String, dynamic> map =
        json.decode(fixture("promo_engine/public_promo_code_mock.json"));
    return Future.value(PublicPromotionModelDomain.fromMap(map));
  }
}

class MockedPublicPromoCodeDataSourceException
    extends PublicPromotionRemoteDataSource {
  @override
  Future<PublicPromotionModelDomain> getPublicPromotionData(
      PublicPromotionArgumentDomain argumentDomain) async {
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
  group('Public PromoCode Repository group test', () {
    test('Public Promo code repositories test for internet success', () async {
      PublicPromotionRepositoryImpl();

      PublicPromotionRepositoryImpl repository = PublicPromotionRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedPublicPromoCodeDataSource(),
      );

      repository.getPublicPromotionData(
        PublicPromotionArgumentDomain(pagingOffset: 0, applicationKey: ''),
      );
    });

    test('Public Promo code repositories test for internet failure', () async {
      PublicPromotionRepositoryImpl();

      PublicPromotionRepository repository = PublicPromotionRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: MockedPublicPromoCodeDataSource(),
      );

      repository.getPublicPromotionData(
        PublicPromotionArgumentDomain(pagingOffset: 0, applicationKey: ''),
      );
    });

    test('Public Promo code repositories Exception test', () async {
      PublicPromotionRepositoryImpl();

      PublicPromotionRepositoryImpl.setMockInternet(
          InternetConnectionInfoMocked());

      PublicPromotionRepository repository = PublicPromotionRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedPublicPromoCodeDataSourceException(),
      );

      try {
        await repository.getPublicPromotionData(
          PublicPromotionArgumentDomain(pagingOffset: 0, applicationKey: ''),
        );
      } catch (error) {
        return (error);
      }
    });
  });
}
