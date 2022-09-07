import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_widget_controller.dart';
import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_widget_model.dart';

void main() {
  group("Fab Widget Controller Test", () {
    test('Fab Widget Controller Test Collaped', () {
      FabWidgetController fabWidgetController = FabWidgetController();

      fabWidgetController.setCollapsed();
      expect(
          fabWidgetController.state.fabWidgetState, FabWidgetState.collapsed);
      expect(fabWidgetController.getState(), FabWidgetState.collapsed);
    });
    test('Fab Widget Controller Test Expanded', () {
      FabWidgetController fabWidgetController = FabWidgetController();

      fabWidgetController.setExpanded();

      expect(
          fabWidgetController.state.fabWidgetState, FabWidgetState.isExpanded);
      expect(fabWidgetController.getState(), FabWidgetState.isExpanded);
    });
    test('Fab Widget Controller Bool Test', () {
      FabWidgetController fabWidgetController = FabWidgetController();

      bool isExpanded = fabWidgetController.isExpanded();

      expect(isExpanded, false);
    });
    test('Fab Widget Controller Test Collapsed', () {
      FabWidgetController fabWidgetController = FabWidgetController();

      fabWidgetController.notExpanded();
      expect(
          fabWidgetController.state.fabWidgetState, FabWidgetState.collapsed);
    });
  });
}
