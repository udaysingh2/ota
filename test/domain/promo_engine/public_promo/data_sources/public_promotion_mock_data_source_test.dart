import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/promo_engine/public_promo/data_source/public_promotiom_remote_data_source.dart';
import 'package:ota/domain/promo_engine/public_promo/data_source/public_promotion_mock_data_source.dart';
import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  test(
      'For class PublicPromotionMockDataSourceImpl ==> getPublicPromotionData Test',
      () async {
    PublicPromotionRemoteDataSource dataSource =
        PublicPromotionMockDataSourceImpl();

    final result = await dataSource.getPublicPromotionData(args());

    expect(result, isA<PublicPromotionModelDomain>());
  });
}

PublicPromotionArgumentDomain args() =>
    PublicPromotionArgumentDomain(pagingOffset: 0, applicationKey: '');
