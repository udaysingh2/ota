import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_landing_scroll_state_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_landing_place_holder.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Hotel Landing App Bar Test...', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(HotelLandingPlaceHolder(
      hotelLandingScrollStateBloc: HotelLandingScrollStateBloc(),
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.pump();
  });
}
