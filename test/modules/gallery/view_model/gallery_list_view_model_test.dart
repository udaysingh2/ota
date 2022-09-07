import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/gallery/view_model/gallery_list_view_model.dart';

void main() {
  testWidgets('gallery list view model ...', (tester) async {
    GalleryListViewModel galleryListViewModel =
        GalleryListViewModel(galleryList: []);
    galleryListViewModel.galleryList = [];
    galleryListViewModel.galleryListViewModelState =
        GalleryListViewModelState.none;
    expect(galleryListViewModel.galleryListViewModelState,
        GalleryListViewModelState.none);
    galleryListViewModel.galleryListViewModelState =
        GalleryListViewModelState.loading;
    expect(galleryListViewModel.galleryListViewModelState,
        GalleryListViewModelState.loading);
    galleryListViewModel.galleryListViewModelState =
        GalleryListViewModelState.success;
    expect(galleryListViewModel.galleryListViewModelState,
        GalleryListViewModelState.success);
    galleryListViewModel.galleryListViewModelState =
        GalleryListViewModelState.failure;
    expect(galleryListViewModel.galleryListViewModelState,
        GalleryListViewModelState.failure);
  });
}
