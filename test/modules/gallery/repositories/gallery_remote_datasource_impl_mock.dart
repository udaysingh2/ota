import 'package:ota/domain/gallery/data_sources/gallery_remote_data_source.dart';
import 'package:ota/domain/gallery/models/gallery_argument_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

import '../../../mocks/fixture_reader.dart';

class GalleryRemoteDataSourceImplSuccessMock
    implements GalleryRemoteDataSource {
  @override
  Future<GalleryResultModel> getGalleryData(
      HotelDetailDataArgument argument, String offset, String limit) async {
    String json = fixture("gallery/gallery_result_model.json");

    ///Convert into Model
    GalleryResultModel model = GalleryResultModel.fromJson(json);
    return model;
  }

  @override
  Future<GalleryModelDomain> getGalleryImages(
      GalleryArgumentDomain argument, String offset, String limit) async{
    String json = fixture("gallery/gallery_model_domain.json");

    ///Convert into Model
    GalleryModelDomain model = GalleryModelDomain.fromJson(json);
    return model;
  }
}
