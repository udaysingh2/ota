import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/bloc/status_bar_bloc.dart';
import 'package:ota/modules/landing/view/widgets/landing_sliders_tip.dart';

import '../../../../helper.dart';

void main() {
  testWidgets('Landing Slider Tip test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    StatusBarBloc statusBarBloc = StatusBarBloc();
    Widget widget = getMaterialWrapper(
      LandingSlidersTip(
        statusBarBloc: statusBarBloc,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsWidgets);
  });
}
