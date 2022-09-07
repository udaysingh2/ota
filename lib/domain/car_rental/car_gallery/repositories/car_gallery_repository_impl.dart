import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_gallery/data_sources/car_gallery_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';

//Car Rental

/// Interface for GalleryRepository repository.
abstract class CarGalleryRepository {
  /// Call API to get the Gallery Screen details.
  ///
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<Either<Failure, CarGalleryModelDomain>> getCarGalleryData(
      CarGalleryArgumentDomain argument, int offset, int limit);
}

/// GalleryRepositoryImpl will contain the GalleryRepository implementation.
class CarGalleryRepositoryImpl implements CarGalleryRepository {
  CarGalleryRemoteDataSource? galleryRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarGalleryRepositoryImpl(
      {CarGalleryRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      galleryRemoteDataSource = CarGalleryRemoteDataSourceImpl();
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
  Future<Either<Failure, CarGalleryModelDomain>> getCarGalleryData(
      CarGalleryArgumentDomain argument, int offset, int limit) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final galleryResult = await galleryRemoteDataSource?.getCarGalleryData(
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
