import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';
import 'package:ota/domain/hotel/hotel_detail/repositories/hotel_detail_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class HotelDetailUseCases {
  Future<Either<Failure, HotelDetailModelDomain>?> getHotelDetail(
      HotelDetailDataArgument argument);

  Future<Either<Failure, IsFavoritesDomain>?> checkFavouriteHotel({
    required String type,
    required String hotelId,
  });

  Future<Either<Failure, DeleteFavoriteModelDomain>?> unfavouritesHotel({
    required String type,
    required String hotelId,
  });

  Future<Either<Failure, AddFavoriteModelDomain>?> addFavouriteHotel({
    required AddFavoriteArgumentModelDomain favoriteArgumentModel,
  });
}

class HotelDetailUseCasesImpl implements HotelDetailUseCases {
  HotelDetailRepository? hotelDetailRepository;

  /// Dependence injection via constructor
  HotelDetailUseCasesImpl({HotelDetailRepository? repository}) {
    if (repository == null) {
      hotelDetailRepository = HotelDetailRepositoryImpl();
    } else {
      hotelDetailRepository = repository;
    }
  }

  @override
  Future<Either<Failure, HotelDetailModelDomain>?> getHotelDetail(
      HotelDetailDataArgument argument) async {
    return await hotelDetailRepository?.getHotelDetail(argument);
  }

  /// Call API to Check Favourites Hotel.
  @override
  Future<Either<Failure, IsFavoritesDomain>?> checkFavouriteHotel(
      {required String type, required String hotelId}) async {
    return await hotelDetailRepository?.checkFavouriteHotel(
        type: type, hotelId: hotelId);
  }

  /// Call API to remove Favourites Hotel.
  @override
  Future<Either<Failure, DeleteFavoriteModelDomain>?> unfavouritesHotel({
    required String type,
    required String hotelId,
  }) async {
    return await hotelDetailRepository?.unfavouritesHotel(
        type: type, hotelId: hotelId);
  }

  /// Call API to Add Favourites Hotel.
  @override
  Future<Either<Failure, AddFavoriteModelDomain>?> addFavouriteHotel({
    required AddFavoriteArgumentModelDomain favoriteArgumentModel,
  }) async {
    return await hotelDetailRepository?.addFavouriteHotel(
        favoriteArgumentModel: favoriteArgumentModel);
  }
}
