// To parse this JSON data, do
//
//     final staticPlaylistModel = staticPlaylistModelFromMap(jsonString);

import 'dart:convert';

class StaticPlaylistModelDomain {
  StaticPlaylistModelDomain({
    this.getStaticPlaylists,
  });

  final GetStaticPlaylists? getStaticPlaylists;

  factory StaticPlaylistModelDomain.fromJson(String str) => StaticPlaylistModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StaticPlaylistModelDomain.fromMap(Map<String, dynamic> json) => StaticPlaylistModelDomain(
        getStaticPlaylists: json["getStaticPlaylists"] == null
            ? null
            : GetStaticPlaylists.fromMap(json["getStaticPlaylists"]),
      );

  Map<String, dynamic> toMap() => {
        "getStaticPlaylists": getStaticPlaylists?.toMap(),
      };
}

class GetStaticPlaylists {
  GetStaticPlaylists({
    this.data,
    this.status,
  });

  final List<Datum>? data;
  final Status? status;

  factory GetStaticPlaylists.fromJson(String str) =>
      GetStaticPlaylists.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetStaticPlaylists.fromMap(Map<String, dynamic> json) =>
      GetStaticPlaylists(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "status": status?.toMap(),
      };
}

class Datum {
  Datum({
    this.serviceName,
    this.source,
    this.playList,
  });

  final String? serviceName;
  final String? source;
  final List<PlayList>? playList;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        serviceName: json["serviceName"],
        source: json["source"],
        playList: json["playList"] == null
            ? null
            : List<PlayList>.from(
                json["playList"].map((x) => PlayList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "serviceName": serviceName,
        "source": source,
        "playList": playList == null
            ? null
            : List<dynamic>.from(playList!.map((x) => x.toMap())),
      };
}

class PlayList {
  PlayList({
    this.name,
    this.list,
  });

  final String? name;
  final List<ListElement>? list;

  factory PlayList.fromJson(String str) => PlayList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayList.fromMap(Map<String, dynamic> json) => PlayList(
        name: json["name"],
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "list": list == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toMap())),
      };
}

class ListElement {
  ListElement({
    this.hotelName,
    this.hotelId,
    this.address,
    this.rating,
    this.review,
    this.promotion,
    this.image,
    this.adminPromotion,
  });

  final String? hotelName;
  final String? hotelId;
  final Address? address;
  final double? rating;
  final Review? review;
  final List<Promotion>? promotion;
  final String? image;
  final AdminPromotion? adminPromotion;

  factory ListElement.fromJson(String str) =>
      ListElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
        hotelName: json["hotelName"],
        hotelId: json["hotelId"],
        address:
            json["address"] == null ? null : Address.fromMap(json["address"]),
        rating: json["rating"].toDouble(),
        review: json["review"] == null ? null : Review.fromMap(json["review"]),
        promotion: json["promotion"] == null
            ? null
            : List<Promotion>.from(
                json["promotion"].map((x) => Promotion.fromMap(x))),
        image: json["image"],
        adminPromotion: json["adminPromotion"] == null
            ? null
            : AdminPromotion.fromMap(json["adminPromotion"]),
      );

  Map<String, dynamic> toMap() => {
        "hotelName": hotelName,
        "hotelId": hotelId,
        "address": address?.toMap(),
        "rating": rating,
        "review": review?.toMap(),
        "promotion": promotion == null
            ? null
            : List<dynamic>.from(promotion!.map((x) => x.toMap())),
        "image": image,
        "adminPromotion": adminPromotion?.toMap(),
      };
}

class Address {
  Address({
    this.address1,
    this.locationId,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.countryName,
  });

  final String? address1;
  final String? locationId;
  final String? locationName;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  final String? countryName;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        address1: json["address1"],
        locationId: json["locationId"],
        locationName: json["locationName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
        countryName: json["countryName"],
      );

  Map<String, dynamic> toMap() => {
        "address1": address1,
        "locationId": locationId,
        "locationName": locationName,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
        "countryName": countryName,
      };
}

class Review {
  Review({
    this.score,
    this.numReview,
    this.description,
  });

  final num? score;
  final int? numReview;
  final String? description;

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        score: json["score"],
        numReview: json["numReview"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "score": score,
        "numReview": numReview,
        "description": description,
      };
}

class Promotion {
  Promotion({
    this.promotionText,
  });

  final String? promotionText;

  factory Promotion.fromJson(String str) => Promotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Promotion.fromMap(Map<String, dynamic> json) => Promotion(
        promotionText: json["promotionText"],
      );

  Map<String, dynamic> toMap() => {
        "promotionText": promotionText,
      };
}

class AdminPromotion {
  AdminPromotion({
    this.adminPromotionLine1,
    this.adminPromotionLine2,
    this.promotionText1,
    this.promotionText2,
  });

  final dynamic adminPromotionLine1;
  final dynamic adminPromotionLine2;
  final String? promotionText1;
  final String? promotionText2;

  factory AdminPromotion.fromJson(String str) =>
      AdminPromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminPromotion.fromMap(Map<String, dynamic> json) => AdminPromotion(
        adminPromotionLine1: json["adminPromotionLine1"],
        adminPromotionLine2: json["adminPromotionLine2"],
        promotionText1: json["promotionText1"],
        promotionText2: json["promotionText2"],
      );

  Map<String, dynamic> toMap() => {
        "adminPromotionLine1": adminPromotionLine1,
        "adminPromotionLine2": adminPromotionLine2,
        "promotionText1": promotionText1,
        "promotionText2": promotionText2,
      };
}

class Status {
  Status({
    this.header,
    this.code,
    this.description,
    this.errors,
  });

  final String? header;
  final String? code;
  final String? description;
  final String? errors;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        header: json["header"],
        code: json["code"],
        description: json["description"],
        errors: json["errors"],
      );

  Map<String, dynamic> toMap() => {
        "header": header,
        "code": code,
        "description": description,
        "errors": errors,
      };
}
