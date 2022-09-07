import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/gallery/models/gallery_argument_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';
import 'package:ota/domain/gallery/repositories/gallery_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

import '../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';
import '../../hotel/repositories/internet_failure_mock.dart';
import '../../hotel/repositories/internet_success_mock.dart';
import '../repositories/gallery_remote_datasource_impl_failure_mock.dart';
import '../repositories/gallery_remote_datasource_impl_mock.dart';

void main() {
  GalleryRepository? galleryRepositoryServerException;
  GalleryRepository? galleryRepositoryMock;
  GalleryRepository? galleryRepositoryInternetFailure;
  HotelDetailDataArgument argument = getHotelDetailDataArgumentMock();
  GalleryArgumentDomain argumentGallery =
      GalleryArgumentDomain(serviceId: "MA2110000413", serviceName: "Tour");

  setUpAll(() async {
    /// Code coverage for default implementation.
    galleryRepositoryMock = GalleryRepositoryImpl();

    /// Code coverage for mock class
    galleryRepositoryMock = GalleryRepositoryImpl(
        remoteDataSource: GalleryRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    galleryRepositoryServerException = GalleryRepositoryImpl(
        remoteDataSource: GalleryRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    galleryRepositoryInternetFailure = GalleryRepositoryImpl(
        remoteDataSource: GalleryRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Gallery analytics Repository '
      'When calling getGalleryResultModelUrlData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await galleryRepositoryMock!.getGalleryData(argument, "0", "10");

    /// Get model from mock data.
    final GalleryResultModel model = consentResult.right;

    /// Condition check for hotel value null
    expect(model.data != null, true);
  });

  test(
      'Gallery analytics Repository '
      'When calling getGalleryResultModelUrlData '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await galleryRepositoryInternetFailure!
        .getGalleryData(argument, "0", "10");

    expect(consentResult.isLeft, true);
  });

  test(
      'Gallery analytics Repository '
      'When calling getGalleryResultModelUrlData '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResult = await galleryRepositoryServerException!
        .getGalleryData(argument, "0", "10");

    expect(consentResult.isLeft, true);
  });

  test(
      'Gallery analytics Repository '
      'When calling getGalleryResultModelUrlData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await galleryRepositoryMock!
        .getGalleryImages(argumentGallery, "0", "10");

    /// Get model from mock data.
    final GalleryModelDomain model = consentResult.right;

    /// Condition check for hotel value null
    expect(model.getAllTourImages?.data != null, true);
  });

  test(
      'Gallery analytics Repository '
      'When calling getGalleryResultModelUrlData '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await galleryRepositoryInternetFailure!
        .getGalleryImages(argumentGallery, "0", "10");
    expect(consentResult.isLeft, true);
  });
}
