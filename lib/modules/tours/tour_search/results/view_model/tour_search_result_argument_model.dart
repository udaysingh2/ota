import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_view_model.dart';
import 'package:ota/modules/tours/tour_search/search_filter/helper/tour_filter_helper.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

class TourSearchResultArgumentModel {
  String? userId;
  double? latitude;
  double? longitude;
  String? searchKey;
  int? pageNumber;
  int? pageSize;
  String playlistName;
  String? countryId;
  String? cityId;
  DateTime? serviceDate;
  TourFilterModel? tourfilterModel;
  TourFilterModel? ticketfilterModel;
  List<TourSearchResultModel>? tourSearchList;
  List<TourSearchResultModel>? ticketSearchList;
  TourFilterDataViewModel? tourfilterOption;
  TourFilterDataViewModel? ticketfilterOption;
  String? locationId;
  String? placeId;

  TourSearchResultArgumentModel({
    this.userId,
    this.latitude,
    this.longitude,
    this.searchKey,
    this.pageNumber,
    this.pageSize,
    required this.playlistName,
    this.cityId,
    this.countryId,
    this.serviceDate,
    this.tourfilterModel,
    this.ticketfilterModel,
    this.tourSearchList,
    this.ticketSearchList,
    this.tourfilterOption,
    this.ticketfilterOption,
    this.locationId,
    this.placeId,
  });

  factory TourSearchResultArgumentModel.from(
      String userId,
      double? lat,
      double? lng,
      String? searchKey,
      String playlistName,
      DateTime? serviceDate) {
    return TourSearchResultArgumentModel(
      userId: userId,
      latitude: lat,
      longitude: lng,
      searchKey: searchKey,
      playlistName: playlistName,
      serviceDate: serviceDate ?? DateTime.now().add(const Duration(days: 1)),
    );
  }

  bool get isLatLongAvailable => latitude != null && longitude != null;
}

class TourFilterModel {
  String sortingMode;
  bool availableTourAndTicketActivity;
  int? minPrice;
  int? maxPrice;
  List<String>? styleName;
  TourFilterModel({
    required this.sortingMode,
    this.availableTourAndTicketActivity = true,
    this.minPrice,
    this.maxPrice,
    this.styleName,
  });

  factory TourFilterModel.mapFromFilterScreenData(TourSearchFilterData data) =>
      TourFilterModel(
        sortingMode: data.selectedSortInfo?.categoryKey ??
            TourFilterHelperConst.rbhSuggest,
        maxPrice: data.rangeMaxPrice?.toInt(),
        minPrice: data.rangeMinPrice?.toInt(),
        styleName: TourFilterHelper.getSelectedStyleList(data.styleList),
        availableTourAndTicketActivity: false,
      );
}
