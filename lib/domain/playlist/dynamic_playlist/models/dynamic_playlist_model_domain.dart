// To parse this JSON data, do
//
//     final dynamicPlaylistModel = dynamicPlaylistModelFromMap(jsonString);

import 'dart:convert';

class DynamicPlaylistModel {
  DynamicPlaylistModel({
    this.getDynamicPlaylists,
  });

  final GetDynamicPlaylists? getDynamicPlaylists;

  factory DynamicPlaylistModel.fromJson(String str) =>
      DynamicPlaylistModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DynamicPlaylistModel.fromMap(Map<String, dynamic> json) =>
      DynamicPlaylistModel(
        getDynamicPlaylists: json["getDynamicPlaylists"] == null
            ? null
            : GetDynamicPlaylists.fromMap(json["getDynamicPlaylists"]),
      );

  Map<String, dynamic> toMap() => {
        "getDynamicPlaylists": getDynamicPlaylists?.toMap(),
      };
}

class GetDynamicPlaylists {
  GetDynamicPlaylists({
    this.data,
    this.status,
  });

  final List<Datum>? data;
  final Status? status;

  factory GetDynamicPlaylists.fromJson(String str) =>
      GetDynamicPlaylists.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDynamicPlaylists.fromMap(Map<String, dynamic> json) =>
      GetDynamicPlaylists(
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
    this.name,
    this.source,
    this.serviceName,
    this.list,
  });

  final String? name;
  final String? source;
  final String? serviceName;
  final List<ListElement>? list;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        name: json["name"],
        source: json["source"],
        serviceName: json["serviceName"],
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "source": source,
        "serviceName": serviceName,
        "list": list == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toMap())),
      };
}

class ListElement {
  ListElement({
    this.hotelId,
    this.hotelName,
    this.address,
    this.rating,
    this.review,
    this.promotion,
    this.image,
    this.adminPromotion,
  });

  final String? hotelId;
  final String? hotelName;
  final Address? address;
  final int? rating;
  final Review? review;
  final List<Promotion>? promotion;
  final String? image;
  final AdminPromotion? adminPromotion;

  factory ListElement.fromJson(String str) =>
      ListElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
        hotelId: json["hotelId"],
        hotelName: json["hotelName"],
        address:
            json["address"] == null ? null : Address.fromMap(json["address"]),
        rating: json["rating"],
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
        "hotelId": hotelId,
        "hotelName": hotelName,
        "address": address?.toMap(),
        "rating": rating,
        "review": review == null ? null : review!.toMap(),
        "promotion": promotion == null
            ? null
            : List<dynamic>.from(promotion!.map((x) => x.toMap())),
        "image": image,
        "adminPromotion": adminPromotion?.toMap(),
      };
}

class Address {
  Address({
    this.cityId,
    this.locationName,
    this.locationId,
    this.address1,
    this.cityName,
    this.countryId,
    this.countryName,
  });

  final String? cityId;
  final String? locationName;
  final String? locationId;
  final String? address1;
  final String? cityName;
  final String? countryId;
  final String? countryName;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        cityId: json["cityId"],
        locationName: json["locationName"],
        locationId: json["locationId"],
        address1: json["address1"],
        cityName: json["cityName"],
        countryId: json["countryId"],
        countryName: json["countryName"],
      );

  Map<String, dynamic> toMap() => {
        "cityId": cityId,
        "locationName": locationName,
        "locationId": locationId,
        "address1": address1,
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
    this.promotionText2,
    this.promotionText1,
    this.adminPromotionLine2,
    this.adminPromotionLine1,
  });

  final String? promotionText2;
  final String? promotionText1;
  final String? adminPromotionLine2;
  final String? adminPromotionLine1;

  factory AdminPromotion.fromJson(String str) =>
      AdminPromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminPromotion.fromMap(Map<String, dynamic> json) => AdminPromotion(
        promotionText2: json["promotionText2"],
        promotionText1: json["promotionText1"],
        adminPromotionLine2: json["adminPromotionLine2"],
        adminPromotionLine1: json["adminPromotionLine1"],
      );

  Map<String, dynamic> toMap() => {
        "promotionText2": promotionText2,
        "promotionText1": promotionText1,
        "adminPromotionLine2": adminPromotionLine2,
        "adminPromotionLine1": adminPromotionLine1,
      };
}

class Status {
  Status({
    this.code,
    this.header,
    this.description,
    this.errors,
  });

  final String? code;
  final String? header;
  final String? description;
  final String? errors;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
        description: json["description"],
        errors: json["errors"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
        "description": description,
        "errors": errors,
      };
}
