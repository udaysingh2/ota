import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_room_promotion_widget/ota_promotion_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_room_promotion_widget/ota_room_special_promotion_widget.dart';

import '../../../helper.dart';

void main() {
  testWidgets('ota room special promotion widget', (tester) async {
    List<OtaPromotionModel> promoList = [
      OtaPromotionModel("header", "detail"),
    ];
    await tester.pumpWidget(getMaterialWrapper(OtaRoomSpecialPromotionWidget(
      header: "Special Promotion",
      specialPromotionList: promoList,
      bottomDetail:
          "*Terms and conditions of the promotion are subject to change without prior notice by the accommodation.",
    )));
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
