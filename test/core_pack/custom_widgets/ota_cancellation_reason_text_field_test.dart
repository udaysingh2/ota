import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_reason_text_field.dart';

import '../../helper/material_wrapper.dart';

void main() {
  testWidgets('ota cancellation reason text field ...', (tester) async {
    Widget widget = getMaterialWrapper(OtaCancellationTextField(
      hintText: 'Cancellation',
      textEditingController: TextEditingController(),
      textFormatter: '',
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
