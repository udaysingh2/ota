import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/splash/bloc/splash_bloc.dart';
import 'package:ota/modules/splash/view_model/splash_model.dart';

void main() {
  test("Splash Bloc", () {
    SplashBloc splashBloc = SplashBloc();
    splashBloc.state.splashPageState = SplashPageState.empty;
    expect(splashBloc.state.splashPageState, SplashPageState.empty);
    splashBloc.getSplashData();
  });
}
