// To parse this JSON data, do
//
//     final carSearchHistoryModelDomain = carSearchHistoryModelDomainFromMap(jsonString);

import 'dart:convert';

class CarSearchHistoryModelDomain {
  CarSearchHistoryModelDomain({
    this.data,
  });

  final CarSearchHistoryModelDomainData? data;

  factory CarSearchHistoryModelDomain.fromJson(String str) => CarSearchHistoryModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarSearchHistoryModelDomain.fromMap(Map<String, dynamic> json) => CarSearchHistoryModelDomain(
    data: json["data"] == null ? null : CarSearchHistoryModelDomainData.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
  };
}

class CarSearchHistoryModelDomainData {
  CarSearchHistoryModelDomainData({
    this.getCarRentalRecentSearches,
  });

  final GetCarRentalRecentSearches? getCarRentalRecentSearches;

  factory CarSearchHistoryModelDomainData.fromString(String str) => CarSearchHistoryModelDomainData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarSearchHistoryModelDomainData.fromMap(Map<String, dynamic> json) => CarSearchHistoryModelDomainData(
    getCarRentalRecentSearches: json["getCarRentalRecentSearches"] == null ? null : GetCarRentalRecentSearches.fromMap(json["getCarRentalRecentSearches"]),
  );

  Map<String, dynamic> toMap() => {
    "getCarRentalRecentSearches": getCarRentalRecentSearches?.toMap(),
  };
}

class GetCarRentalRecentSearches {
  GetCarRentalRecentSearches({
    this.data,
    this.status,
  });

  final GetCarRentalRecentSearchesData? data;
  final Status? status;

  factory GetCarRentalRecentSearches.fromJson(String str) => GetCarRentalRecentSearches.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCarRentalRecentSearches.fromMap(Map<String, dynamic> json) => GetCarRentalRecentSearches(
    data: json["data"] == null ? null : GetCarRentalRecentSearchesData.fromMap(json["data"]),
    status: json["status"] == null ? null : Status.fromMap(json["status"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
    "status": status?.toMap(),
  };
}

class GetCarRentalRecentSearchesData {
  GetCarRentalRecentSearchesData({
    this.searchHistory,
  });

  final List<SearchHistory>? searchHistory;

  factory GetCarRentalRecentSearchesData.fromJson(String str) => GetCarRentalRecentSearchesData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCarRentalRecentSearchesData.fromMap(Map<String, dynamic> json) => GetCarRentalRecentSearchesData(
    searchHistory: json["searchHistory"] == null ? null : List<SearchHistory>.from(json["searchHistory"].map((x) => SearchHistory.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "searchHistory": searchHistory == null ? null : List<dynamic>.from(searchHistory!.map((x) => x.toMap())),
  };
}

class SearchHistory {
  SearchHistory({
    this.carRental,
  });

  final CarRental? carRental;

  factory SearchHistory.fromJson(String str) => SearchHistory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchHistory.fromMap(Map<String, dynamic> json) => SearchHistory(
    carRental: json["carRental"] == null ? null : CarRental.fromMap(json["carRental"]),
  );

  Map<String, dynamic> toMap() => {
    "carRental": carRental == null ? null : carRental!.toMap(),
  };
}

class CarRental {
  CarRental({
    this.carRecentSearchList,
  });

  final List<CarRecentSearchList>? carRecentSearchList;

  factory CarRental.fromJson(String str) => CarRental.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarRental.fromMap(Map<String, dynamic> json) => CarRental(
    carRecentSearchList: json["carRecentSearchList"] == null ? null : List<CarRecentSearchList>.from(json["carRecentSearchList"].map((x) => CarRecentSearchList.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "carRecentSearchList": carRecentSearchList == null ? null : List<dynamic>.from(carRecentSearchList!.map((x) => x.toMap())),
  };
}

class CarRecentSearchList {
  CarRecentSearchList({
    this.cityId,
    this.countryId,
    this.locationId,
    this.createdDate,
    this.updatedDate,
    this.searchKey,
  });

  final String? cityId;
  final String? countryId;
  final String? locationId;
  final String? createdDate;
  final String? updatedDate;
  final String? searchKey;

  factory CarRecentSearchList.fromJson(String str) => CarRecentSearchList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarRecentSearchList.fromMap(Map<String, dynamic> json) => CarRecentSearchList(
    cityId: json["cityId"],
    countryId: json["countryId"],
    locationId: json["locationId"],
    createdDate: json["createdDate"],
    updatedDate: json["updatedDate"],
    searchKey: json["searchKey"],
  );

  Map<String, dynamic> toMap() => {
    "cityId": cityId,
    "countryId": countryId,
    "locationId": locationId,
    "createdDate": createdDate,
    "updatedDate": updatedDate,
    "searchKey": searchKey,
  };
}

class Status {
  Status({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
    code: json["code"],
    header: json["header"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "header": header,
  };
}
