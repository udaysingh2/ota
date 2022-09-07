import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/repositories/car_gallery_repository_impl.dart';

import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';
import '../repositories/car_gallery_remote_datascource_impl_mock.dart';
import '../repositories/car_gallery_remote_datasource_impl_failure_mock.dart';

void main() {
  String id = "2";
  CarGalleryRepository? galleryRepositoryServerException;
  CarGalleryRepository? galleryRepositoryMock;
  CarGalleryRepository? galleryRepositoryInternetFailure;
  CarGalleryArgumentDomain argument = CarGalleryArgumentDomain(carId: id);

  setUpAll(() async {
    /// Code coverage for default implementation.
    galleryRepositoryMock = CarGalleryRepositoryImpl();

    /// Code coverage for mock class
    galleryRepositoryMock = CarGalleryRepositoryImpl(
        remoteDataSource: CarGalleryRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    galleryRepositoryServerException = CarGalleryRepositoryImpl(
        remoteDataSource: CarGalleryRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    galleryRepositoryInternetFailure = CarGalleryRepositoryImpl(
        remoteDataSource: CarGalleryRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Gallery analytics Repository '
      'When calling getAllCarRentalImages '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await galleryRepositoryMock!.getCarGalleryData(argument, 0, 20);

    /// Get model from mock data.
    final CarGalleryModelDomain model = consentResult.right;

    /// Condition check for hotel value null
    expect(model.getAllCarRentalImages!.data != null, true);
  });

  test(
      'Gallery analytics Repository '
      'When calling getAllCarRentalImages '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await galleryRepositoryInternetFailure!
        .getCarGalleryData(argument, 0, 20);

    expect(consentResult.isLeft, true);
  });

  test(
      'Gallery analytics Repository '
      'When calling getAllCarRentalImages '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResult = await galleryRepositoryServerException!
        .getCarGalleryData(argument, 0, 20);

    expect(consentResult.isLeft, true);
  });
}
