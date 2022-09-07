import 'package:either_dart/src/either.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/gallery/data_sources/gallery_remote_data_source.dart';
import 'package:ota/domain/gallery/models/gallery_argument_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';
import 'package:ota/domain/gallery/repositories/gallery_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

import '../../../mocks/fixture_reader.dart';

class GalleryRepositoryImplSuccessMockNull implements GalleryRepositoryImpl {
  @override
  GalleryRemoteDataSource? galleryRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, GalleryResultModel>> getGalleryData(
      HotelDetailDataArgument argument, String offset, String limit) async {
    String json = fixture("gallery/gallery_result_model_null_data.json");

    ///Convert into Model
    GalleryResultModel model = GalleryResultModel.fromJson(json);
    printDebug(model.data?.hotelDetail?.images?.baseUri);
    return Right(model);
  }

  @override
  Future<Either<Failure, GalleryModelDomain>> getGalleryImages(
      GalleryArgumentDomain argument, String offset, String limit) async {
    String json = fixture("gallery/gallery_model_domain_no_data.json");

    ///Convert into Model
    GalleryModelDomain model = GalleryModelDomain.fromJson(json);
    return Right(model);
  }
}
