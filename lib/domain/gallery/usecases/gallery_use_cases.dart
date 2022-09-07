import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/gallery/models/gallery_argument_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';
import 'package:ota/domain/gallery/repositories/gallery_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

/// Interface for Gallery use cases.
abstract class GalleryUseCases {
  /// Call API to get the Gallery Screen details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<Either<Failure, GalleryResultModel>?> getGalleryData({
    required HotelDetailDataArgument argument,
    required String offset,
    required String limit,
  });

  /// Call API to get the Gallery Screen details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<Either<Failure, GalleryModelDomain>?> getGalleryImages({
    required GalleryArgumentDomain argument,
    required String offset,
    required String limit,
  });
}

/// GalleryUseCasesImpl will contain the GalleryUseCases implementation.
class GalleryUseCasesImpl implements GalleryUseCases {
  GalleryRepository? galleryRepository;

  /// Dependence injection via constructor
  GalleryUseCasesImpl({GalleryRepository? repository}) {
    if (repository == null) {
      galleryRepository = GalleryRepositoryImpl();
    } else {
      galleryRepository = repository;
    }
  }

  /// Call API to get the Gallery Screen Details details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, GalleryResultModel>?> getGalleryData({
    required HotelDetailDataArgument argument,
    required String offset,
    required String limit,
  }) async {
    return await galleryRepository?.getGalleryData(argument, offset, limit);
  }

  /// Call API to get the Gallery Screen Details details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, GalleryModelDomain>?> getGalleryImages({
    required GalleryArgumentDomain argument,
    required String offset,
    required String limit,
  }) async {
    return await galleryRepository?.getGalleryImages(argument, offset, limit);
  }
}
