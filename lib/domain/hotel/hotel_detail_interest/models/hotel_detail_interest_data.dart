// To parse this JSON data, do
//
//     final hotelDetailInterestData = hotelDetailInterestDataFromMap(jsonString);

import 'dart:convert';

class HotelDetailInterestData {
  HotelDetailInterestData({
    this.data,
  });

  final HotelDetailInterestDataData? data;

  factory HotelDetailInterestData.fromJson(String str) =>
      HotelDetailInterestData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelDetailInterestData.fromMap(Map<String, dynamic> json) =>
      HotelDetailInterestData(
        data: json["data"] == null
            ? null
            : HotelDetailInterestDataData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class HotelDetailInterestDataData {
  HotelDetailInterestDataData({
    this.getHotelsYouMayLike,
  });

  final GetHotelsYouMayLike? getHotelsYouMayLike;

  factory HotelDetailInterestDataData.fromJson(String str) =>
      HotelDetailInterestDataData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelDetailInterestDataData.fromMap(Map<String, dynamic> json) =>
      HotelDetailInterestDataData(
        getHotelsYouMayLike: json["getHotelsYouMayLike"] == null
            ? null
            : GetHotelsYouMayLike.fromMap(json["getHotelsYouMayLike"]),
      );

  Map<String, dynamic> toMap() => {
        "getHotelsYouMayLike": getHotelsYouMayLike?.toMap(),
      };
}

class GetHotelsYouMayLike {
  GetHotelsYouMayLike({
    this.data,
    this.status,
  });

  final GetHotelsYouMayLikeData? data;
  final Status? status;

  factory GetHotelsYouMayLike.fromJson(String str) =>
      GetHotelsYouMayLike.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetHotelsYouMayLike.fromMap(Map<String, dynamic> json) =>
      GetHotelsYouMayLike(
        data: json["data"] == null
            ? null
            : GetHotelsYouMayLikeData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class GetHotelsYouMayLikeData {
  GetHotelsYouMayLikeData({
    this.hotelList,
  });

  final List<HotelList>? hotelList;

  factory GetHotelsYouMayLikeData.fromJson(String str) =>
      GetHotelsYouMayLikeData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetHotelsYouMayLikeData.fromMap(Map<String, dynamic> json) =>
      GetHotelsYouMayLikeData(
        hotelList: json["hotelList"] == null
            ? null
            : List<HotelList>.from(
                json["hotelList"].map((x) => HotelList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "hotelList": hotelList == null
            ? null
            : List<dynamic>.from(hotelList!.map((x) => x.toMap())),
      };
}

class HotelList {
  HotelList({
    this.hotelId,
    this.hotelName,
    this.image,
    this.rating,
    this.address,
    this.infoTechPromotion,
    this.totalPrice,
    this.pricePerNight,
    this.adminPromotion,
    this.review,
    this.capsulePromotions,
  });

  final String? hotelId;
  final String? hotelName;
  final String? image;
  final int? rating;
  final Address? address;
  final List<String>? infoTechPromotion;
  final double? totalPrice;
  final double? pricePerNight;
  final AdminPromotion? adminPromotion;
  final Review? review;
  final List<CapsulePromotion>? capsulePromotions;

  factory HotelList.fromJson(String str) => HotelList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelList.fromMap(Map<String, dynamic> json) => HotelList(
        hotelId: json["hotelId"],
        hotelName: json["hotelName"],
        image: json["image"],
        rating: json["rating"],
        address:
            json["address"] == null ? null : Address.fromMap(json["address"]),
        infoTechPromotion: json["infoTechPromotion"] == null
            ? null
            : List<String>.from(json["infoTechPromotion"].map((x) => x)),
        totalPrice: json["totalPrice"]?.toDouble(),
        pricePerNight: json["pricePerNight"]?.toDouble(),
        adminPromotion: json["adminPromotion"] == null
            ? null
            : AdminPromotion.fromMap(json["adminPromotion"]),
        capsulePromotions: json["capsulePromotion"] == null
            ? null
            : List<CapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CapsulePromotion.fromMap(x))),
        review: json["review"] == null ? null : Review.fromMap(json["review"]),
      );

  Map<String, dynamic> toMap() => {
        "hotelId": hotelId,
        "hotelName": hotelName,
        "image": image,
        "rating": rating,
        "address": address?.toMap(),
        "infoTechPromotion": infoTechPromotion == null
            ? null
            : List<dynamic>.from(infoTechPromotion!.map((x) => x)),
        "totalPrice": totalPrice,
        "pricePerNight": pricePerNight,
        "adminPromotion": adminPromotion?.toMap(),
        "review": review?.toMap(),
        "capsulePromotion": capsulePromotions == null
            ? null
            : List<dynamic>.from(capsulePromotions!.map((x) => x.toMap())),
      };
}

class CapsulePromotion {
  CapsulePromotion({
    this.name,
    this.code,
  });

  final String? name;
  final String? code;

  factory CapsulePromotion.fromJson(String str) =>
      CapsulePromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CapsulePromotion.fromMap(Map<String, dynamic> json) =>
      CapsulePromotion(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
      };
}

class Address {
  Address({
    this.address,
    this.locationId,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.countryName,
  });

  final String? address;
  final String? locationId;
  final String? locationName;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  final String? countryName;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        address: json["address"],
        locationId: json["locationId"],
        locationName: json["locationName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
        countryName: json["countryName"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "locationId": locationId,
        "locationName": locationName,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
        "countryName": countryName,
      };
}

class AdminPromotion {
  AdminPromotion({
    this.promotionText1,
    this.promotionText2,
  });

  final String? promotionText1;
  final String? promotionText2;

  factory AdminPromotion.fromJson(String str) =>
      AdminPromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminPromotion.fromMap(Map<String, dynamic> json) => AdminPromotion(
        promotionText1: json["adminPromotionLine1"],
        promotionText2: json["adminPromotionLine2"],
      );

  Map<String, dynamic> toMap() => {
        "adminPromotionLine1": promotionText1,
        "adminPromotionLine2": promotionText2,
      };
}

class Review {
  Review({
    this.score,
    this.numReview,
    this.description,
  });

  final double? score;
  final int? numReview;
  final String? description;

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        score: json["score"]?.toDouble(),
        numReview: json["numReview"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "score": score,
        "numReview": numReview,
        "description": description,
      };
}

class Status {
  Status({
    this.code,
    this.header,
    this.description,
  });

  final String? code;
  final String? header;
  final dynamic description;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
        "description": description,
      };
}
