import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_detail/data_sources/hotel_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';
import 'package:ota/domain/hotel/hotel_detail/repositories/hotel_detail_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

class HotelDetailRepositoryImplSuccessMock
    implements HotelDetailRepositoryImpl {
  @override
  HotelDetailRemoteDataSource? hotelDetailRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, HotelDetailModelDomain>> getHotelDetail(
      HotelDetailDataArgument argument) async {
    @override
    HotelDetailModelDomain hotel = HotelDetailModelDomain();
    return Right(hotel);
  }

  @override
  Future<Either<Failure, IsFavoritesDomain>> checkFavouriteHotel(
      {required String type, required String hotelId}) async {
    String json = fixture("hotel/check_favorite.json");
    return Right(IsFavoritesDomain.fromJson(json));
  }

  @override
  Future<Either<Failure, AddFavoriteModelDomain>> addFavouriteHotel(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel}) async {
    String json = fixture("hotel/add_favorite.json");
    return Right(AddFavoriteModelDomain.fromJson(json));
  }

  @override
  Future<Either<Failure, DeleteFavoriteModelDomain>> unfavouritesHotel(
      {required String type, required String hotelId}) async {
    String json = fixture("hotel/delete_favorite.json");
    return Right(DeleteFavoriteModelDomain.fromJson(json));
  }
}
