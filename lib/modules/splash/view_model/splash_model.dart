import 'package:ota/domain/splash/models/splash_model.dart';

class SplashViewModel {
  String? imgUrl;
  SplashPageState? splashPageState;

  ///Default Constructor
  SplashViewModel({this.imgUrl, this.splashPageState = SplashPageState.empty});

  ///Constructor That is used to map from the Domain level Model.
  SplashViewModel.mapFromSplashModel(SplashModel splashModel,
      {this.splashPageState = SplashPageState.empty}) {
    imgUrl = splashModel.getSplashScreen?.data?.splashScreenUrl;
  }
}

///SplashPageState will maintain the state of splash screen
enum SplashPageState {
  empty,
  loading,
  splashImageLoaded,
  failure,
  splashImageNotAvailable
}
