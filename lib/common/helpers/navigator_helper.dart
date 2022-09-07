import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ota/core_components/bloc/bloc.dart';

class NavigatorHelper {
  static shouldSystemPop(BuildContext context, {dynamic arguments}) {
    if (MyNavigatorObserver.routeStack.length > 2) {
      if (arguments == null) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context, arguments);
      }
      return;
    }
    if (arguments == null) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context, arguments);
    }
    SystemNavigator.pop();
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  static List<Route<dynamic>> routeStack = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.add(route);
    NavigatorCallbackBloc.shared.updateRoute(routeStack);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null) routeStack.removeLast();
    if (newRoute != null) routeStack.add(newRoute);
    NavigatorCallbackBloc.shared.updateRoute(routeStack);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
    NavigatorCallbackBloc.shared.updateRoute(routeStack);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
    NavigatorCallbackBloc.shared.updateRoute(routeStack);
  }
}

class NavigatorCallbackBloc extends Bloc<List<Route<dynamic>>> {
  NavigatorCallbackBloc._instance();
  static NavigatorCallbackBloc shared = NavigatorCallbackBloc._instance();

  @override
  List<Route> initDefaultValue() {
    return [];
  }

  factory NavigatorCallbackBloc() {
    return shared;
  }

  void updateRoute(List<Route<dynamic>> routes) {
    emit(routes.toList());
  }
}
