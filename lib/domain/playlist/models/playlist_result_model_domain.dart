// To parse this JSON data, do
//
//     final playlistResultModelDomain = playlistResultModelDomainFromMap(jsonString);

import 'dart:convert';

class PlaylistResultModelDomain {
  PlaylistResultModelDomain({
    this.getPlaylists,
  });

  final GetPlaylists? getPlaylists;

  factory PlaylistResultModelDomain.fromJson(String str) => PlaylistResultModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaylistResultModelDomain.fromMap(Map<String, dynamic> json) => PlaylistResultModelDomain(
    getPlaylists: json["getPlaylists"] == null ? null : GetPlaylists.fromMap(json["getPlaylists"]),
  );

  Map<String, dynamic> toMap() => {
    "getPlaylists": getPlaylists == null ? null : getPlaylists!.toMap(),
  };
}

class GetPlaylists {
  GetPlaylists({
    this.staticPlaylist,
    this.dynamicPlaylist,
  });

  final IcPlaylist? staticPlaylist;
  final IcPlaylist? dynamicPlaylist;

  factory GetPlaylists.fromJson(String str) => GetPlaylists.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPlaylists.fromMap(Map<String, dynamic> json) => GetPlaylists(
    staticPlaylist: json["staticPlaylist"] == null
        ? null
        : IcPlaylist.fromMap(json["staticPlaylist"]),
    dynamicPlaylist: json["dynamicPlaylist"] == null
        ? null
        : IcPlaylist.fromMap(json["dynamicPlaylist"]),
  );

  Map<String, dynamic> toMap() => {
    "staticPlaylist": staticPlaylist == null
        ? null
        : staticPlaylist!.toMap(),
    "dynamicPlaylist": dynamicPlaylist == null
        ? null
        : dynamicPlaylist!.toMap(),
  };
}

class IcPlaylist {
  IcPlaylist({
    this.source,
    this.serviceName,
    this.playlist,
  });

  final String? source;
  final String? serviceName;
  final List<Playlist>? playlist;

  factory IcPlaylist.fromJson(String str) => IcPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IcPlaylist.fromMap(Map<String, dynamic> json) => IcPlaylist(
    source: json["source"],
    serviceName: json["serviceName"],
    playlist: json["playlist"] == null ? null : List<Playlist>.from(json["playlist"].map((x) => Playlist.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "source": source,
    "serviceName": serviceName,
    "playlist": playlist == null ? null : List<dynamic>.from(playlist!.map((x) => x.toMap())),
  };
}

class Playlist {
  Playlist({
    this.playlistId,
    this.playlistName,
    this.cardList,
  });

  final String? playlistId;
  final String? playlistName;
  final List<CardList>? cardList;

  factory Playlist.fromJson(String str) => Playlist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Playlist.fromMap(Map<String, dynamic> json) => Playlist(
    playlistId: json["playlistId"],
    playlistName: json["playlistName"],
    cardList: json["cardList"] == null ? null : List<CardList>.from(json["cardList"].map((x) => CardList.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "playlistId": playlistId,
    "playlistName": playlistName,
    "cardList": cardList == null ? null : List<dynamic>.from(cardList!.map((x) => x.toMap())),
  };
}

class CardList {
  CardList({
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
    this.rating,
    this.review,
    this.capsulePromotion,
    this.promotionTextLine1,
    this.promotionTextLine2,
    this.infopromotion,
  });

  final String? id;
  final String? cityId;
  final String? countryId;
  final String? countryName;
  final String? imageUrl;
  final String? name;
  final String? locationName;
  final String? locationId;
  final String? cityName;
  final String? styleName;
  final int? startPrice;
  final dynamic productType;
  final String? address;
  final int? rating;
  final Review? review;
  final List<CapsulePromotion>? capsulePromotion;
  final String? promotionTextLine1;
  final String? promotionTextLine2;
  final List<Infopromotion>? infopromotion;

  factory CardList.fromJson(String str) => CardList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardList.fromMap(Map<String, dynamic> json) => CardList(
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
    rating: json["rating"],
    review: json["review"] == null ? null : Review.fromMap(json["review"]),
    capsulePromotion: json["capsulePromotion"] == null ? null : List<CapsulePromotion>.from(json["capsulePromotion"].map((x) => CapsulePromotion.fromMap(x))),
    promotionTextLine1: json["promotionText_line1"],
    promotionTextLine2: json["promotionText_line2"],
    infopromotion: json["infopromotion"] == null ? null : List<Infopromotion>.from(json["infopromotion"].map((x) => Infopromotion.fromMap(x))),
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
    "rating": rating,
    "review": review == null ? null : review!.toMap(),
    "capsulePromotion": capsulePromotion == null ? null : List<dynamic>.from(capsulePromotion!.map((x) => x.toMap())),
    "promotionText_line1": promotionTextLine1,
    "promotionText_line2": promotionTextLine2,
    "infopromotion": infopromotion == null ? null : List<dynamic>.from(infopromotion!.map((x) => x.toMap())),
  };
}

class CapsulePromotion {
  CapsulePromotion({
    this.code,
    this.name,
  });

  final String? code;
  final String? name;

  factory CapsulePromotion.fromJson(String str) => CapsulePromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CapsulePromotion.fromMap(Map<String, dynamic> json) => CapsulePromotion(
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "name": name,
  };
}

class Infopromotion {
  Infopromotion({
    this.promotionText,
  });

  final String? promotionText;

  factory Infopromotion.fromJson(String str) => Infopromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Infopromotion.fromMap(Map<String, dynamic> json) => Infopromotion(
    promotionText: json["promotionText"],
  );

  Map<String, dynamic> toMap() => {
    "promotionText": promotionText,
  };
}

class Review {
  Review({
    this.score,
    this.numReview,
    this.description,
  });

  final int? score;
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

