import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/splash/models/splash_model.dart';
import 'package:ota/modules/splash/view_model/splash_model.dart';

void main() {
  test('Splash ViewModel class', () {
    final actual = getArguments();
    expect(actual.splashPageState, SplashPageState.splashImageLoaded);
  });
  test('Splash ViewModel class', () {
    final actual = SplashViewModel.mapFromSplashModel(arguments(),
        splashPageState: SplashPageState.empty);
    expect(actual.imgUrl?.isEmpty, true);
  });
}

SplashViewModel getArguments() {
  return SplashViewModel(
      imgUrl: "", splashPageState: SplashPageState.splashImageLoaded);
}

SplashModel arguments() {
  return SplashModel(
    getSplashScreen: GetSplashScreen(
      data: GetSplashScreenData(splashScreenUrl: ""),
    ),
  );
}
