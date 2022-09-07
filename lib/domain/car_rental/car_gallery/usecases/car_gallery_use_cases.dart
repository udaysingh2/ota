import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/repositories/car_gallery_repository_impl.dart';

/// Interface for Gallery use cases.
abstract class CarGalleryUseCases {
  /// Call API to get the Gallery Screen details.
  ///
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<Either<Failure, CarGalleryModelDomain>?> getCarGalleryData({
    required CarGalleryArgumentDomain argument,
    required int offset,
    required int limit,
  });
}

/// GalleryUseCasesImpl will contain the GalleryUseCases implementation.
class CarGalleryUseCasesImpl implements CarGalleryUseCases {
  CarGalleryRepository? galleryRepository;

  /// Dependence injection via constructor
  CarGalleryUseCasesImpl({CarGalleryRepository? repository}) {
    if (repository == null) {
      galleryRepository = CarGalleryRepositoryImpl();
    } else {
      galleryRepository = repository;
    }
  }

  /// Call API to get the Gallery Screen Details details.
  ///
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarGalleryModelDomain>?> getCarGalleryData({
    required CarGalleryArgumentDomain argument,
    required int offset,
    required int limit,
  }) async {
    return await galleryRepository?.getCarGalleryData(argument, offset, limit);
  }
}
