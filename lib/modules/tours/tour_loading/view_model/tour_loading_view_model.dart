import 'package:ota/domain/tours/loading/models/tour_loading_model.dart';

class TourLoadingViewModel {
  TourLoadingViewModelState? loadingViewModelState;
  String? imageUrl;
  TourLoadingViewModel({
    this.loadingViewModelState = TourLoadingViewModelState.initial,
    this.imageUrl,
  });

  TourLoadingViewModel.mapFromLoadingModel(TourLoadingData loadingModelData,
      {this.loadingViewModelState = TourLoadingViewModelState.initial}) {
    imageUrl = loadingModelData.getTourServiceCards?.data?.serviceBackgroundUrl;
  }
}

enum TourLoadingViewModelState { initial, loading, loaded, failure }
