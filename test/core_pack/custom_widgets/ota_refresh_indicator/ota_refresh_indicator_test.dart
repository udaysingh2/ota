import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';

import '../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ota Refresh Indicator ...', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(OtaRefreshIndicator(
      onRefresh: () async {},
      child: Container(),
    )));
    await tester.pumpAndSettle();
  });
  testWidgets('Ota Refresh Indicator With Text ...', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(OtaRefreshIndicator(
      onRefresh: () async {},
      text: const Text("hello"),
      child: Container(),
    )));
    await tester.pumpAndSettle();
  });

  testWidgets('Ota Refresh With Mode  and SCroll...', (tester) async {
    ScrollController scrollController = ScrollController();
    GlobalKey<OtaRefreshIndicatorState> state = GlobalKey();
    OtaRefreshIndicator ota = OtaRefreshIndicator(
      onRefresh: () async {},
      color: Colors.white,
      text: const Text("hello"),
      key: state,
      child: ListView.builder(
        controller: scrollController,
        key: const Key("listKey"),
        itemBuilder: (context, index) {
          return const SizedBox(
            height: 100,
            width: 200,
          );
        },
        itemCount: 100,
      ),
    );
    await tester.pumpWidget(getMaterialWrapper(SizedBox(
      height: 200,
      width: 200,
      child: ota,
    )));
    await tester.pumpAndSettle();
    scrollController.animateTo(20,
        duration: const Duration(milliseconds: 1), curve: Curves.ease);
    await tester.pumpAndSettle();
    scrollController.animateTo(-100,
        duration: const Duration(milliseconds: 1), curve: Curves.ease);
    await tester.pumpAndSettle();
    state.currentState?.show(atTop: true);
    await tester.pumpAndSettle();
    state.currentState?.didUpdateWidget(state.currentState?.widget ??
        OtaRefreshIndicator(
            color: Colors.red, onRefresh: () async {}, child: Container()));
    await tester.pumpAndSettle();
    await tester.drag(find.byKey(const Key("listKey")), const Offset(0, -100));
    await tester.pumpAndSettle();
    await tester.drag(find.byKey(const Key("listKey")), const Offset(0, 100));
    await tester.pumpAndSettle();
    await tester.drag(find.byKey(const Key("listKey")), const Offset(100, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byKey(const Key("listKey")), const Offset(-100, 0));
    await tester.pumpAndSettle();
  });
}
