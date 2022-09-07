import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/room_gallery/view/gallery_details/hotel_room_gallery_detail_screen.dart';
import '../../../../helper/material_wrapper.dart';

void main() {
  group('Hitel room gallery detail Widget Test', () {
    testWidgets('initial page 0', (tester) async {
      Widget widget = getMaterialWrapper(const HotelRoomGalleryDetailScreen(
        imageList: [],
        initialPage: 0,
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });

    testWidgets('in itial page 1', (tester) async {
      Widget widget = getMaterialWrapper(const HotelRoomGalleryDetailScreen(
        imageList: [],
        initialPage: 1,
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });
  });
}
