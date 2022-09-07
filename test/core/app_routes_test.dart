import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/core/app_routes.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  test('App routers listing', () {
    final routers = AppRoutes.getRoutes().values.toList();

    for (var i = 0; i < routers.length; i++) {
      // expect(routers[i] is WidgetBuilder, true);
      Widget Function(BuildContext context) test = routers[i];
      test(MockBuildContext());
    }
  });
}
