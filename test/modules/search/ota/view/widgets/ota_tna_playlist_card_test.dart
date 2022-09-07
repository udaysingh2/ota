import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota/view/widgets/ota_tna_playlist_card.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';

import '../../../../../helper.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Ota TNA Playlist Card', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(OtaTnaPlaylistCard(
      name: 'name',
      promotionTextBottom: 'promotionTextBottom',
      promotionTextTop: 'promotionTextTop',
      cityName: 'cityName',
      category: 'category',
      price: 0.0,
      currency: 'currency',
      capsulePromotion: [TnaCapsulePromotion(name: 'promo', code: 'code')],
    )));
    await tester.pumpAndSettle();
  });
  testWidgets('Ota Amenities Widget Test true defaultSvg', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(const OtaTnaPlaylistCard(
      imageUrl: 'assets/images/icons/tour_icon.svg',
      name: 'name',
      promotionTextBottom: 'promotionTextBottom',
      promotionTextTop: 'promotionTextTop',
      location: 'location',
      cityName: 'cityName',
      price: 0.0,
      playlistType: PlaylistType.ticket,
      currency: 'currency',
    )));
    await tester.pumpAndSettle();
  });
}
