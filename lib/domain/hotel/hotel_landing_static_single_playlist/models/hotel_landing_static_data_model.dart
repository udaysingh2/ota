// To parse this JSON data, do
//
//     final hotelLandingStaticSingleData = hotelLandingStaticSingleDataFromMap(jsonString);

import 'dart:convert';

class HotelLandingStaticSingleData {
  HotelLandingStaticSingleData({
    this.getPlaylists,
  });

  GetPlaylists? getPlaylists;

  factory HotelLandingStaticSingleData.fromJson(String str) =>
      HotelLandingStaticSingleData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelLandingStaticSingleData.fromMap(Map<String, dynamic> json) =>
      HotelLandingStaticSingleData(
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
    this.staticPlaylist,
  });

  StaticPlaylist? staticPlaylist;

  factory GetPlaylists.fromJson(String str) =>
      GetPlaylists.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPlaylists.fromMap(Map<String, dynamic> json) => GetPlaylists(
        staticPlaylist: json["staticPlaylist"] == null
            ? null
            : StaticPlaylist.fromMap(json["staticPlaylist"]),
      );

  Map<String, dynamic> toMap() => {
        "staticPlaylist": staticPlaylist?.toMap(),
      };
}

class StaticPlaylist {
  StaticPlaylist({
    this.source,
    this.serviceName,
    this.playlist,
  });

  String? source;
  String? serviceName;
  List<Playlist>? playlist;

  factory StaticPlaylist.fromJson(String str) =>
      StaticPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StaticPlaylist.fromMap(Map<String, dynamic> json) => StaticPlaylist(
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
  List<StaticCardList>? cardList;

  factory Playlist.fromJson(String str) => Playlist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Playlist.fromMap(Map<String, dynamic> json) => Playlist(
        playlistId: json["playlistId"],
        playlistName: json["playlistName"],
        cardList: json["cardList"] == null
            ? null
            : List<StaticCardList>.from(
                json["cardList"].map((x) => StaticCardList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "playlistId": playlistId,
        "playlistName": playlistName,
        "cardList": cardList == null
            ? null
            : List<dynamic>.from(cardList?.map((x) => x.toMap()) ?? []),
      };
}

class StaticCardList {
  StaticCardList({
    this.id,
    this.cityId,
    this.countryId,
    this.imageUrl,
    this.countryName,
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
  String? imageUrl;
  String? countryName;
  String? name;
  String? locationName;
  String? locationId;
  String? cityName;
  String? styleName;
  int? startPrice;
  String? productType;
  String? address;
  String? address1;
  int? rating;
  Review? review;
  String? promotionTextLine1;
  String? promotionTextLine2;
  List<CapsulePromotion>? capsulePromotion;
  List<dynamic>? infopromotion;

  factory StaticCardList.fromJson(String str) =>
      StaticCardList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StaticCardList.fromMap(Map<String, dynamic> json) => StaticCardList(
        id: json["id"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        imageUrl: json["imageUrl"],
        countryName: json["countryName"],
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
            : List<dynamic>.from(json["infopromotion"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cityId": cityId,
        "countryId": countryId,
        "imageUrl": imageUrl,
        "countryName": countryName,
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
