import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/modules/search/ota/view/widgets/otasearch_car_list_widget.dart';

import '../../../../../helper.dart';

CarModelList carModelList = CarModelList(
  carId: 1,
  brandId: 1,
  brandName: 'brandName',
  modelName: 'modelName',
  carInfo: CarInfo(carTypeName: 'carTypeName', carTypeId: 1),
);

void main() {
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('OTASearch Car list Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      OtaSearchHorizontalList(
        title: '',
        onCardClick: (carModelList) {},
        dataList: [
          CarModelList(
            overlayPromotion: OverlayPromotion(
                adminPromotionLine1: 'adminPromotionLine1',
                adminPromotionLine2: 'adminPromotionLine2'),
            carId: 1,
            brandId: 1,
            images: Images(
              full:
                  "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
              thumb:
                  "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
            ),
            brandName: 'brandName',
            modelName: 'modelName',
            capsulePromotion: [
              CapsulePromotion(code: 'code', name: 'name'),
              CapsulePromotion(code: 'code', name: 'name')
            ],
            carInfo: CarInfo(carTypeName: 'carTypeName', carTypeId: 1),
          )
        ],
      ),
    );
    await tester.runAsync(() async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });
  });
  testWidgets('OTASearch Car list Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      OtaSearchHorizontalList(
        title: '',
        onCardClick: (carModelList) {},
        dataList: [
          CarModelList(
            carId: 1,
            brandId: 1,
            images: Images(
              full:
                  "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
              thumb:
                  "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
            ),
            brandName: 'brandName',
            modelName: 'modelName',
            carInfo: CarInfo(carTypeName: 'carTypeName', carTypeId: 1),
          )
        ],
      ),
    );
    await tester.runAsync(() async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('CarListButton')));
      await tester.pump();
      await tester.pump();
      await tester.pump();
    });
  });
}
