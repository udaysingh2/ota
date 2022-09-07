import 'package:ota/domain/favourites/models/favourites_model_domain.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';

class FavouritesTourViewModel {
  final String tourId;
  final String tourName;
  final String? location;
  final String? imageUrl;
  final String cityId;
  final String countryId;
  final String? category;
  final String? serviceName;
  final List<HotelPromotionList>? promotionList;
  final String? promotionListLine1;
  final String? promotionListLine2;

  FavouritesTourViewModel({
    required this.tourId,
    required this.tourName,
    this.location,
    this.imageUrl,
    required this.cityId,
    required this.countryId,
    this.category,
    this.serviceName,
    this.promotionList,
    this.promotionListLine1,
    this.promotionListLine2,
  });

  factory FavouritesTourViewModel.fromModel(Favorite favourites) {
    return FavouritesTourViewModel(
      imageUrl: favourites.image,
      tourName: favourites.name!,
      location: favourites.location,
      tourId: favourites.id!,
      category: favourites.category,
      cityId: favourites.cityId!,
      countryId: favourites.countryId!,
      serviceName: favourites.serviceName,
      promotionList: favourites.promotionList,
      promotionListLine1: FavouriteHelper.getHotelAdminPromotionLine1(
        favourites.promotionList ?? [],
      ),
      promotionListLine2: FavouriteHelper.getHotelAdminPromotionLine1(
        favourites.promotionList ?? [],
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesTourViewModel &&
          runtimeType == other.runtimeType &&
          tourId == other.tourId;

  @override
  int get hashCode => tourId.hashCode;
}
