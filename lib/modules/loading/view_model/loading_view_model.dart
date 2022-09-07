import 'package:ota/domain/loading/models/loading_model.dart';

class LoadingViewModel {
  LoadingViewModelState? loadingViewModelState;
  String? imageUrl;
  LoadingViewModel({
    this.loadingViewModelState = LoadingViewModelState.initial,
    this.imageUrl,
  });

  LoadingViewModel.mapFromLoadingModel(LoadingModelData loadingModelData,
      {this.loadingViewModelState = LoadingViewModelState.initial}) {
    imageUrl = loadingModelData.getLoadScreen?.data?.loadScreenUrl;
  }
}

enum LoadingViewModelState { initial, loading, loaded, failure }
