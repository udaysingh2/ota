// To parse this JSON data, do
//
//     final otaSearch = otaSearchFromMap(jsonString);

import 'dart:convert';

class OtaSearchAutomation {
  OtaSearchAutomation({
    this.data,
  });

  final OtaSearchDataAutomation? data;

  factory OtaSearchAutomation.fromJson(String str) =>
      OtaSearchAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaSearchAutomation.fromMap(Map<String, dynamic> json) =>
      OtaSearchAutomation(
        data: json["data"] == null
            ? null
            : OtaSearchDataAutomation.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}

class OtaSearchDataAutomation {
  OtaSearchDataAutomation({
    this.getSearchDetail,
  });

  final GetSearchDetailAutomation? getSearchDetail;

  factory OtaSearchDataAutomation.fromJson(String str) =>
      OtaSearchDataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaSearchDataAutomation.fromMap(Map<String, dynamic> json) =>
      OtaSearchDataAutomation(
        getSearchDetail: json["getOtaSearchResult"] == null
            ? null
            : GetSearchDetailAutomation.fromMap(json["getOtaSearchResult"]),
      );

  Map<String, dynamic> toMap() => {
        "getOtaSearchResult":
            getSearchDetail == null ? null : getSearchDetail!.toMap(),
      };
}

class GetSearchDetailAutomation {
  GetSearchDetailAutomation({
    this.status,
    this.data,
  });

  final Status? status;
  final GetSearchDetailDataAutomation? data;

  factory GetSearchDetailAutomation.fromJson(String str) =>
      GetSearchDetailAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSearchDetailAutomation.fromMap(Map<String, dynamic> json) =>
      GetSearchDetailAutomation(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null
            ? null
            : GetSearchDetailDataAutomation.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
        "data": data == null ? null : data!.toMap(),
      };
}

class GetSearchDetailDataAutomation {
  GetSearchDetailDataAutomation({
    this.hotel,
    this.flight,
    this.car,
  });

  final Hotel? hotel;
  final Flight? flight;
  final Car? car;

  factory GetSearchDetailDataAutomation.fromJson(String str) =>
      GetSearchDetailDataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSearchDetailDataAutomation.fromMap(Map<String, dynamic> json) =>
      GetSearchDetailDataAutomation(
        hotel: json["hotel"] == null ? null : Hotel.fromMap(json["hotel"]),
        flight: json["flight"] == null ? null : Flight.fromMap(json["flight"]),
        car: json["car"] == null ? null : Car.fromMap(json["car"]),
      );

  Map<String, dynamic> toMap() => {
        "hotel": hotel == null ? null : hotel!.toMap(),
        "flight": flight == null ? null : flight!.toMap(),
        "car": car == null ? null : car!.toMap(),
      };
}

class Flight {
  Flight();

  factory Flight.fromJson(String str) => Flight.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Flight.fromMap(Map<String, dynamic> json) => Flight();

  Map<String, dynamic> toMap() => {};
}

class Car {
  Car();

  factory Car.fromJson(String str) => Car.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Car.fromMap(Map<String, dynamic> json) => Car();

  Map<String, dynamic> toMap() => {};
}

class Hotel {
  Hotel({
    this.hotelList,
    this.filter,
  });

  final List<HotelList>? hotelList;
  final Filter? filter;

  factory Hotel.fromJson(String str) => Hotel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Hotel.fromMap(Map<String, dynamic> json) => Hotel(
        hotelList: json["hotelList"] == null
            ? null
            : List<HotelList>.from(
                json["hotelList"].map((x) => HotelList.fromMap(x))),
        filter: json["filter"] == null ? null : Filter.fromMap(json["filter"]),
      );

  Map<String, dynamic> toMap() => {
        "hotelList": hotelList == null
            ? null
            : List<dynamic>.from(hotelList!.map((x) => x.toMap())),
        "filter": filter == null ? null : filter!.toMap(),
      };
}

class Filter {
  Filter({
    this.minPrice,
    this.maxPrice,
    this.rating,
    this.promotion,
    this.reviewScore,
  });

  final int? minPrice;
  final int? maxPrice;
  final List<int>? rating;
  final List<dynamic>? promotion;
  final List<int>? reviewScore;

  factory Filter.fromJson(String str) => Filter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Filter.fromMap(Map<String, dynamic> json) => Filter(
        minPrice: json["minPrice"] == null ? null : json["minPrice"],
        maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
        rating: json["rating"] == null
            ? null
            : List<int>.from(json["rating"].map((x) => x)),
        promotion: json["promotion"] == null
            ? null
            : List<dynamic>.from(json["promotion"].map((x) => x)),
        reviewScore: json["reviewScore"] == null
            ? null
            : List<int>.from(json["reviewScore"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "minPrice": minPrice == null ? null : minPrice,
        "maxPrice": maxPrice == null ? null : maxPrice,
        "rating":
            rating == null ? null : List<dynamic>.from(rating!.map((x) => x)),
        "promotion": promotion == null
            ? null
            : List<dynamic>.from(promotion!.map((x) => x)),
        "reviewScore": reviewScore == null
            ? null
            : List<dynamic>.from(reviewScore!.map((x) => x)),
      };
}

class HotelList {
  HotelList({
    this.sortSequence,
    this.hotelId,
    this.hotelName,
    this.hotelImage,
    this.rating,
    this.address,
    this.totalPrice,
    this.pricePerNight,
    this.ratingTitle,
    this.reviewText,
    this.offerPercent,
    this.score,
    this.discount,
  });

  final int? sortSequence;
  final String? hotelId;
  final String? hotelName;
  final String? hotelImage;
  final int? rating;
  final String? address;
  final double? totalPrice;
  final double? pricePerNight;
  final String? ratingTitle;
  final String? reviewText;
  final String? offerPercent;
  final String? score;
  final String? discount;
  factory HotelList.fromJson(String str) => HotelList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelList.fromMap(Map<String, dynamic> json) => HotelList(
        sortSequence:
            json["sortSequence"] == null ? null : json["sortSequence"],
        hotelId: json["hotelId"] == null ? null : json["hotelId"],
        hotelName: json["hotelName"] == null ? null : json["hotelName"],
        hotelImage: json["hotelImage"] == null ? null : json["hotelImage"],
        rating: json["rating"] == null ? null : json["rating"],
        address: json["address"] == null ? null : json["address"],
        ratingTitle: json["ratingTitle"] == null ? null : json["ratingTitle"],
        reviewText: json["reviewText"] == null ? null : json["reviewText"],
        offerPercent:
            json["offerPercent"] == null ? null : json["offerPercent"],
        score: json["score"] == null ? null : json["score"],
        discount: json["discount"] == null ? null : json["discount"],
        totalPrice:
            json["totalPrice"] == null ? null : json["totalPrice"].toDouble(),
        pricePerNight: json["pricePerNight"] == null
            ? null
            : json["pricePerNight"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "sortSequence": sortSequence == null ? null : sortSequence,
        "hotelId": hotelId == null ? null : hotelId,
        "hotelName": hotelName == null ? null : hotelName,
        "hotelImage": hotelImage == null ? null : hotelImage,
        "rating": rating == null ? null : rating,
        "address": address == null ? null : address,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "pricePerNight": pricePerNight == null ? null : pricePerNight,
        "ratingTitle": ratingTitle == null ? null : ratingTitle,
        "reviewText": reviewText == null ? null : reviewText,
        "offerPercent": offerPercent == null ? null : offerPercent,
        "score": score == null ? null : score,
        "discount": discount == null ? null : discount,
      };
}

class Status {
  Status({
    this.code,
    this.description,
    this.header,
  });

  final String? code;
  final String? description;
  final String? header;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"] == null ? null : json["code"],
        description: json["description"] == null ? null : json["description"],
        header: json["header"] == null ? null : json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "description": description == null ? null : description,
        "header": header == null ? null : header,
      };
}
