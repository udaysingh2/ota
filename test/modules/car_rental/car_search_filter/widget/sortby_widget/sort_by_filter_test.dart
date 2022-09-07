import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/sortby_widget/sort_by_controllder.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/sortby_widget/sort_by_filter.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_view_model.dart';
import '../../../../../helper/material_wrapper.dart';

const String _kSortByAgreeKButtonKey = "sort_by_agree_button_key";

void main() {
  testWidgets('Sort By Filter Box Test', (WidgetTester tester) async {
    final SortByController sortByController = SortByController();
    Widget widget = getMaterialWrapper(
      SortByFilterBox(
        sortByController: sortByController,
        sortInfo: [
          CriterionModel(
            value: 'value 1',
            displayTitle: "Display Title 1",
          ),
          CriterionModel(
            value: 'value 2',
            displayTitle: "Display Title 2",
          ),
        ],
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });

  testWidgets(
    'Sort By Selection Box Test',
    (WidgetTester tester) async {
      final SortByController sortByController = SortByController();
      Widget widget = getMaterialWrapper(
        SortBySelectionSheet(
          sortByController: sortByController,
          sortInfo: [
            CriterionModel(
              value: 'value 1',
              displayTitle: "Display Title 1",
            ),
            CriterionModel(
              value: 'value 2',
              displayTitle: "Display Title 2",
            ),
          ],
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      sortByController.setInitialSort(
        CriterionModel(
          value: 'value 2',
          displayTitle: "Display Title 2",
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(OtaRadioButton).first);
      await tester.pumpAndSettle();
      sortByController.resetTemprorySort();
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaRadioButton).first);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key(_kSortByAgreeKButtonKey)));
      await tester.pumpAndSettle();
    },
  );
}
