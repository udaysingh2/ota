import 'dart:convert';

class HotelStaticPlayListModelDomain {
  HotelStaticPlayListModelDomain({
    this.getPlaylists,
  });

  HotelStaticGetPlaylists? getPlaylists;

  factory HotelStaticPlayListModelDomain.fromJson(String str) =>
      HotelStaticPlayListModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelStaticPlayListModelDomain.fromMap(Map<String, dynamic> json) =>
      HotelStaticPlayListModelDomain(
        getPlaylists: json["getPlaylists"] == null
            ? null
            : HotelStaticGetPlaylists.fromMap(json["getPlaylists"]),
      );

  Map<String, dynamic> toMap() => {
        "getPlaylists": getPlaylists?.toMap(),
      };
}

class HotelStaticGetPlaylists {
  HotelStaticGetPlaylists({
    this.staticPlaylist,
  });

  StaticPlaylist? staticPlaylist;

  factory HotelStaticGetPlaylists.fromJson(String str) =>
      HotelStaticGetPlaylists.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelStaticGetPlaylists.fromMap(Map<String, dynamic> json) =>
      HotelStaticGetPlaylists(
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
  List<CardList>? cardList;

  factory Playlist.fromJson(String str) => Playlist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Playlist.fromMap(Map<String, dynamic> json) => Playlist(
        playlistId: json["playlistId"],
        playlistName: json["playlistName"],
        cardList: json["cardList"] == null
            ? null
            : List<CardList>.from(
                json["cardList"].map((x) => CardList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "playlistId": playlistId,
        "playlistName": playlistName,
        "cardList": cardList == null
            ? null
            : List<dynamic>.from(cardList?.map((x) => x.toMap()) ?? []),
      };
}

class CardList {
  CardList({
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
  List<InfoPromotion>? infopromotion;

  factory CardList.fromJson(String str) => CardList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardList.fromMap(Map<String, dynamic> json) => CardList(
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
            : List<InfoPromotion>.from(
                json["infopromotion"].map((x) => InfoPromotion.fromMap(x))),
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
            : List<dynamic>.from(infopromotion?.map((x) => x.toMap()) ?? []),
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
