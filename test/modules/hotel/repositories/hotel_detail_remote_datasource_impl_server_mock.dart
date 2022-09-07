import 'package:ota/common/network/exceptions.dart';
import 'package:ota/domain/hotel/hotel_detail/data_sources/hotel_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';

class HotelDetailRemoteDataSourceImplFailureMock
    implements HotelDetailRemoteDataSource {
  @override
  Future<HotelDetailModelDomain> getHotelDetail(
      HotelDetailDataArgument argument) async {
    throw ServerException(null);
  }

  @override
  Future<IsFavoritesDomain> checkFavouriteHotel(
      {required String type, required String hotelId}) async {
    throw ServerException(null);
  }

  @override
  Future<AddFavoriteModelDomain> addFavouriteHotel(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel}) async {
    throw ServerException(null);
  }

  @override
  Future<DeleteFavoriteModelDomain> unfavouritesHotel(
      {required String type, required String hotelId}) async {
    throw ServerException(null);
  }
}
