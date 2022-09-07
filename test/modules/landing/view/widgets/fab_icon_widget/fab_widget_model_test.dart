import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_widget_model.dart';

void main() {
  group("FAB widget model", () {
    test('FAB widget model', () {
      FabWidgetModel fabWidgetModel =
          FabWidgetModel(fabWidgetState: FabWidgetState.collapsed);

      expect(fabWidgetModel.fabWidgetState, FabWidgetState.collapsed);
    });
  });
}
