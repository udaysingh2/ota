import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/gallery/data_sources/gallery_remote_data_source.dart';
import 'package:ota/domain/gallery/repositories/gallery_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

import '../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';
import '../../hotel/repositories/internet_success_mock.dart';
import '../repositories/gallery_mock_data_source.dart';

void main() {
  GraphQlResponse graphQlResponseGallery = MockGalleryGraphQl();
  HotelDetailDataArgument argument = getHotelDetailDataArgumentMock();
  GalleryRepository galleryRepository;
  GalleryRemoteDataSourceImpl.setMock(graphQlResponseGallery);
  galleryRepository = GalleryRepositoryImpl(
      remoteDataSource: GalleryRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Gallery Data Source", () {
    GalleryRemoteDataSource galleryRemoteDataSource =
        GalleryRemoteDataSourceImpl();
    GalleryRemoteDataSourceImpl.setMock(graphQlResponseGallery);
    galleryRemoteDataSource.getGalleryData(argument, "offset", "20");
  });
  test(
      'Gallery analytics Repository '
      'When calling getGalleryResultModelUrlData '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult =
        await galleryRepository.getGalleryData(argument, "off", "limit");

    expect(consentResult.isRight, true);
  });
}
