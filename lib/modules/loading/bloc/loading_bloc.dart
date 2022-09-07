import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/loading/models/loading_model.dart';
import 'package:ota/domain/loading/usecases/loading_usecases.dart';
import 'package:ota/modules/loading/view_model/loading_view_model.dart';

///Rules
///* Bloc will not handle any Server errors. Refer domain section for error handling
///* Bloc will not have any Variables. Only way to access its value is BlocName.state.
///*
class LoadingBloc extends Bloc<LoadingViewModel> {
  LoadingUseCases loadingUseCasesImpl = LoadingUseCasesImpl();

  @override
  LoadingViewModel initDefaultValue() {
    ///Bloc should have default value
    ///To build the widget with default state
    return LoadingViewModel();
  }

  ///Make An Api call.
  ///Update the state of the Loading Screen based on Response
  ///of the api.
  void getLoadingData(String serviceName) async {
    ///Notify the Loading Screen that API call started and set the state as Loading.
    emit(
        LoadingViewModel(loadingViewModelState: LoadingViewModelState.loading));

    ///Instantiate the UseCase responsible to get the Loading data.
    await mapLoadingData(loadingUseCasesImpl, serviceName);
  }

  ///Get The result Of for Loading screen
  Future<void> mapLoadingData(LoadingUseCases loadingUseCasesImpl, String serviceName) async {
    Either<Failure, LoadingModelData> result =
        (await loadingUseCasesImpl.getLoadingData(serviceName))!;

    if (result.isRight) {
      LoadingModelData loadingModelData = result.right;
      if (loadingModelData.getLoadScreen?.data?.loadScreenUrl == null) {
        ///Notify the Loading screen that Image Not available.
        emit(LoadingViewModel(
            loadingViewModelState: LoadingViewModelState.failure));
      } else {
        ///Notify the Loading screen that Image Url is found and can be loaded to screen
        emit(LoadingViewModel.mapFromLoadingModel(loadingModelData,
            loadingViewModelState: LoadingViewModelState.loaded));
      }
    } else {
      ///Notify the Loading screen that Api call Failed
      emit(LoadingViewModel(
          loadingViewModelState: LoadingViewModelState.failure));
    }
  }
}
