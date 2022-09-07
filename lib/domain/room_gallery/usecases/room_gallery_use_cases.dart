import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';
import 'package:ota/domain/room_gallery/repositories/room_gallery_repository_impl.dart';

/// Interface for Gallery use cases.
abstract class RoomGalleryUseCases {
  /// Call API to get the Gallery Screen details.
  ///
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<Either<Failure, RoomGalleryModelDomain>?> getRoomGalleryData({
    required RoomGalleryArgumentDomain argument,
    required int offset,
    required int limit,
  });
}

/// GalleryUseCasesImpl will contain the GalleryUseCases implementation.
class RoomGalleryUseCasesImpl implements RoomGalleryUseCases {
  RoomGalleryRepository? galleryRepository;

  /// Dependence injection via constructor
  RoomGalleryUseCasesImpl({RoomGalleryRepository? repository}) {
    if (repository == null) {
      galleryRepository = RoomGalleryRepositoryImpl();
    } else {
      galleryRepository = repository;
    }
  }

  /// Call API to get the Gallery Screen Details details.
  ///
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, RoomGalleryModelDomain>?> getRoomGalleryData({
    required RoomGalleryArgumentDomain argument,
    required int offset,
    required int limit,
  }) async {
    return await galleryRepository?.getRoomGalleryData(argument, offset, limit);
  }
}
