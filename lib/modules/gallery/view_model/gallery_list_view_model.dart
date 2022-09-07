import 'package:ota/modules/gallery/view_model/gallery_view_model.dart';

class GalleryListViewModel {
  List<GalleryViewModel> galleryList;
  GalleryListViewModelState galleryListViewModelState;
  bool isInternetFailurePopupShown = false;

  GalleryListViewModel({
    required this.galleryList,
    this.galleryListViewModelState = GalleryListViewModelState.none,
  });
}

enum GalleryListViewModelState {
  none,
  loading,
  pullDownLoading,
  lazyDownLoading,
  success,
  failure,
  internetFailure,
  internetFailureRefresh,
}
