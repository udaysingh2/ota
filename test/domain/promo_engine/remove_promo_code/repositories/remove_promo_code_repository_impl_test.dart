import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/data_sources/remove_promo_code_remote_data_sources.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_model_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/repositories/remove_promo_code_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class MockedRemovePromoCodeDataSource extends RemovePromoCodeRemoteDataSource {
  @override
  Future<RemovePromoCodeModelDomain> removePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain) async {
    Map<String, dynamic> map =
        json.decode(fixture("promo_engine/remove_promo_code_mock.json"));
    return Future.value(RemovePromoCodeModelDomain.fromMap(map));
  }
}

class MockedRemovePromoCodeDataSourceException
    extends RemovePromoCodeRemoteDataSource {
  @override
  Future<RemovePromoCodeModelDomain> removePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain) async {
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
  group('Remove PromoCode Repository group test', () {
    test('Remove Promo code repositories test for internet success', () async {
      RemovePromoCodeRepositoryImpl();

      RemovePromoCodeRepository repository = RemovePromoCodeRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedRemovePromoCodeDataSource(),
      );

      repository.removePromoCodeData(
        RemovePromoCodeArgumentDomain(bookingUrn: 'bookingUrn'),
      );
    });

    test('Remove Promo code repositories test for internet failure', () async {
      RemovePromoCodeRepositoryImpl();

      RemovePromoCodeRepository repository = RemovePromoCodeRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: MockedRemovePromoCodeDataSource(),
      );

      repository.removePromoCodeData(
        RemovePromoCodeArgumentDomain(bookingUrn: 'bookingUrn'),
      );
    });

    test('Remove Promo code repositories Exception test', () async {
      RemovePromoCodeRepositoryImpl();

      RemovePromoCodeRepositoryImpl.setMockInternet(
          InternetConnectionInfoMocked());

      RemovePromoCodeRepository repository = RemovePromoCodeRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedRemovePromoCodeDataSourceException(),
      );

      try {
        await repository.removePromoCodeData(
          RemovePromoCodeArgumentDomain(bookingUrn: 'bookingUrn'),
        );
      } catch (error) {
        return (error);
      }
    });
  });
}
