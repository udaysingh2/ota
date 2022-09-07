import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/preferences/view/widgets/questionnaire_top_widget.dart';
import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Questionare Top Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(const QuestionnaireTopWidget(
      limit: 3,
      progress: 2,
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
