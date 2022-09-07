import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_progress_indicator.dart';

import '../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ota CircularProgressIndicator  ...', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(const CircularProgressIndicator(
      value: 12,
    )));
    await tester.pump();
  });

  testWidgets('Ota OtaRefreshProgressIndicator  ...', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(const SizedBox(
      height: 200,
      width: 200,
      child: OtaRefreshProgressIndicator(
        value: 2,
        strokeWidth: 2,
      ),
    )));
    await tester.pump();
  });
  testWidgets('Ota CircularProgressIndicator  ...', (tester) async {
    await tester
        .pumpWidget(getMaterialWrapper(const CircularProgressIndicator.adaptive(
      value: 12,
    )));
    await tester.pump();
  });
}
