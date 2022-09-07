// To parse this JSON data, do
//
//     final hotelLandingDynamicSingleData = hotelLandingDynamicSingleDataFromMap(jsonString);

import 'dart:convert';

class HotelLandingDynamicSingleData {
  HotelLandingDynamicSingleData({
    this.getPlaylists,
  });

  GetPlaylists? getPlaylists;

  factory HotelLandingDynamicSingleData.fromJson(String str) =>
      HotelLandingDynamicSingleData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelLandingDynamicSingleData.fromMap(Map<String, dynamic> json) =>
      HotelLandingDynamicSingleData(
        getPlaylists: json["getPlaylists"] == null
            ? null
            : GetPlaylists.fromMap(json["getPlaylists"]),
      );

  Map<String, dynamic> toMap() => {
        "getPlaylists": getPlaylists?.toMap(),
      };
}

class GetPlaylists {
  GetPlaylists({
    this.dynamicPlaylist,
  });

  DynamicPlaylist? dynamicPlaylist;

  factory GetPlaylists.fromJson(String str) =>
      GetPlaylists.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPlaylists.fromMap(Map<String, dynamic> json) => GetPlaylists(
        dynamicPlaylist: json["dynamicPlaylist"] == null
            ? null
            : DynamicPlaylist.fromMap(json["dynamicPlaylist"]),
      );

  Map<String, dynamic> toMap() => {
        "dynamicPlaylist": dynamicPlaylist?.toMap(),
      };
}

class DynamicPlaylist {
  DynamicPlaylist({
    this.source,
    this.serviceName,
    this.playlist,
  });

  String? source;
  String? serviceName;
  List<Playlist>? playlist;

  factory DynamicPlaylist.fromJson(String str) =>
      DynamicPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DynamicPlaylist.fromMap(Map<String, dynamic> json) => DynamicPlaylist(
        source: json["source"],
        serviceName: json["serviceName"],
        playlist: json["playlist"] == null
            ? null
            : List<Playlist>.from(
                json["playlist"].map((x) => Playlist.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "source": source,
        "serviceName": serviceName,
        "playlist": playlist == null
            ? null
            : List<dynamic>.from(playlist?.map((x) => x.toMap()) ?? []),
      };
}

class Playlist {
  Playlist({
    this.playlistId,
    this.playlistName,
    this.cardList,
  });

  String? playlistId;
  String? playlistName;
  List<DynamicCardList>? cardList;

  factory Playlist.fromJson(String str) => Playlist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Playlist.fromMap(Map<String, dynamic> json) => Playlist(
        playlistId: json["playlistId"],
        playlistName: json["playlistName"],
        cardList: json["cardList"] == null
            ? null
            : List<DynamicCardList>.from(
                json["cardList"].map((x) => DynamicCardList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "playlistId": playlistId,
        "playlistName": playlistName,
        "cardList": cardList == null
            ? null
            : List<dynamic>.from(cardList?.map((x) => x.toMap()) ?? []),
      };
}

class DynamicCardList {
  DynamicCardList({
    this.id,
    this.cityId,
    this.countryId,
    this.countryName,
    this.imageUrl,
    this.name,
    this.locationName,
    this.locationId,
    this.cityName,
    this.styleName,
    this.startPrice,
    this.productType,
    this.address,
    this.address1,
    this.rating,
    this.review,
    this.promotionTextLine1,
    this.promotionTextLine2,
    this.capsulePromotion,
    this.infopromotion,
  });

  String? id;
  String? cityId;
  String? countryId;
  String? countryName;
  String? imageUrl;
  String? name;
  String? locationName;
  String? locationId;
  String? cityName;
  String? styleName;
  String? startPrice;
  String? productType;
  String? address;
  String? address1;
  int? rating;
  Review? review;
  String? promotionTextLine1;
  String? promotionTextLine2;
  List<CapsulePromotion>? capsulePromotion;
  List<InfoPromotion>? infopromotion;

  factory DynamicCardList.fromJson(String str) =>
      DynamicCardList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DynamicCardList.fromMap(Map<String, dynamic> json) => DynamicCardList(
        id: json["id"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        countryName: json["countryName"],
        imageUrl: json["imageUrl"],
        name: json["name"],
        locationName: json["locationName"],
        locationId: json["locationId"],
        cityName: json["cityName"],
        styleName: json["styleName"],
        startPrice: json["startPrice"],
        productType: json["productType"],
        address: json["address"],
        address1: json["address1"],
        rating: json["rating"],
        review: json["review"] == null ? null : Review.fromMap(json["review"]),
        promotionTextLine1: json["promotionText_line1"],
        promotionTextLine2: json["promotionText_line2"],
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CapsulePromotion.fromMap(x))),
        infopromotion: json["infopromotion"] == null
            ? null
            : List<InfoPromotion>.from(
                json["infopromotion"].map((x) => InfoPromotion.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cityId": cityId,
        "countryId": countryId,
        "countryName": countryName,
        "imageUrl": imageUrl,
        "name": name,
        "locationName": locationName,
        "locationId": locationId,
        "cityName": cityName,
        "styleName": styleName,
        "startPrice": startPrice,
        "productType": productType,
        "address": address,
        "address1": address1,
        "rating": rating,
        "review": review?.toMap(),
        "promotionText_line1": promotionTextLine1,
        "promotionText_line2": promotionTextLine2,
        "capsulePromotion": capsulePromotion == null
            ? null
            : List<dynamic>.from(capsulePromotion?.map((x) => x.toMap()) ?? []),
        "infopromotion": infopromotion == null
            ? null
            : List<dynamic>.from(infopromotion?.map((x) => x) ?? []),
      };
}

class InfoPromotion {
  InfoPromotion({
    this.promotionText,
  });

  String? promotionText;

  factory InfoPromotion.fromJson(String str) =>
      InfoPromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfoPromotion.fromMap(Map<String, dynamic> json) => InfoPromotion(
        promotionText: json["promotionText"],
      );

  Map<String, dynamic> toMap() => {
        "promotionText": promotionText,
      };
}


class CapsulePromotion {
  CapsulePromotion({
    this.name,
    this.code,
  });

  String? name;
  String? code;

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

class Review {
  Review({
    this.score,
    this.numReview,
    this.description,
  });

  int? score;
  int? numReview;
  String? description;

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
