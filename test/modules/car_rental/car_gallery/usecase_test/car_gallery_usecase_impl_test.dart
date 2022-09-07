import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';

import 'package:ota/domain/car_rental/car_gallery/usecases/car_gallery_use_cases.dart';

import '../repositories/car_gallery_usecase_impl_mock.dart';

void main() {
  String id = "2";
  CarGalleryUseCases? carGalleryUseCases;
  CarGalleryArgumentDomain argumentDomain = CarGalleryArgumentDomain(carId: id);
  setUpAll(() async {
    carGalleryUseCases = CarGalleryUseCasesImpl();
    carGalleryUseCases = CarGalleryUseCasesImpl(
        repository: CarGalleryRepositoryImplSuccessMock());
  });

  test('Car Gallery Getting Data Successfully ', () async {
    /// Consent user cases impl
    final consentResult = await carGalleryUseCases!
        .getCarGalleryData(argument: argumentDomain, offset: 0, limit: 20);

    /// Get model from mock data.
    final CarGalleryModelDomain model = consentResult!.right;

    /// Condition check for hotel value null
    expect(model.getAllCarRentalImages!.data != null, true);
  });
}
