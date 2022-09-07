import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/playlist/view/widgets/car_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view_model/car_vertical_card_view_model.dart';

import '../../../../helper.dart';

void main() {
  testWidgets('CarStaticPlaylistCard Widget true...', (tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(CarStaticPlaylistCard(
      model: CarVerticalCardViewModel(
        id: '1',
        name: 'name',
        locationName: 'locationName',
        pickupLocationId: 'pickupLocationId',
        promotionTextLineOne: 'promotionTextLineOne',
        promotionTextLineTwo: 'promotionTextLineTwo',
      ),
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets('CarStaticPlaylistCard Widget false...', (tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      CarStaticPlaylistCard(
        isInHorizontalScroll: false,
        model: CarVerticalCardViewModel(
          capsulePromotion: [
            CarVerticalCardPromotions(name: 'name', code: 'code')
          ],
          id: '1',
          craftType: 'orSimilar',
          name: 'name',
          locationName: 'locationName',
          pickupLocationId: 'pickupLocationId',
          promotionTextLineOne: 'promotionTextLineOne',
          promotionTextLineTwo: 'promotionTextLineTwo',
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
