import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/gallery/view_model/gallery_view_model.dart';

void main() {
  test('Gallery View Model Tests', () async {
    GalleryViewModel galleryViewModel = GalleryViewModel.fromModel(
        "https://manage.robinhood.in.th/ImageData/Hotel/",
        "amora_neoluxe_bangkok-general1.jpg");
    expect(galleryViewModel.imageUrl,
        "https://manage.robinhood.in.th/ImageData/Hotel/amora_neoluxe_bangkok-general1.jpg");
  });
}
