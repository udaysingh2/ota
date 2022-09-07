import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/gallery/data_sources/gallery_remote_data_source.dart';
import 'package:ota/domain/gallery/models/gallery_argument_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

/// Interface for GalleryRepository repository.
abstract class GalleryRepository {
  /// Call API to get the Gallery Screen details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<Either<Failure, GalleryResultModel>> getGalleryData(
      HotelDetailDataArgument argument, String offset, String limit);

  /// Call API to get the Gallery Screen details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<Either<Failure, GalleryModelDomain>> getGalleryImages(
      GalleryArgumentDomain argument, String offset, String limit);
}

/// GalleryRepositoryImpl will contain the GalleryRepository implementation.
class GalleryRepositoryImpl implements GalleryRepository {
  GalleryRemoteDataSource? galleryRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  GalleryRepositoryImpl(
      {GalleryRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      galleryRemoteDataSource = GalleryRemoteDataSourceImpl();
    } else {
      galleryRemoteDataSource = remoteDataSource;
    }

    if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Gallery Screen details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, GalleryResultModel>> getGalleryData(
      HotelDetailDataArgument argument, String offset, String limit) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final galleryResult = await galleryRemoteDataSource?.getGalleryData(
            argument, offset, limit);
        return Right(galleryResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  /// Call API to get the Gallery Screen details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, GalleryModelDomain>> getGalleryImages(
      GalleryArgumentDomain argument, String offset, String limit) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final galleryResult = await galleryRemoteDataSource?.getGalleryImages(
            argument, offset, limit);
        return Right(galleryResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
