import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/domain/favourites/models/favourites_model_domain.dart';
import 'package:ota/domain/favourites/models/favourites_result_model_domain.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';

class FavouritesHotelViewModel {
  final String hotelId;
  final String hotelName;
  final String location;
  final String imageUrl;
  final String cityId;
  final String countryId;
  final double? latitude;
  final double? longitude;
  final List<PromotionListViewModel> promotionList;
  final String promotionListLine1;
  final String promotionListLine2;

  FavouritesHotelViewModel({
    required this.hotelId,
    required this.hotelName,
    required this.location,
    required this.imageUrl,
    required this.cityId,
    required this.countryId,
    this.latitude,
    this.longitude,
    required this.promotionList,
    required this.promotionListLine1,
    required this.promotionListLine2,
  });

  factory FavouritesHotelViewModel.fromModel(Favourites favourites) {
    printDebug('*********${favourites.hotelId}****************');
    return FavouritesHotelViewModel(
      imageUrl: favourites.imageUrl,
      hotelName: favourites.hotelName,
      location: favourites.location,
      hotelId: favourites.hotelId,
      cityId: favourites.cityId,
      countryId: favourites.countryId,
      latitude: favourites.latitude,
      longitude: favourites.longitude,
      promotionList: (favourites.promotionList ?? [])
          .map((e) => PromotionListViewModel.fromList(e))
          .toList(),
      promotionListLine1: FavouriteHelper.getAdminPromotionLine1(
          favourites.promotionList ?? []),
      promotionListLine2: FavouriteHelper.getAdminPromotionLine2(
          favourites.promotionList ?? []),
    );
  }

  factory FavouritesHotelViewModel.fromFavoriteModel(Favorite favorite) {
    printDebug('*********${favorite.id}****************');
    return FavouritesHotelViewModel(
      imageUrl: favorite.image ?? '',
      hotelName: favorite.name ?? '',
      location: favorite.location ?? '',
      hotelId: favorite.id ?? '',
      cityId: favorite.cityId ?? '',
      countryId: favorite.countryId ?? '',
      promotionList: (favorite.promotionList ?? [])
          .map((e) => PromotionListViewModel.fromHotelList(e))
          .toList(),
      promotionListLine1: FavouriteHelper.getHotelAdminPromotionLine1(
          favorite.promotionList ?? []),
      promotionListLine2: FavouriteHelper.getHotelAdminPromotionLine2(
          favorite.promotionList ?? []),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesHotelViewModel &&
          runtimeType == other.runtimeType &&
          hotelId == other.hotelId;

  @override
  int get hashCode => hotelId.hashCode;
}

class PromotionListViewModel {
  String productId;
  String productType;
  String promotionType;
  String promotionCode;
  String line1;
  String line2;
  PromotionListViewModel({
    this.productId = "",
    this.productType = "",
    this.promotionType = "",
    this.promotionCode = "",
    this.line1 = "",
    this.line2 = "",
  });
  factory PromotionListViewModel.fromHotelList(HotelPromotionList list) {
    return PromotionListViewModel(
        promotionCode: list.promotionCode ?? '',
        promotionType: list.promotionType ?? '',
        productType: list.productType ?? '',
        line1: list.line1 ?? '',
        line2: list.line2 ?? '');
  }
  factory PromotionListViewModel.fromList(PromotionList list) {
    return PromotionListViewModel(
        promotionCode: list.promotionCode ?? '',
        promotionType: list.promotionType ?? '',
        productType: list.productType ?? '',
        line1: list.line1 ?? '',
        line2: list.line2 ?? '');
  }
  factory PromotionListViewModel.getDefault() {
    return PromotionListViewModel(
        promotionCode: '',
        promotionType: '',
        productType: '',
        line1: '',
        line2: '');
  }
}
