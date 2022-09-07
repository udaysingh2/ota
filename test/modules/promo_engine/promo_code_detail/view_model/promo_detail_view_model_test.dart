import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/promo_engine/promo_code_detail/view_model/promo_detail_view_model.dart';

void main() {
  test('For class PromoDetailViewModel', () {
    PromoDetailViewModel viewModel = PromoDetailViewModel(
      removed: true,
      priceDetails: PriceDetails(
        orderPrice: 200.0,
        addonPrice: 200.0,
        totalAmount: 400.0,
      ),
    );

    expect(viewModel.removed, true);
    expect(viewModel.priceDetails != null, true);
    expect(viewModel.priceDetails?.totalAmount, 400.0);
  });
}
