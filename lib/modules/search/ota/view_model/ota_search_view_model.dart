import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_view_model.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';

class OtaSearchViewModel {
  OtaSearchModel? data;
  OtaSearchViewPageState pageState;
  OtaSearchViewModel({
    required this.pageState,
    this.data,
  });
}

enum OtaSearchViewPageState {
  loading,
  filterLoading,
  success,
  empty,
  failure,
  preLoaded,
  internetFailure
}

class OtaSearchModel {
  OtaSearchModel({
    this.lastPageFlag,
    this.hotelView,
    this.flightView,
    this.carView,
    this.tourView,
    this.ticketView,
  });

  // If lastPageFlag true then its last page no more data
  // If lastPageFlag false then its not last page more data available
  bool? lastPageFlag;
  HotelView? hotelView;
  FlightView? flightView;
  CarView? carView;
  TourView? tourView;
  TicketView? ticketView;

  OtaSearchModel.mapFromSearchDetail(GetOtaSearchResultData? searchDetailData) {
    lastPageFlag = searchDetailData?.lastPageFlag ?? true;
    hotelView = HotelView.mapFromHotelDetail(searchDetailData?.hotel);
    carView = CarView.mapFromCarDetail(searchDetailData?.car);
    flightView = FlightView.mapFromFlightDetail(searchDetailData?.flight);
    tourView = TourView.mapFromTourDetail(searchDetailData?.tourActivity);
    ticketView =
        TicketView.mapFromTicketDetail(searchDetailData?.ticketActivity);
  }
}

class HotelView {
  HotelView({
    this.hotelList,
    this.filter,
  });
  List<HotelListResult>? hotelList;
  FilterResult? filter;
  HotelView.mapFromHotelDetail(Hotel? hotel) {
    filter = FilterResult.mapFromFilterDetail(hotel?.filter);
    hotelList = List.generate(
        hotel?.hotelList?.length ?? 0,
        (index) => HotelListResult.mapFromHotelDetail(
            hotel?.hotelList?.elementAt(index)));
  }
}

class FlightView {
  FlightView();
  FlightView.mapFromFlightDetail(Flight? flight);
}

class CarView {
  CarView(this.carRental);
  CarRental? carRental;
  CarView.mapFromCarDetail(CarRental? car) {
    carRental = car;
  }
}

class FilterResult {
  FilterResult(
      {this.minPrice,
      this.maxPrice,
      this.rating = const [],
      this.reviewScore = const [],
      this.capsulePromotion = const [],
      this.availableHotel = false,
      this.sha = const []});

  int? minPrice;
  int? maxPrice;
  List<int> rating;
  List<double> reviewScore;
  List<CapsulePromotions> capsulePromotion;
  bool availableHotel;
  List<String> sha;
  factory FilterResult.mapFromFilterDetail(Filter? filter) {
    return FilterResult(
      minPrice: filter?.minPrice,
      maxPrice: filter?.maxPrice,
      rating: filter?.rating ?? [],
      reviewScore: filter?.reviewScore ?? [],
      sha: filter?.sha ?? [],
      capsulePromotion: List.generate(
          filter?.capsulePromotion?.length ?? 0,
          (index) => CapsulePromotions.mapFromCapsulePromotions(
              filter?.capsulePromotion?.elementAt(index))),
    );
  }
}

class CapsulePromotions {
  CapsulePromotions({
    this.name = "",
    this.code = "",
  });

  String name;
  String code;

  factory CapsulePromotions.mapFromCapsulePromotions(
      CapsulePromotion? promotion) {
    return CapsulePromotions(
      name: promotion?.name ?? "",
      code: promotion?.code ?? "",
    );
  }
}

class HotelListResult {
  HotelListResult({
    this.sortSequence,
    this.hotelId,
    this.hotelName = "",
    this.hotelImage = "",
    this.rating,
    this.address = "",
    this.totalPrice,
    this.pricePerNight,
    this.ratingTitle = "",
    this.reviewText = "",
    this.offerPercent = "",
    this.score = "",
    this.discount = "",
    this.adminPromotionLine1 = "",
    this.adminPromotionLine2 = "",
    this.priceWithoutDiscount,
    this.maxDiscount,
    this.capsulePromotions = const [],
    this.infoPromotions = const [],
  });

  int? sortSequence;
  String? hotelId;
  String hotelName;
  String hotelImage;
  int? rating;
  String address;
  double? totalPrice;
  double? pricePerNight;
  String ratingTitle;
  String reviewText;
  String offerPercent;
  String score;
  String discount;
  String adminPromotionLine1;
  String adminPromotionLine2;
  double? priceWithoutDiscount;
  int? maxDiscount;
  List<String> capsulePromotions;
  List<String> infoPromotions;

  factory HotelListResult.mapFromHotelDetail(HotelList? hotelList) {
    return HotelListResult(
      sortSequence: hotelList?.sortSequence,
      hotelId: hotelList?.hotelId,
      hotelName: hotelList?.hotelName ?? "",
      hotelImage: hotelList?.hotelImage ?? "",
      rating: hotelList?.rating,
      address: hotelList?.address ?? "",
      totalPrice: hotelList?.totalPrice,
      pricePerNight: hotelList?.pricePerNight,
      ratingTitle: hotelList?.ratingTitle ?? "",
      reviewText: hotelList?.reviewText ?? "",
      offerPercent: hotelList?.offerPercent ?? "",
      score: hotelList?.score ?? "",
      discount: hotelList?.discount ?? "",
      adminPromotionLine1: hotelList?.adminPromotionLine1 ?? "",
      adminPromotionLine2: hotelList?.adminPromotionLine2 ?? "",
      priceWithoutDiscount: hotelList?.rackRate,
      maxDiscount: hotelList?.percentageDiscount,
      infoPromotions: hotelList?.infotech11Promo ?? [],
      capsulePromotions: _getcapsulePromotionsList(
        hotelList?.capsulePromotion ?? [],
      ),
    );
  }
}

List<String> _getcapsulePromotionsList(
    List<CapsulePromotion> capsulePromotion) {
  List<String> capsulePromotions = [];
  capsulePromotions = List.generate(capsulePromotion.length, (index) {
    CapsulePromotions list = CapsulePromotions.mapFromCapsulePromotions(
        capsulePromotion.elementAt(index));
    return list.name;
  });

  return capsulePromotions;
}

class TourView {
  TourView({
    this.activityList,
    this.activityfilter,
  });
  List<TnaActivityList>? activityList;
  TnaActivityFilter? activityfilter;

  TourView.mapFromTourDetail(TourActivity? activity) {
    activityfilter = TnaActivityFilter.mapFromActivityFilter(activity?.filter);
    activityList = List.generate(
        activity?.tourActivityList?.length ?? 0,
        (index) => TnaActivityList.fromActivityListDomain(
            activity!.tourActivityList!.elementAt(index)));
  }
}

class TicketView {
  TicketView({
    this.activityList,
    this.activityfilter,
  });
  List<TnaActivityList>? activityList;
  TnaActivityFilter? activityfilter;

  TicketView.mapFromTicketDetail(TicketActivity? activity) {
    activityfilter = TnaActivityFilter.mapFromActivityFilter(activity?.filter);
    activityList = List.generate(
        activity?.ticketActivityList?.length ?? 0,
        (index) => TnaActivityList.fromActivityListDomain(
            activity!.ticketActivityList!.elementAt(index)));
  }
}

class TnaActivityList {
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
  final List<TnaCapsulePromotion>? capsulePromotion;

  TnaActivityList({
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

  TourSearchResultModel toTourSearchModel() {
    return TourSearchResultModel(
      category: category,
      cityId: cityId,
      cityName: cityName,
      countryId: countryId,
      countryName: countryName,
      id: id,
      imageUrl: imageUrl,
      locationName: locationName,
      name: name,
      startPrice: startPrice,
      promotionTextLine1: promotionTextLine1,
      promotionTextLine2: promotionTextLine2,
      capsulePromotion: getCapsulePromotionList(capsulePromotion),
    );
  }

  factory TnaActivityList.fromActivityListDomain(ActivityList activityList) =>
      TnaActivityList(
        category: activityList.styleName,
        cityId: activityList.cityId!,
        cityName: activityList.cityName,
        countryId: activityList.countryId!,
        countryName: activityList.countryName!,
        id: activityList.id!,
        imageUrl: activityList.imageUrl ?? '',
        locationName: activityList.locationName,
        name: activityList.name!,
        startPrice: activityList.startPrice ?? 0,
        promotionTextLine1: activityList.promotionTextLine1,
        promotionTextLine2: activityList.promotionTextLine2,
        capsulePromotion: (activityList.capsulePromotion == null ||
                activityList.capsulePromotion!.isEmpty)
            ? null
            : List.generate(
                activityList.capsulePromotion!.length,
                (index) => TnaCapsulePromotion.mapFromCapsulePromotion(
                  activityList.capsulePromotion![index],
                ),
              ),
      );
}

class TnaCapsulePromotion {
  final String? name;
  final String? code;

  TnaCapsulePromotion({
    this.name,
    this.code,
  });

  factory TnaCapsulePromotion.mapFromCapsulePromotion(
          CapsulePromotion capsulePromotion) =>
      TnaCapsulePromotion(
        code: capsulePromotion.code,
        name: capsulePromotion.name,
      );

  TourSearchCapsulePromotion toTourSearchCapsulePromotion() {
    return TourSearchCapsulePromotion(
      code: code,
      name: name,
    );
  }
}

List<TourSearchCapsulePromotion>? getCapsulePromotionList(
    List<TnaCapsulePromotion>? capsulePromotions) {
  if (capsulePromotions == null || capsulePromotions.isEmpty) {
    return null;
  }
  return List.generate(
    capsulePromotions.length,
    (index) => capsulePromotions[index].toTourSearchCapsulePromotion(),
  );
}

class TnaActivityFilter {
  double? minPrice;
  double? maxPrice;
  List<String>? styleList;
  TnaActivityFilter({
    this.maxPrice,
    this.minPrice,
    this.styleList,
  });

  TourFilterDataViewModel toTourFilterDataModel() {
    return TourFilterDataViewModel(
      maxPrice: maxPrice,
      minPrice: minPrice,
      styleList: styleList,
    );
  }

  TnaActivityFilter.mapFromActivityFilter(ActivityFilter? filter) {
    maxPrice = filter?.maxPrice;
    minPrice = filter?.minPrice;
    styleList = filter?.styleName;
  }
}
