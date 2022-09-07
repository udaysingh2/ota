class RoomGalleryViewModel {
  List<RoomGalleryModel> galleryList;
  RoomGalleryViewModelState galleryListViewModelState;
  bool isInternetFailurePopupShown = false;

  RoomGalleryViewModel({
    required this.galleryList,
    this.galleryListViewModelState = RoomGalleryViewModelState.none,
  });
}

class RoomGalleryModel {
  final String imageUrl;

  RoomGalleryModel({
    required this.imageUrl,
  });

  factory RoomGalleryModel.fromModel(String? imgUrl) {
    return RoomGalleryModel(
      imageUrl: imgUrl ?? '',
    );
  }
}

enum RoomGalleryViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
  internetFailure,
  internetFailureRefresh,
}
