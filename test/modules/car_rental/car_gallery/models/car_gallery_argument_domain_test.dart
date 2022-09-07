import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';

void main() {
  test('car gallery argument domain ...', () async {
    String id = "2";
    CarGalleryArgumentDomain carGalleryArgumentDomain =
        CarGalleryArgumentDomain(carId: id);
    expect(carGalleryArgumentDomain.carId, id);
  });
}
