import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/promo_engine/promo_code_detail/view_model/promo_detail_model_argument.dart';

void main() {
  test('For Model class PromoDetailModelArgument', () {
    PromoDetailModelArgument argument = PromoDetailModelArgument(
      isPromoCodeAvailable: true,
      isInternetAvailable: true,
      webViewUrl: '',
    );

    expect(argument.webViewUrl?.isEmpty, true);
    expect(argument.isInternetAvailable, true);
    expect(argument.isPromoCodeAvailable, true);
  });
}
