import 'dart:convert';

class LandingRecentSearchDomainModel {
  LandingRecentSearchDomainModel({
    this.data,
    this.status,
  });

  final GetCarRentalRecentSearchesData? data;
  final Status? status;
  factory LandingRecentSearchDomainModel.fromJson(String str) =>
      LandingRecentSearchDomainModel.fromMap(json.decode(str));

  factory LandingRecentSearchDomainModel.fromMap(Map<String, dynamic> json) =>
      LandingRecentSearchDomainModel(
        data: json["data"] == null
            ? null
            : GetCarRentalRecentSearchesData.fromMap(json["data"]),
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

  factory GetCarRentalRecentSearchesData.fromMap(Map<String, dynamic> json) =>
      GetCarRentalRecentSearchesData(
        searchHistory: List<SearchHistory>.from(
            json["searchHistory"].map((x) => SearchHistory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "searchHistory": searchHistory == null
            ? null
            : List<dynamic>.from(searchHistory!.map((x) => x.toMap())),
      };
}

class SearchHistory {
  SearchHistory({
    this.carRental,
  });

  final CarRental? carRental;

  factory SearchHistory.fromMap(Map<String, dynamic> json) => SearchHistory(
        carRental: json["carRental"] == null
            ? null
            : CarRental.fromMap(json["carRental"]),
      );

  Map<String, dynamic> toMap() => {
        "carRental": carRental?.toMap(),
      };
}

class CarRental {
  CarRental({
    this.carRecentSearchList,
  });

  final List<CarRecentSearchList>? carRecentSearchList;

  factory CarRental.fromMap(Map<String, dynamic> json) => CarRental(
        carRecentSearchList: json["carRecentSearchList"] == null
            ? null
            : List<CarRecentSearchList>.from(json["carRecentSearchList"]
                .map((x) => CarRecentSearchList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "carRecentSearchList": carRecentSearchList == null
            ? null
            : List<dynamic>.from(carRecentSearchList!.map((x) => x.toMap())),
      };
}

class CarRecentSearchList {
  CarRecentSearchList(
      {this.age,
      this.pickupLocationId,
      this.pickupLocationName,
      this.returnLocationName,
      this.pickupTime,
      this.returnTime,
      this.returnLocationId,
      this.pickupDate,
      this.returnDate});

  final int? age;
  final String? pickupLocationId;
  final String? pickupLocationName;
  final String? returnLocationName;
  final String? pickupTime;
  final String? returnTime;
  final String? returnLocationId;
  final String? pickupDate;
  final String? returnDate;

  factory CarRecentSearchList.fromMap(Map<String, dynamic> json) =>
      CarRecentSearchList(
          age: json["age"],
          pickupLocationId: json["pickupLocationId"],
          pickupLocationName: json["pickupLocationName"],
          returnLocationName: json["returnLocationName"],
          pickupTime: json["pickupTime"],
          returnTime: json["returnTime"],
          returnLocationId: json["returnLocationId"],
          pickupDate: json["pickupDate"],
          returnDate: json["returnDate"]);

  Map<String, dynamic> toMap() => {
        "age": age,
        "pickupLocationId": pickupLocationId,
        "pickupLocationName": pickupLocationName,
        "returnLocationName": returnLocationName,
        "pickupTime": pickupTime,
        "returnTime": returnTime,
        "returnLocationId": returnLocationId,
        "pickupDate": pickupDate,
        "returnDate": returnDate
      };
}

class Status {
  Status({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
      };
}
