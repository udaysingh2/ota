import 'dart:convert';

class HotelDynamicPlayListModelDomain {
  HotelDynamicPlayListModelDomain({
    this.data,
  });

  final HotelDynamicPlayListModelDomainData? data;

  factory HotelDynamicPlayListModelDomain.fromJson(String str) =>
      HotelDynamicPlayListModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelDynamicPlayListModelDomain.fromMap(Map<String, dynamic> json) =>
      HotelDynamicPlayListModelDomain(
        data: json["data"] == null
            ? null
            : HotelDynamicPlayListModelDomainData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class HotelDynamicPlayListModelDomainData {
  HotelDynamicPlayListModelDomainData({
    this.getRecentViewPlaylist,
  });

  final GetRecentViewPlaylist? getRecentViewPlaylist;

  factory HotelDynamicPlayListModelDomainData.fromJson(String str) =>
      HotelDynamicPlayListModelDomainData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelDynamicPlayListModelDomainData.fromMap(
          Map<String, dynamic> json) =>
      HotelDynamicPlayListModelDomainData(
        getRecentViewPlaylist: json["getRecentViewPlaylist"] == null
            ? null
            : GetRecentViewPlaylist.fromMap(json["getRecentViewPlaylist"]),
      );

  Map<String, dynamic> toMap() => {
        "getRecentViewPlaylist": getRecentViewPlaylist?.toMap(),
      };
}

class GetRecentViewPlaylist {
  GetRecentViewPlaylist({
    this.listType,
    this.recentViewPlaylist,
    this.dynamicPlaylist,
  });

  final String? listType;
  final List<RecentViewPlaylist>? recentViewPlaylist;
  final DynamicPlaylist? dynamicPlaylist;

  factory GetRecentViewPlaylist.fromJson(String str) =>
      GetRecentViewPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetRecentViewPlaylist.fromMap(Map<String, dynamic> json) =>
      GetRecentViewPlaylist(
        listType: json["listType"],
        recentViewPlaylist: json["recentViewPlaylist"] == null
            ? null
            : List<RecentViewPlaylist>.from(json["recentViewPlaylist"]
                .map((x) => RecentViewPlaylist.fromMap(x))),
        dynamicPlaylist: json["dynamicPlaylist"] == null
            ? null
            : DynamicPlaylist.fromMap((json["dynamicPlaylist"])),
      );

  Map<String, dynamic> toMap() => {
        "listType": listType,
        "recentViewPlaylist": recentViewPlaylist == null
            ? null
            : List<dynamic>.from(recentViewPlaylist!.map((x) => x.toMap())),
        "dynamicPlaylist": dynamicPlaylist?.toMap(),
      };
}

class DynamicPlaylist {
  DynamicPlaylist({
    this.serviceName,
    this.source,
    this.playlist,
  });

  final String? serviceName;
  final String? source;
  final List<Playlist>? playlist;

  factory DynamicPlaylist.fromJson(String str) =>
      DynamicPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DynamicPlaylist.fromMap(Map<String, dynamic> json) => DynamicPlaylist(
        serviceName: json["serviceName"],
        source: json["source"],
        playlist: json["playlist"] == null
            ? null
            : List<Playlist>.from(
                json["playlist"].map((x) => Playlist.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "serviceName": serviceName,
        "source": source,
        "playlist": playlist == null
            ? null
            : List<dynamic>.from(playlist!.map((x) => x.toMap())),
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
            : List<dynamic>.from(cardList!.map((x) => x.toMap())),
      };
}

class CardList {
  CardList({
    this.id,
    this.name,
    this.address,
    this.locationId,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.countryName,
    this.capsulePromotion,
    this.rating,
    this.infopromotion,
    this.imageUrl,
    this.promotionText1,
    this.promotionText2,
    this.styleName,
    this.startPrice,
    this.productType,
    this.review,
  });

  final String? id;
  final String? name;
  final String? address;
  final String? locationId;
  final String? locationName;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  final String? countryName;
  final List<CapsulePromotion>? capsulePromotion;
  final int? rating;
  final List<InfoPromotion>? infopromotion;
  final String? imageUrl;
  final String? promotionText1;
  final String? promotionText2;
  final String? styleName;
  final int? startPrice;
  final String? productType;
  final Review? review;

  factory CardList.fromJson(String str) => CardList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardList.fromMap(Map<String, dynamic> json) => CardList(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        locationId: json["locationId"],
        locationName: json["locationName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
        countryName: json["countryName"],
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CapsulePromotion.fromMap(x))),
        rating: json["rating"],
        infopromotion: json["infopromotion"] == null
            ? null
            : List<InfoPromotion>.from(
                json["infopromotion"].map((x) => InfoPromotion.fromMap(x))),
        imageUrl: json["imageUrl"],
        promotionText1: json["promotionText1"],
        promotionText2: json["promotionText2"],
        styleName: json["styleName"],
        startPrice: json["startPrice"],
        productType: json["productType"],
        review: json["review"] == null ? null : Review.fromMap(json["review"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "locationId": locationId,
        "locationName": locationName,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
        "countryName": countryName,
        "capsulePromotion": capsulePromotion == null
            ? null
            : List<dynamic>.from(capsulePromotion!.map((x) => x.toMap())),
        "rating": rating,
        "infopromotion": infopromotion == null
            ? null
            : List<dynamic>.from(infopromotion!.map((x) => x)),
        "imageUrl": imageUrl,
        "promotionText1": promotionText1,
        "promotionText2": promotionText2,
        "styleName": styleName,
        "startPrice": startPrice,
        "productType": productType,
        "review": review!.toMap(),
      };
}

class InfoPromotion {
  InfoPromotion({
    this.promotionText,
  });

  final String? promotionText;

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

class RecentViewPlaylist {
  RecentViewPlaylist({
    this.hotelId,
    this.cityId,
    this.countryId,
    this.rating,
    this.hotelName,
    this.image,
    this.locationName,
    this.promotionList,
  });

  final String? hotelId;
  final String? cityId;
  final String? countryId;
  final int? rating;
  final String? hotelName;
  final String? image;
  final String? locationName;
  final List<PromotionList>? promotionList;

  factory RecentViewPlaylist.fromJson(String str) =>
      RecentViewPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecentViewPlaylist.fromMap(Map<String, dynamic> json) =>
      RecentViewPlaylist(
        hotelId: json["hotelId"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        rating: json["rating"] == null
            ? null
            : (double.tryParse('${json["rating"]}')?.truncate()),
        hotelName: json["hotelName"],
        image: json["image"],
        locationName: json["locationName"],
        promotionList: json["promotionList"] == null
            ? null
            : List<PromotionList>.from(
                json["promotionList"].map((x) => PromotionList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "hotelId": hotelId,
        "cityId": cityId,
        "countryId": countryId,
        "rating": rating,
        "hotelName": hotelName,
        "image": image,
        "locationName": locationName,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
      };
}

class PromotionList {
  PromotionList({
    this.productId,
    this.productType,
    this.promotionType,
    this.promotionCode,
    this.line1,
    this.line2,
    this.startDate,
    this.endDate,
    this.name,
  });

  final String? productId;
  final String? productType;
  final String? promotionType;
  final String? promotionCode;
  final String? line1;
  final String? line2;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? name;

  factory PromotionList.fromJson(String str) =>
      PromotionList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PromotionList.fromMap(Map<String, dynamic> json) => PromotionList(
        productId: json["productId"],
        productType: json["productType"],
        promotionType: json["promotionType"],
        promotionCode: json["promotionCode"],
        line1: json["line1"],
        line2: json["line2"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.tryParse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.tryParse(json["endDate"]),
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "productType": productType,
        "promotionType": promotionType,
        "promotionCode": promotionCode,
        "line1": line1,
        "line2": line2,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "title": name,
      };
}
