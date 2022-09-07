import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/modules/playlist/view/widgets/category_list/horizontal_category_list.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('horizontal category list ...', (tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(HorizontalCategoryList(
      categories: const [
        'Category 1',
        'Category 2',
        'Category 3',
        'Category 4',
        'Category 5'
      ],
      onCategorySelected: (value) {},
      onCategorySelectedIndex: (index) {},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("ota_button")).first);
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(OtaChipButton), findsNWidgets(5));
  });
}
