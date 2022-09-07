import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_argument_model.dart';

void main() {
  testWidgets('car gallery argument model ...', (tester) async {
    const String id = "2";
    CarGalleryArgumentModel carGalleryArgumentModel =
        CarGalleryArgumentModel(carId: id);
    expect(carGalleryArgumentModel.carId, id);
  });
}
