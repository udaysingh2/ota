import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_ticket_playlist_card.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('tour playlist card ', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(const TourTicketPlaylistCard(
      promotionTextBottom: "test",
      imageUrl: "test",
      name: "test",
      promotionTextTop: "test",
      category: "test",
    )));
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsWidgets);
  });
}
