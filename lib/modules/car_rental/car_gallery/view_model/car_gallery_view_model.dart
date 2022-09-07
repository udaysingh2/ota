class CarGalleryViewModel {
  List<CarGalleryModel> galleryList;
  CarGalleryViewModelState galleryListViewModelState;

  CarGalleryViewModel({
    required this.galleryList,
    this.galleryListViewModelState = CarGalleryViewModelState.none,
  });
}

class CarGalleryModel {
  final String thumb;
  final String full;

  CarGalleryModel({
    required this.thumb,
    required this.full,
  });

  factory CarGalleryModel.fromModel(String? thumbURL, String? fullURL) {
    return CarGalleryModel(thumb: thumbURL ?? '', full: fullURL ?? '');
  }
}

enum CarGalleryViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
  failureNetwork,
}
