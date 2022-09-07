import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view/widgets/service_card_widget.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Service Card Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(const ServiceCardWidget(
      footerText: '',
      headerText: '',
      imageUrl: '',
      width: 100,
      serviceViewModelService: ServiceViewModelService.hotel,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Column), findsWidgets);
  });
}
