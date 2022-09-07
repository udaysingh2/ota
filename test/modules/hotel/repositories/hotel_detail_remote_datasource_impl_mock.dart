import 'package:ota/domain/hotel/hotel_detail/data_sources/hotel_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';

import '../../../mocks/fixture_reader.dart';

class HotelDetailRemoteDataSourceImplSuccessMock
    implements HotelDetailRemoteDataSource {
  @override
  Future<HotelDetailModelDomain> getHotelDetail(
      HotelDetailDataArgument argument) async {
    HotelDetailModelDomain hotel = HotelDetailModelDomain();
    return hotel;
  }

  @override
  Future<IsFavoritesDomain> checkFavouriteHotel(
      {required String type, required String hotelId}) async {
    String json = fixture("hotel/check_favorite.json");
    return IsFavoritesDomain.fromJson(json);
  }

  @override
  Future<AddFavoriteModelDomain> addFavouriteHotel(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel}) async {
    String json = fixture("hotel/add_favorite.json");
    return AddFavoriteModelDomain.fromJson(json);
  }

  @override
  Future<DeleteFavoriteModelDomain> unfavouritesHotel(
      {required String type, required String hotelId}) async {
    String json = fixture("hotel/delete_favorite.json");
    return DeleteFavoriteModelDomain.fromJson(json);
  }
}
