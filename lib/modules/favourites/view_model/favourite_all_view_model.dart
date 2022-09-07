import 'package:ota/domain/favourites/models/favourites_all_model_domain.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';

class FavouritesAllViewModel {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final String? cityId;
  final String? countryId;
  final double? latitude;
  final double? longitude;
  final List<AllPromotionListViewModel> promotionList;
  final String promotionListLine1;
  final String promotionListLine2;
  final String? pickupLocationId;
  final String? dropLocationId;
  final String? supplierId;
  final String serviceName;
  final String? pickupCounter;
  final String? returnCounter;

  FavouritesAllViewModel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    this.cityId,
    this.countryId,
    this.latitude,
    this.longitude,
    required this.promotionList,
    required this.promotionListLine1,
    required this.promotionListLine2,
    this.pickupLocationId,
    this.dropLocationId,
    this.supplierId,
    required this.serviceName,
    this.pickupCounter,
    this.returnCounter,
  });

  factory FavouritesAllViewModel.fromAllModel(Favorite favourites) {
    return FavouritesAllViewModel(
      imageUrl: favourites.image ?? "",
      name: favourites.name ?? "",
      location: favourites.location ?? "",
      cityId: favourites.cityId ?? "",
      countryId: favourites.countryId ?? "",
      id: favourites.id ?? "",
      promotionList: (favourites.promotionList ?? [])
          .map((e) => AllPromotionListViewModel.fromCarPromotionList(e))
          .toList(),
      pickupLocationId: favourites.pickupLocationId ?? "",
      dropLocationId: favourites.dropLocationId ?? "",
      supplierId: favourites.supplierId ?? "",
      promotionListLine1: FavouriteHelper.getAdminAllPromotionLine1(
        favourites.promotionList ?? [],
      ),
      promotionListLine2: FavouriteHelper.getAdminAllPromotionLine2(
        favourites.promotionList ?? [],
      ),
      serviceName: favourites.serviceName ?? '',
      pickupCounter: favourites.pickupCounter,
      returnCounter: favourites.returnCounter,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesAllViewModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class AllPromotionListViewModel {
  String productId;
  String productType;
  String promotionType;
  String promotionCode;
  String line1;
  String line2;

  AllPromotionListViewModel({
    this.productId = "",
    this.productType = "",
    this.promotionType = "",
    this.promotionCode = "",
    this.line1 = "",
    this.line2 = "",
  });

  factory AllPromotionListViewModel.fromCarPromotionList(
      AllPromotionList list) {
    return AllPromotionListViewModel(
      promotionCode: list.promotionCode ?? '',
      promotionType: list.promotionType ?? '',
      productType: list.productType ?? '',
      line1: list.line1 ?? '',
      line2: list.line2 ?? '',
    );
  }

  factory AllPromotionListViewModel.getDefault() {
    return AllPromotionListViewModel(
      promotionCode: '',
      promotionType: '',
      productType: '',
      line1: '',
      line2: '',
    );
  }
}
