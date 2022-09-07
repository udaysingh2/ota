import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/splash/models/splash_model.dart';
import 'package:ota/domain/splash/usecases/splash_use_cases.dart';
import 'package:ota/modules/splash/view_model/splash_model.dart';

///Rules
///* Bloc will not handle any Server errors. Refer domain section for error handling
///* Bloc will not have any Variables. Only way to access its value is BlocName.state.
///*
class SplashBloc extends Bloc<SplashViewModel> {
  @override
  SplashViewModel initDefaultValue() {
    ///Bloc should have default value
    ///To build the widget with default state
    return SplashViewModel();
  }

  ///Make An Api call.
  ///Update the state of the Splash Screen based on Response
  ///of the api.
  void getSplashData() async {
    ///Notify the Splash Screen that API call started and set the state as Loading.
    emit(SplashViewModel(splashPageState: SplashPageState.loading));

    ///Instantiate the UseCase responsible to get the splash data.
    SplashUseCases splashUseCasesImpl = SplashUseCasesImpl();

    ///Get The result Of for splash screen
    Either<Failure, SplashModel> result =
        (await splashUseCasesImpl.getSplashData())!;

    if (result.isRight) {
      SplashModel splashModel = result.right;
      if (splashModel.getSplashScreen?.data?.splashScreenUrl == null) {
        ///Notify the splash screen that Image Not available.
        emit(SplashViewModel(
            splashPageState: SplashPageState.splashImageNotAvailable));
      } else {
        ///Notify the splash screen that Image Url is found and can be loaded to screen
        emit(SplashViewModel.mapFromSplashModel(splashModel,
            splashPageState: SplashPageState.splashImageLoaded));
      }
    } else {
      ///Notify the splash screen that Api call Failed
      emit(SplashViewModel(splashPageState: SplashPageState.failure));
    }
  }
}
