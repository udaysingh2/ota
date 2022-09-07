import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/modules/tours/tour_search/results/helpers/tour_search_result_helper.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_argument_model.dart';

const kMaxLimit = 1000000;

class TourSearchResultArgumentDomain {
  String userId;
  double? latitude;
  double? longitude;
  String? searchKey;
  String playlistName;
  // True for tour/ticket search, false for ota search
  bool searchAvailableApi;
  String? countryId;
  String? cityId;
  String serviceDate;
  int pageNumber;
  int pageSize;
  Filter? filter;
  String? locationId;
  String? placeId;

  TourSearchResultArgumentDomain({
    required this.userId,
    this.latitude,
    this.longitude,
    this.searchKey,
    required this.playlistName,
    this.searchAvailableApi = false,
    required this.serviceDate,
    required this.cityId,
    required this.countryId,
    required this.pageNumber,
    required this.pageSize,
    this.filter,
    this.locationId,
    this.placeId,
  });

  factory TourSearchResultArgumentDomain.fromArgument(
      TourSearchResultArgumentModel argument) {
    return TourSearchResultArgumentDomain(
      userId: argument.userId!,
      latitude: argument.latitude,
      longitude: argument.longitude,
      searchKey: argument.searchKey,
      playlistName: argument.playlistName,
      cityId: argument.cityId,
      countryId: argument.countryId,
      pageNumber: argument.pageNumber!,
      pageSize: argument.pageSize!,
      serviceDate: Helpers.getYYYYmmddFromDateTime(
          TourSearchResultHelper.getServiceDate(argument)),
      filter: TourSearchResultHelper.getFilter(argument),
      searchAvailableApi: TourSearchResultHelper.isDateSelected(argument),
      locationId: argument.locationId,
      placeId: argument.placeId,
    );
  }

  Map<String, dynamic> toMap() => {
        if (latitude != null) "latitude": latitude,
        if (longitude != null) "longitude": longitude,
        if (searchKey != null) "searchKey": searchKey!.addQuote(),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "playlistName": playlistName.addQuote(),
        "searchAvailableApi": searchAvailableApi,
        if (countryId != null) "countryId": countryId!.addQuote(),
        if (cityId != null) "cityId": cityId!.addQuote(),
        if (locationId != null) "locationId": locationId!.addQuote(),
        if (placeId != null) "placeId": placeId!.addQuote(),
        "serviceDate": serviceDate.addQuote(),
        if (filter != null) "filter": filter!.toMap(),
      };
}

class Filter {
  String sortingMode;
  bool availableTourAndTicketActivity;
  int minPrice;
  int maxPrice;
  List<String>? styleName;
  Filter({
    required this.sortingMode,
    this.availableTourAndTicketActivity = false,
    required this.minPrice,
    required this.maxPrice,
    this.styleName,
  });

  factory Filter.toDefault(TourSearchResultArgumentModel argument) {
    return Filter(
      sortingMode: 'rbh_suggest',
      minPrice: 0,
      maxPrice: kMaxLimit,
      styleName: null,
      availableTourAndTicketActivity:
          TourSearchResultHelper.isDateSelected(argument),
    );
  }

  factory Filter.formArgumentModel(
      TourFilterModel tourFilterModel, bool availableTourAndTicketActivity) {
    return Filter(
      sortingMode: tourFilterModel.sortingMode,
      maxPrice: tourFilterModel.maxPrice ?? kMaxLimit,
      minPrice: tourFilterModel.minPrice ?? 0,
      styleName: tourFilterModel.styleName,
      availableTourAndTicketActivity: availableTourAndTicketActivity,
    );
  }

  Map<String, dynamic> toMap() => {
        "sortingMode": sortingMode.addQuote(),
        "availableTourAndTicketActivity": availableTourAndTicketActivity,
        "minPrice": minPrice,
        "maxPrice": maxPrice,
        if (styleName != null)
          "styleName": styleName!.map((x) => x.addQuote()).toList(),
      };
}
