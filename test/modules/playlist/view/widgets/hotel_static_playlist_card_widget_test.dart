import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/playlist/view/widgets/hotel_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view_model/hotel_vertical_card_view_model.dart';

import '../../../../helper.dart';

void main() {
  testWidgets('HotelStaticPlaylistCard Widget true...', (tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(HotelStaticPlaylistCard(
      model: HotelVerticalCardViewModel(
        id: '1',
        name: 'name',
        locationName: 'locationName',
        capsulePromotion: [
          HotelVerticalCardPromotions(name: 'name', code: 'code')
        ],
        promotionTextLine1: 'promotionTextLine1',
        promotionTextLine2: 'promotionTextLine2',
      ),
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets('CarStaticPlaylistCard Widget false...', (tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      HotelStaticPlaylistCard(
        isInHorizontalScroll: false,
        model: HotelVerticalCardViewModel(
          capsulePromotion: [
            HotelVerticalCardPromotions(name: 'name', code: 'code')
          ],
          id: '1',
          name: 'name',
          rating: 1,
          locationName: 'locationName',
          promotionTextLine1: 'promotionTextLine1',
          promotionTextLine2: 'promotionTextLine2',
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
