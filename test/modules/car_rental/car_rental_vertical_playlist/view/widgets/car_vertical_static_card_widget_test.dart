import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view/widgets/car_vertical_static_card_widget.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view_model/car_rental_vertical_view_model.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Car vertical static card ', (tester) async {
    CarVerticalList model = CarVerticalList(
        capsulePromotion: [CapsulePromotionModel(name: "name", code: "name")],
        brandId: 1,
        brandName: "brandName",
        carId: 2,
        carInfo: CarVerticalInfo(carTypeId: 3, carTypeName: "carTypeName"),
        images: ImagesModel(full: "full", thumb: "thumb"),
        modelName: "modelName",
        overlayPromotion: OverlayPromotionModel(
            adminPromotionLine2: "line2", adminPromotionLine1: "line1"),
        suppliers: [
          SupplierModel(
              pickupCounter: CounterModel(
                  name: "name",
                  address: "address",
                  description: "description",
                  locationId: "locationId"),
              returnCounter: CounterModel(
                  name: "name",
                  address: "address",
                  description: "description",
                  locationId: "locationId"))
        ]);
    await tester.pumpWidget(getMaterialWrapper(CarVerticalStaticPlaylistCard(
      model: model,
      onPress: () {},
      isInHorizontalScroll: false,
    )));
    await tester.pumpAndSettle();
    expect(find.byType(InkWell), findsOneWidget);
  });
}
