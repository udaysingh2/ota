import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tours/loading/models/tour_loading_model.dart';
import 'package:ota/domain/tours/loading/use_cases/tour_loading_usecases.dart';
import 'package:ota/modules/tours/tour_loading/view_model/tour_loading_view_model.dart';

///Rules
///* Bloc will not handle any Server errors. Refer domain section for error handling
///* Bloc will not have any Variables. Only way to access its value is BlocName.state.
///*
class TourLoadingBloc extends Bloc<TourLoadingViewModel> {
  @override
  TourLoadingViewModel initDefaultValue() {
    ///Bloc should have default value
    ///To build the widget with default state
    return TourLoadingViewModel();
  }

  ///Make An Api call.
  ///Update the state of the Loading Screen based on Response
  ///of the api.
  void getLoadingData() async {
    ///Notify the Loading Screen that API call started and set the state as Loading.
    emit(
        TourLoadingViewModel(loadingViewModelState: TourLoadingViewModelState.loading));

    ///Instantiate the UseCase responsible to get the Loading data.
    TourLoadingUseCases loadingUseCasesImpl = TourLoadingUseCasesImpl();
    await mapLoadingData(loadingUseCasesImpl);
  }

  ///Get The result Of for Loading screen
  Future<void> mapLoadingData(TourLoadingUseCases loadingUseCasesImpl) async {
    Either<Failure, TourLoadingData> result =
    (await loadingUseCasesImpl.getLoadingData())!;

    if (result.isRight) {
      TourLoadingData loadingModelData = result.right;
      if (loadingModelData.getTourServiceCards?.data?.serviceBackgroundUrl == null) {
        ///Notify the Loading screen that Image Not available.
        emit(TourLoadingViewModel(
            loadingViewModelState: TourLoadingViewModelState.failure));
      } else {
        ///Notify the Loading screen that Image Url is found and can be loaded to screen
        emit(TourLoadingViewModel.mapFromLoadingModel(loadingModelData,
            loadingViewModelState: TourLoadingViewModelState.loaded));
      }
    } else {
      ///Notify the Loading screen that Api call Failed
      emit(TourLoadingViewModel(
          loadingViewModelState: TourLoadingViewModelState.failure));
    }

  }
}
