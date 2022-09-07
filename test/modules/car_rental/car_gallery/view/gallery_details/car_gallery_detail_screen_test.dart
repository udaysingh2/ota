import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_gallery/view/gallery_details/car_gallery_detail_screen.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_view_model.dart';

import '../../../../../helper.dart';

const _kLeftIconKey = "left_icon";
const _kRightIconKey = "right_icon";

void main() {
  String imageUrl =
      'https://manage.robinhood.in.th/ImageData/Hotel/amora_neoluxe_bangkok-room2.jpg';
  String image2Url = '';
  testWidgets('car gallery detail screen ...', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(CarGalleryDetailScreen(
      imageList: [
        CarGalleryModel(thumb: imageUrl, full: imageUrl),
        CarGalleryModel(thumb: imageUrl, full: imageUrl),
        CarGalleryModel(thumb: imageUrl, full: imageUrl)
      ],
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(IconButton), findsWidgets);
    expect(find.byType(PageView), findsWidgets);
    expect(find.byKey(const Key(_kRightIconKey)), findsOneWidget);
    await tester.tap(find.byKey(const Key(_kRightIconKey)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key(_kLeftIconKey)));

    // await tester.pumpAndSettle();
  });

  testWidgets('car gallery detail screen failure', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(CarGalleryDetailScreen(
      imageList: [CarGalleryModel(thumb: image2Url, full: image2Url)],
      initialPage: 0,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
  });
}
