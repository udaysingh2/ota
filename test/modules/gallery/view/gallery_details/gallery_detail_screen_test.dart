import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/gallery/view/gallery_details/gallery_detail_screen.dart';
import 'package:ota/modules/gallery/view_model/gallery_view_model.dart';
import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('gallery detail screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(GalleryDetailScreen(
      imageList: [
        GalleryViewModel(
          imageUrl:
              'https://manage.robinhood.in.th/ImageData/Hotel/amora_neoluxe_bangkok-room2.jpg',
        ),
      ],
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    await tester.tap(find.byType(IconButton));
  });
}
