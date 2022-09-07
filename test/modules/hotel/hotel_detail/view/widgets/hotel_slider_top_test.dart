import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/status_bar_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_controller.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_slider_top.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Hotel Slider Top Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      HotelSliderTop(
        statusBarBloc: StatusBarBloc(),
        statusBarTitle: "",
        heartButtonController: HeartButtonController(),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(AnimatedSwitcher), findsNWidgets(4));
    expect(find.byType(AnimatedOpacity), findsOneWidget);
  });
}
