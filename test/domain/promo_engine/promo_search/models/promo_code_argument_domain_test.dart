import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';

void main() {
  test('For class PromoCodeArgumentDomain then', () {
    PromoCodeArgumentDomain actual =
    PromoCodeArgumentDomain(applicationKey: 'applicationKey');

    expect(actual.applicationKey.isNotEmpty, true);
    expect(actual.applicationKey, 'applicationKey');
  });
}
