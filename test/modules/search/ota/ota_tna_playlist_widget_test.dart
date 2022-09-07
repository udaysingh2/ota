import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota/view/widgets/ota_tna_playlist_card.dart';
import 'package:ota/modules/search/ota/view/widgets/ota_tna_playlist_widget.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';

import '../../../helper.dart';

void main() {
  testWidgets("Widgets TNA playlist", (tester) async {
    Widget widget = getMaterialWrapper(
      const SingleChildScrollView(
        child: OtaTnaPlaylistWidget(
          playlistType: PlaylistType.tour,
          title: "tour",
          cardList: [],
        ),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets("Widgets TNA playlist card", (tester) async {
    Widget widget = getMaterialWrapper(
      const OtaTnaPlaylistCard(
        playlistType: PlaylistType.tour,
        name: "name",
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
