import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/promo_engine/search_list/view/widgets/promo_code_tile_widget.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Promo Code Tile Widget Test ', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(PromoCodeTileWidget(
        promotion: PublicPromotion(
            promotionId: 1,
            promotionName: '',
            shortDescription: '',
            discount: 0,
            maximumDiscount: 0,
            discountType: '',
            discountFor: '',
            promotionLink: '',
            promotionType: '',
            iconUrl: '',
            voucherCode: '',
            promotionCode: '',
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            applicationKey: '')));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets('Promo Code Tile Widget Test with image url as null',
      (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(PromoCodeTileWidget(
        promotion: PublicPromotion(
            promotionId: 1,
            promotionName: '',
            shortDescription: '',
            discount: 0,
            maximumDiscount: 0,
            discountType: '',
            discountFor: '',
            promotionLink: '',
            promotionType: '',
            iconUrl: null,
            voucherCode: '',
            promotionCode: '',
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            applicationKey: '')));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
