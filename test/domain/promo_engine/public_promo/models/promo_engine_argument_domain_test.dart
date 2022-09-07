import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';

void main() {
  test('For class RemovePromoCodeArgumentDomain then', () {
    PublicPromotionArgumentDomain actual =
        PublicPromotionArgumentDomain(pagingOffset: 0, applicationKey: '');

    expect(actual.applicationKey.isNotEmpty, false);
    expect(actual.applicationKey, '');
  });
}
