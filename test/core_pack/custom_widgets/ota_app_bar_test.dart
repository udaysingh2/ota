import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';

import '../../helper/material_wrapper.dart';

void main() {
  testWidgets('ota app bar ...', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(OtaAppBar(
      title: 'Gallery',
      subTitle: 'sub title',
      actions: const [
        OtaAppBarAction.backButton,
        OtaAppBarAction.filterButton,
        OtaAppBarAction.closeButton,
      ],
      onLeftButtonPressed: () {},
    )));
    await tester.pumpAndSettle();
    expect(find.byType(AppBar), findsOneWidget);
  });
  testWidgets('ota app bar custom widget', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(OtaAppBar(
      title: 'Gallery',
      subTitleWidget: const Text(''),
      actions: const [
        OtaAppBarAction.backButton,
        OtaAppBarAction.filterButton,
        OtaAppBarAction.closeButton,
      ],
      onCloseButtonPressed: () {},
      onFilterButterPressed: () {},
    )));
    await tester.pumpAndSettle();
    expect(find.byType(AppBar), findsOneWidget);
  });
}
