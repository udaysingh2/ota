import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/playlist/view/widgets/tour_ticket_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view_model/static_playlist_type.dart';
import 'package:ota/modules/playlist/view_model/tour_vertical_card_view_model.dart';

import '../../../../helper.dart';

void main() {
  testWidgets('TourTicketStaticPlaylistCard Widget true...', (tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(TourTicketStaticPlaylistCard(
      model: TourVerticalCardViewModel(
        id: '1',
        name: 'name',
        styleName: 'styleName',
        capsulePromotion: [
          TourVerticalCardPromotions(name: 'name', code: 'code')
        ],
        promotionTextLineOne: 'promotionTextLine1',
        promotionTextLineTwo: 'promotionTextLine2',
      ),
      playlistType: StaticPlaylistType.tour,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets('TourTicketStaticPlaylistCard Widget false...', (tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      TourTicketStaticPlaylistCard(
        isInHorizontalScroll: false,
        model: TourVerticalCardViewModel(
          capsulePromotion: [
            TourVerticalCardPromotions(name: 'name', code: 'code')
          ],
          id: '1',
          name: 'name',
          rating: 1,
          locationName: 'locationName',
          promotionTextLineOne: 'promotionTextLine1',
          promotionTextLineTwo: 'promotionTextLine2',
        ),
        playlistType: StaticPlaylistType.ticket,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
