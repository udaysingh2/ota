import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';
import 'package:ota/domain/hotel/hotel_detail/repositories/hotel_detail_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_detail/usecases/hotel_detail_use_cases.dart';

class HotelDetailUseCaseImplFailureMock implements HotelDetailUseCasesImpl {
  @override
  HotelDetailRepository? hotelDetailRepository;

  @override
  Future<Either<Failure, HotelDetailModelDomain>?> getHotelDetail(
      HotelDetailDataArgument argument) async {
    /// data model testing.

    return Left(InternetFailure());
  }

  @override
  Future<Either<Failure, IsFavoritesDomain>?> checkFavouriteHotel(
      {required String type, required String hotelId}) async {
    return Left(InternetFailure());
  }

  @override
  Future<Either<Failure, AddFavoriteModelDomain>?> addFavouriteHotel(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel}) async {
    return Left(InternetFailure());
  }

  @override
  Future<Either<Failure, DeleteFavoriteModelDomain>?> unfavouritesHotel(
      {required String type, required String hotelId}) async {
    return Left(InternetFailure());
  }
}
