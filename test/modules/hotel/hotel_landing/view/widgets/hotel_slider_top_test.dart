import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_landing_scroll_state_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_slider_top.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets("Hotel Recommendation Widget Test", (tester) async {
    Widget widget = getMaterialWrapper(HotelLandingSliderTop(
      statusBarTitle: 'title',
      hotelLandingScrollStateBloc: HotelLandingScrollStateBloc(),
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
