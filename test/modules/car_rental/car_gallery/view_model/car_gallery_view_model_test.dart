import 'package:flutter_test/flutter_test.dart';

import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_view_model.dart';

void main() {
  testWidgets('car gallery view model ...', (tester) async {
    String thumb = "Thumb";
    String full = "Full";
    CarGalleryModel carGalleryModel = CarGalleryModel.fromModel(thumb, full);
    CarGalleryViewModel carGalleryViewModel = CarGalleryViewModel(
        galleryListViewModelState: CarGalleryViewModelState.none,
        galleryList: [carGalleryModel]);

    expect(carGalleryViewModel.galleryListViewModelState,
        CarGalleryViewModelState.none);
    expect(carGalleryViewModel.galleryList.isNotEmpty, true);
    expect(carGalleryModel.thumb, thumb);
    expect(carGalleryModel.full, full);
  });
}
