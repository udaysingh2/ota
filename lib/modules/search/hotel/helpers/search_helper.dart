import 'package:flutter/material.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/modules/search/hotel/helpers/search_suggestion_type.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_recommendation_view_model.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_suggestion_view_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_recommendation_view_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_suggestion_view_model.dart';

class SearchHelper {
  static List<HotelSuggestionModel> getHotelSuggestionViewModelList({
    List<City>? cityLocationList,
    List<Hotel>? hotelList,
  }) {
    List<HotelSuggestionModel> suggestionViewModelList = [];

    if (cityLocationList != null && cityLocationList.isNotEmpty) {
      suggestionViewModelList = List<HotelSuggestionModel>.generate(
        cityLocationList.length,
        (index) => HotelSuggestionModel.fromSuggestion(
            cityLocationModel: cityLocationList[index]),
      );
    }

    if (hotelList != null && hotelList.isNotEmpty) {
      suggestionViewModelList = List<HotelSuggestionModel>.generate(
        hotelList.length,
        (index) =>
            HotelSuggestionModel.fromSuggestion(hotelModel: hotelList[index]),
      );
    }

    /// Ignore items whose name propery has empty value and return remaining
    return suggestionViewModelList
        .where((element) => element.name.isNotEmpty)
        .toList();
  }

  /// For Hotel - displayText
  /// For CityLocation - keyword
  static dynamic getSuggestionViewModel(SearchServiceType serviceType,
      {City? cityLocationModel, Hotel? hotelModel}) {
    String id;
    String name;
    SearchSuggestionType type;
    String? hotelId;
    String? cityId;
    String? locationId;
    String? countryId;

    if (hotelModel != null) {
      id = hotelModel.hotelId ?? '';
      name = hotelModel.displayText ?? '';
      type = SearchSuggestionType.hotel;
      hotelId = hotelModel.hotelId;
      cityId = hotelModel.cityId;
      locationId = hotelModel.locationId;
      countryId = hotelModel.countryId;
    } else {
      id = cityLocationModel?.id ?? '';
      name = cityLocationModel?.keyword ?? '';
      type = SearchSuggestionType.cityLocation;
      cityId = cityLocationModel?.cityId;
      countryId = cityLocationModel?.countryId;
    }
    if (serviceType == SearchServiceType.hotel) {
      return HotelSuggestionModel(
        id: id,
        name: name,
        searchSuggestionType: type,
        hotelId: hotelId,
        cityId: cityId,
        countryId: countryId,
        locationId: locationId,
      );
    } else {
      return OtaSuggestionModel(
        id: id,
        name: name,
        searchSuggestionType: type,
        hotelId: hotelId,
        cityId: cityId,
        countryId: countryId,
        locationId: locationId,
      );
    }
  }

  static List<OtaSuggestionModel> getOtaSuggestionViewModelList({
    List<City>? cityLocationList,
  }) {
    List<OtaSuggestionModel>? suggestionViewModelList = [];

    if (cityLocationList != null && cityLocationList.isNotEmpty) {
      suggestionViewModelList = List<OtaSuggestionModel>.generate(
        cityLocationList.length,
        (index) => OtaSuggestionModel.fromSuggestion(
            cityLocationModel: cityLocationList[index]),
      );
    }

    /// Ignore items whose name propery has empty value and return remaining
    return suggestionViewModelList
        .where((element) => element.name.isNotEmpty)
        .toList();
  }

  static HotelRecommendationViewModel getHotelRecommendationViewModel(
      GetSearchRecommendation data) {
    List<Recommendation>? recommendedHotels = data.data?.recommendations;
    List<HotelRecommendationModel> hotelList;
    List<HotelSearchHistoryModel> historyHotelList;
    if (data.data == null ||
        data.data?.recommendations == null ||
        data.data!.recommendationKey == null ||
        data.data!.recommendationKey!.isEmpty) {
      hotelList = [];
    } else {
      hotelList = List<HotelRecommendationModel>.generate(
          recommendedHotels!.length,
          (index) =>
              HotelRecommendationModel.mapFromModel(recommendedHotels[index]));
    }
    historyHotelList = getHotelSearchHistoryList(data);
    return HotelRecommendationViewModel(
        recommendationList: hotelList, searchHistoryList: historyHotelList);
  }

  static HotelRecommendationViewModel getRecommendationViewModel(
      GetHotelSearchRecommendation data) {
    List<HotelRecommendation>? recommendedHotels = data.data?.recommendations;
    List<HotelRecommendationModel> hotelList;
    List<HotelSearchHistoryModel> historyHotelList;
    if (data.data == null ||
        data.data?.recommendations == null ||
        data.data!.recommendationKey == null ||
        data.data!.recommendationKey!.isEmpty) {
      hotelList = [];
    } else {
      hotelList = List<HotelRecommendationModel>.generate(
          recommendedHotels!.length,
          (index) => HotelRecommendationModel.mapFromHotelModel(
              recommendedHotels[index]));
    }
    historyHotelList = getSearchHistoryList(data);
    return HotelRecommendationViewModel(
        recommendationList: hotelList, searchHistoryList: historyHotelList);
  }

  static List<HotelSearchHistoryModel> getHotelSearchHistoryList(
      GetSearchRecommendation data) {
    List<SearchHistory>? searchHistoryData = data.data?.searchHistory;
    List<HotelSearchHistoryModel> hotelList;
    if (data.data == null || data.data?.searchHistory == null) {
      hotelList = [];
    } else {
      hotelList = List<HotelSearchHistoryModel>.generate(
          searchHistoryData!.length,
          (index) =>
              HotelSearchHistoryModel.mapFromModel(searchHistoryData[index]));
    }
    return hotelList;
  }

  static List<HotelSearchHistoryModel> getSearchHistoryList(
      GetHotelSearchRecommendation data) {
    List<HotelSearchHistory>? searchHistoryData = data.data?.searchHistory;
    List<HotelSearchHistoryModel> hotelList;
    if (data.data == null || data.data?.searchHistory == null) {
      hotelList = [];
    } else {
      hotelList = List<HotelSearchHistoryModel>.generate(
          searchHistoryData!.length,
          (index) => HotelSearchHistoryModel.mapFromHotelModel(
              searchHistoryData[index]));
    }
    return hotelList;
  }

  static OtaRecommendationViewModel getOtaRecommendationViewModel(
      GetSearchRecommendation data) {
    List<Recommendation>? recommendedHotels = data.data?.recommendations;
    List<OtaRecommendationModel> hotelList;
    List<OtaSearchHistoryModel> historyHotelList;
    if (data.data == null ||
        data.data?.recommendations == null ||
        data.data!.recommendations!.isEmpty ||
        data.data!.recommendationKey == null) {
      hotelList = [];
    } else {
      hotelList = List<OtaRecommendationModel>.generate(
          recommendedHotels!.length,
          (index) =>
              OtaRecommendationModel.mapFromModel(recommendedHotels[index]));
    }
    historyHotelList = getOtaSearchHistoryList(data);
    return OtaRecommendationViewModel(
        recommendationList: hotelList, searchHistoryList: historyHotelList);
  }

  static List<OtaSearchHistoryModel> getOtaSearchHistoryList(
      GetSearchRecommendation data) {
    List<SearchHistory>? searchHistoryData = data.data?.searchHistory;
    List<OtaSearchHistoryModel> hotelList;
    if (data.data == null || data.data?.searchHistory == null) {
      hotelList = [];
    } else {
      hotelList = List<OtaSearchHistoryModel>.generate(
          searchHistoryData!.length,
          (index) =>
              OtaSearchHistoryModel.mapFromModel(searchHistoryData[index]));
    }
    return hotelList;
  }

  // get formatted date 8 - 9 Jan
  static String getdate(
      BuildContext context, String? checkInDate, String? checkOutDate) {
    if (checkInDate == null ||
        checkOutDate == null ||
        checkInDate.isEmpty ||
        checkOutDate.isEmpty) {
      return "";
    }
    DateTime checkIn = Helpers().parseDateTime(checkInDate);
    DateTime checkOut = Helpers().parseDateTime(checkOutDate);
    int dateCheckIn = checkIn.day;
    int dateCheckOut = checkOut.day;
    String monthCheckOut =
        getTranslated(context, Helpers.getMonthShortKey(checkOut.month));
    return dateCheckIn.toString().addTrailingDash() +
        dateCheckOut.toString() +
        monthCheckOut.addLeadingSpace();
  }
}
