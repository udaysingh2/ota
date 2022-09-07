import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_model_domain.dart';
import 'package:ota/modules/tours/landing/helpers/tour_landing_helper.dart';

const int kMaxCapsuleLength = 18;

class TourRecentPlaylistViewModel {
  List<TourListPlaylistItem> listItem;
  TourRecentPlaylistViewModelState pageState;
  TourRecentPlaylistViewModel({
    this.listItem = const [],
    this.pageState = TourRecentPlaylistViewModelState.initial,
  });
  factory TourRecentPlaylistViewModel.fromData(Data data) {
    return TourRecentPlaylistViewModel(
      listItem: data.recentViewPlaylist == null
          ? []
          : List.generate(
              data.recentViewPlaylist!.length,
              (index) => TourListPlaylistItem.fromRecentViewPlaylist(
                data.recentViewPlaylist![index],
              ),
            ),
    );
  }
}

class TourListPlaylistItem {
  final String? id;
  final String? cityId;
  final String? countryId;
  final String? name;
  final String? image;
  final String? locationName;
  final String? category;
  final String? type;
  final TourRecentPromotions? promotions;
  final String? location;

  TourListPlaylistItem({
    this.id,
    this.cityId,
    this.countryId,
    this.name,
    this.image,
    this.locationName,
    this.category,
    this.type,
    this.promotions,
    this.location,
  });

  factory TourListPlaylistItem.fromRecentViewPlaylist(
      RecentViewPlaylist recentPlaylist) {
    return TourListPlaylistItem(
      id: recentPlaylist.id,
      cityId: recentPlaylist.cityId,
      name: recentPlaylist.name,
      image: recentPlaylist.image,
      category: recentPlaylist.category,
      locationName: recentPlaylist.locationName,
      countryId: recentPlaylist.countryId,
      type: recentPlaylist.type,
      promotions: recentPlaylist.promotions == null
          ? null
          : TourRecentPromotions.fromPromotions(recentPlaylist.promotions!),
      location: recentPlaylist.location,
    );
  }
}

class TourRecentPromotions {
  final String? line1;
  final String? line2;
  final List<TourRecentCapsulePromotion>? capsulePromotion;

  TourRecentPromotions({
    this.line1,
    this.line2,
    this.capsulePromotion,
  });

  factory TourRecentPromotions.fromPromotions(List<Promotions> promotion) {
    return TourRecentPromotions(
      capsulePromotion: TourLandingHelper.getCapsulePromotions(promotion),
      line1: TourLandingHelper.getAdminPromotionLine1(promotion),
      line2: TourLandingHelper.getAdminPromotionLine2(promotion),
    );
  }
}

class TourRecentCapsulePromotion {
  final String? promotionCode;
  final String? productType;
  final String? title;

  TourRecentCapsulePromotion({
    this.promotionCode,
    this.productType,
    this.title,
  });

  factory TourRecentCapsulePromotion.fromCapsulePromotion(
      Promotions capsulePromotion) {
    return TourRecentCapsulePromotion(
        productType: capsulePromotion.productType,
        promotionCode: capsulePromotion.promotionCode,
        title:
            Helpers.truncateString(capsulePromotion.line1, kMaxCapsuleLength));
  }
}

enum TourRecentPlaylistViewModelState {
  initial,
  loading,
  success,
  failure,
  failure1899,
  failure1999,
}
