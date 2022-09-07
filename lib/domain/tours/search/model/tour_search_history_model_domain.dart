import 'dart:convert';

class TourSearchHistoryModelDomain {
  TourSearchHistoryModelDomain({
    this.getTourAndTicketRecentSearches,
  });

  final TourSearchHistoryData? getTourAndTicketRecentSearches;

  factory TourSearchHistoryModelDomain.fromJson(String str) =>
      TourSearchHistoryModelDomain.fromMap(json.decode(str));

  factory TourSearchHistoryModelDomain.fromMap(Map<String, dynamic> json) =>
      TourSearchHistoryModelDomain(
        getTourAndTicketRecentSearches:
            json["getTourAndTicketRecentSearches"] == null
                ? null
                : TourSearchHistoryData.fromJson(
                    json["getTourAndTicketRecentSearches"]),
      );
}

class TourSearchHistoryData {
  TourSearchHistoryData({
    this.data,
    this.status,
  });

  final TourSearcheHistoryModel? data;
  final Status? status;

  factory TourSearchHistoryData.fromJson(Map<String, dynamic> json) =>
      TourSearchHistoryData(
        data: json["data"] == null
            ? null
            : TourSearcheHistoryModel.fromJson(json["data"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );
}

class TourSearcheHistoryModel {
  TourSearcheHistoryModel({
    this.searchHistory,
  });

  final List<SearchHistory>? searchHistory;

  factory TourSearcheHistoryModel.fromJson(Map<String, dynamic> json) =>
      TourSearcheHistoryModel(
        searchHistory: json["searchHistory"] == null
            ? []
            : List<SearchHistory>.from(
                json["searchHistory"].map((x) => SearchHistory.fromJson(x))),
      );
}

class SearchHistory {
  SearchHistory({
    this.serviceType,
    this.keyword,
    this.countryId,
    this.cityId,
    this.placeId,
    this.locationName,
  });

  final String? serviceType;
  final String? keyword;
  final String? countryId;
  final String? cityId;
  final String? placeId;
  final String? locationName;

  factory SearchHistory.fromJson(Map<String, dynamic> json) => SearchHistory(
        serviceType: json["serviceType"],
        keyword: json["keyword"],
        countryId: json["countryId"],
        cityId: json["cityId"],
        placeId: json["placeId"],
        locationName: json["locationName"],
      );
}

class Status {
  Status({
    this.code,
    this.header,
    this.description,
  });

  final String? code;
  final String? header;
  final String? description;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
        description: json["description"],
      );
}
