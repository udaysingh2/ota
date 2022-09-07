import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/room_gallery/data_sources/room_gallery_remote_data_source.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';

/// Interface for GalleryRepository repository.
abstract class RoomGalleryRepository {
  /// Call API to get the Gallery Screen details.
  ///
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<Either<Failure, RoomGalleryModelDomain>> getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit);
}

/// GalleryRepositoryImpl will contain the GalleryRepository implementation.
class RoomGalleryRepositoryImpl implements RoomGalleryRepository {
  RoomGalleryRemoteDataSource? galleryRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  RoomGalleryRepositoryImpl(
      {RoomGalleryRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      galleryRemoteDataSource = RoomGalleryRemoteDataSourceImpl();
    } else {
      galleryRemoteDataSource = remoteDataSource;
    }
    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Gallery Screen details.
  ///
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, RoomGalleryModelDomain>> getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final galleryResult = await galleryRemoteDataSource?.getRoomGalleryData(
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
