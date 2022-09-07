import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_back_button.dart';
import 'package:ota/modules/landing/bloc/status_bar_bloc.dart';
import 'package:ota/modules/landing/view/widgets/landing_top_bar_widget.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Landing Top Bar Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      LandingTopBar(
        statusBarBloc: StatusBarBloc(),
        key: const Key(""),
        onSearchTap: () {},
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsWidgets);
    await tester.tap(find.byType(OtaBackButton));
    await tester.pump();
  });

  testWidgets('Landing Top Bar Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    StatusBarBloc statusBarBloc = StatusBarBloc();
    statusBarBloc.state.statusBarBlocState = StatusBarBlocState.closing;
    Widget widget = getMaterialWrapper(
      LandingTopBar(
        statusBarBloc: statusBarBloc,
        key: const Key(""),
        onSearchTap: () {},
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsWidgets);
  });
}
