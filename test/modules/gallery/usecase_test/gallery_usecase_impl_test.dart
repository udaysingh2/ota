import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';
import 'package:ota/domain/gallery/usecases/gallery_use_cases.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

import '../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';
import '../repositories/gallery_repository_impl_success_mock.dart';

void main() {
  GalleryUseCases? galleryUseCases;
  HotelDetailDataArgument argument = getHotelDetailDataArgumentMock();
  setUpAll(() async {
    /// Code coverage for default implementation.
    galleryUseCases = GalleryUseCasesImpl();

    /// Code coverage for mock class
    galleryUseCases =
        GalleryUseCasesImpl(repository: GalleryRepositoryImplSuccessMock());
  });

  test(
      'Hotel analytics usecases '
      'When calling getHotelUrlData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await galleryUseCases!
        .getGalleryData(offset: "0", limit: "10", argument: argument);

    /// Get model from mock data.
    final GalleryResultModel model = consentResult!.right;

    /// Condition check for hotel value null
    expect(model.data != null, true);
  });
}
