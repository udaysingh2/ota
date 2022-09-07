import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/modules/landing/view/landing_page.dart';
import 'package:ota/modules/splash/view/splash_screen.dart';

class MockedBuildContext extends Mock implements BuildContext {}

void main() {
  MyNavigatorObserver myNavigatorObserver = MyNavigatorObserver();
  Route previousRoute = MaterialPageRoute(builder: (_) => const SplashScreen());
  Route route = MaterialPageRoute(builder: (_) => const LandingPage());

  test("Navigator Helper Test", () {
    MyNavigatorObserver.routeStack = [route, route];

    myNavigatorObserver.didPush(route, previousRoute);
    expect(MyNavigatorObserver.routeStack.length, 3);

    myNavigatorObserver.didReplace(newRoute: route, oldRoute: previousRoute);
    expect(MyNavigatorObserver.routeStack.length, 3);

    myNavigatorObserver.didRemove(route, previousRoute);
    expect(MyNavigatorObserver.routeStack.length, 2);

    myNavigatorObserver.didPop(route, previousRoute);
    expect(MyNavigatorObserver.routeStack.length, 1);
  });
}
