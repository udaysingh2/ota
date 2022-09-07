import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';

void main() {
  test('For class RemovePromoCodeArgumentDomain then', () {
    RemovePromoCodeArgumentDomain actual =
        RemovePromoCodeArgumentDomain(bookingUrn: 'bookingUrn');

    expect(actual.bookingUrn.isNotEmpty, true);
    expect(actual.bookingUrn, 'bookingUrn');
  });
}
