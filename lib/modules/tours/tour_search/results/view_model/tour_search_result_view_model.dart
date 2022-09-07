import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_model_domain.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';

const int kMaxCapsuleLength = 18;

class TourSearchResultViewModel {
  List<TourSearchResultModel>? tourSearchList;
  List<TourSearchResultModel>? ticketSearchList;
  TourFilterDataViewModel? tourFilterOption;
  TourFilterDataViewModel? ticketFilterOption;
  PlaylistType selectedCategory;
  String? locationName;
  TourSearchResultViewState tourSearchResultViewState;
  TourSearchResultViewModel({
    this.tourSearchList,
    this.ticketSearchList,
    this.locationName,
    this.selectedCategory = PlaylistType.tour,
    this.tourSearchResultViewState = TourSearchResultViewState.initial,
    this.tourFilterOption,
    this.ticketFilterOption,
  });
}

class TourSearchResultModel {
  final String id;
  final String name;
  final String imageUrl;
  final String? locationName;
  final String cityId;
  final String countryId;
  final String? cityName;
  final String countryName;
  final String? category;
  final double startPrice;
  final String? promotionTextLine1;
  final String? promotionTextLine2;
  final List<TourSearchCapsulePromotion>? capsulePromotion;

  TourSearchResultModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.locationName,
    required this.cityId,
    required this.countryId,
    required this.cityName,
    required this.countryName,
    required this.category,
    required this.startPrice,
    this.promotionTextLine1,
    this.promotionTextLine2,
    this.capsulePromotion,
  });

  factory TourSearchResultModel.fromSearchModelDomain(
      TourAndTicketActivityList tourTicket) {
    return TourSearchResultModel(
      id: tourTicket.id ?? '',
      name: tourTicket.name ?? '',
      imageUrl: tourTicket.imageUrl ?? '',
      locationName: tourTicket.locationName,
      cityId: tourTicket.cityId ?? '',
      countryId: tourTicket.countryId ?? '',
      cityName: tourTicket.cityName,
      countryName: tourTicket.countryName ?? '',
      category: tourTicket.styleName,
      startPrice: tourTicket.startPrice ?? 0,
      promotionTextLine1: tourTicket.promotionTextLine1,
      promotionTextLine2: tourTicket.promotionTextLine2,
      capsulePromotion: (tourTicket.capsulePromotion == null)
          ? null
          : List.generate(
              tourTicket.capsulePromotion!.length,
              (index) => TourSearchCapsulePromotion.mapFromCapsulePromotion(
                tourTicket.capsulePromotion![index],
              ),
            ),
    );
  }
}

class TourSearchCapsulePromotion {
  final String? name;
  final String? code;

  TourSearchCapsulePromotion({
    this.name,
    this.code,
  });

  factory TourSearchCapsulePromotion.mapFromCapsulePromotion(
          CapsulePromotion capsulePromotion) =>
      TourSearchCapsulePromotion(
        code: capsulePromotion.code,
        name: Helpers.truncateString(capsulePromotion.name, kMaxCapsuleLength),
      );
}

enum TourSearchResultViewState {
  initial,
  refreshLoading,
  loading,
  filterLoading,
  success,
  failure,
  failure1899,
  failure1999,
  internetFailure,
  internetFailureRefresh,
}
