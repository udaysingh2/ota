import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_widget.dart';

void main() {
  TextEditingController textEditingController = TextEditingController();
  testWidgets('ota Text Input Widget test', (WidgetTester tester) async {
    // given selected state
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: OtaTextInputWidget(
          errorLabel: "errorLabel",
          backgroundColor: AppColors.kBlack1,
          errorText: "errortext",
          label: "label",
          padding: const EdgeInsets.all(kSize10),
          placeHolder: "Holder",
          textEditingController: textEditingController,
          state: OtaTextInputState.valid,
          textInputFormatter: const [],
        )),
      ),
    );
    await tester.pumpAndSettle();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
            body: OtaTextInputWidget(
          errorLabel: "errorLabel",
          backgroundColor: AppColors.kBlack1,
          errorText: "errortext",
          label: "label",
          padding: const EdgeInsets.all(kSize10),
          placeHolder: "Holder",
          textEditingController: textEditingController,
          state: OtaTextInputState.error,
          textInputFormatter: const [],
        )),
      ),
    );
    await tester.pumpAndSettle();
  });
}
