import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/gallery/data_sources/gallery_remote_data_source.dart';
import 'package:ota/domain/gallery/models/gallery_argument_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

class GalleryRemoteDataSourceFailureMock implements GalleryRemoteDataSource {
  @override
  Future<GalleryResultModel> getGalleryData(
      HotelDetailDataArgument argument, String offset, String limit) {
    throw exp.ServerException(null);
  }

  @override
  Future<GalleryModelDomain> getGalleryImages(
      GalleryArgumentDomain argument, String offset, String limit) {
    throw exp.ServerException(null);
  }
}
