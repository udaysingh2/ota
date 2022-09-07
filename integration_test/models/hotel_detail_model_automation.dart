// To parse this JSON data, do
//
//     final hotel = hotelFromMap(jsonString);

import 'dart:convert';

class HotelAutomation {
  HotelAutomation({
    this.data,
    this.status,
    this.metadata,
  });

  final DataAutomation? data;
  final StatusAutomation? status;
  final MetadataAutomation? metadata;

  factory HotelAutomation.fromJson(String str) =>
      HotelAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelAutomation.fromMap(Map<String, dynamic> json) => HotelAutomation(
        data: json["getHotelDetails"] == null
            ? null
            : DataAutomation.fromMap(json["getHotelDetails"]),
        status: json["status"] == null
            ? null
            : StatusAutomation.fromMap(json["status"]),
        metadata: json["metadata"] == null
            ? null
            : MetadataAutomation.fromMap(json["metadata"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data?.toMap(),
        "status": status == null ? null : status?.toMap(),
        "metadata": metadata == null ? null : metadata?.toMap(),
      };
}

class DataAutomation {
  DataAutomation({
    this.hotelDetail,
  });

  final HotelDetailAutomation? hotelDetail;

  factory DataAutomation.fromJson(String str) =>
      DataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAutomation.fromMap(Map<String, dynamic> json) => DataAutomation(
        hotelDetail: json["data"] == null
            ? null
            : HotelDetailAutomation.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "hotelDetail": hotelDetail == null ? null : hotelDetail?.toMap(),
      };
}

class HotelDetailAutomation {
  HotelDetailAutomation({
    this.id,
    this.name,
    this.rating,
    this.ratingCount,
    this.ratingText,
    this.location,
    this.address,
    this.accomodationDetails,
    this.lattitude,
    this.longatude,
    this.isFavourite,
    this.images,
    this.facilities,
    this.rooms,
  });

  final String? id;
  final String? name;
  final String? rating;
  final String? ratingCount;
  final String? ratingText;
  final String? location;
  final String? address;
  final String? accomodationDetails;
  final double? lattitude;
  final double? longatude;
  final int? isFavourite;
  final Images? images;
  final FacilitiesAutomation? facilities;
  final List<Room>? rooms;

  factory HotelDetailAutomation.fromJson(String str) =>
      HotelDetailAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelDetailAutomation.fromMap(Map<String, dynamic> json) =>
      HotelDetailAutomation(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        rating: json["rating"] == null ? null : '${json["rating"]}',
        ratingCount:
            json["ratingCount"] == null ? null : '${json["ratingCount"]}',
        ratingText: json["ratingText"] == null ? null : json["ratingText"],
        location: json["location"] == null ? null : json["location"],
        address: json["address"] == null ? null : json["address"],
        accomodationDetails: json["accomodationDetails"] == null
            ? null
            : json["accomodationDetails"],
        lattitude:
            json["lattitude"] == null ? null : json["lattitude"].toDouble(),
        longatude:
            json["longatude"] == null ? null : json["longatude"].toDouble(),
        isFavourite: json["isFavourite"] == null ? null : json["isFavourite"],
        images: json["images"] == null ? null : Images.fromMap(json["images"]),
        facilities: json["facilities"] == null
            ? null
            : FacilitiesAutomation.fromMap(json["facilities"]),
        rooms: json["rooms"] == null
            ? null
            : List<Room>.from(json["rooms"].map((x) => Room.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "rating": rating == null ? null : rating,
        "ratingCount": ratingCount == null ? null : ratingCount,
        "ratingText": ratingText == null ? null : ratingText,
        "location": location == null ? null : location,
        "address": address == null ? null : address,
        "accomodationDetails":
            accomodationDetails == null ? null : accomodationDetails,
        "lattitude": lattitude == null ? null : lattitude,
        "longatude": longatude == null ? null : longatude,
        "isFavourite": isFavourite == null ? null : isFavourite,
        "images": images == null ? null : images?.toMap(),
        "facilities": facilities == null ? null : facilities?.toMap(),
        "rooms": rooms == null
            ? null
            : List<dynamic>.from(rooms!.map((x) => x.toMap())),
      };
}

class FacilitiesAutomation {
  FacilitiesAutomation({
    this.list,
    this.main,
  });

  final List<ListElementAutomation>? list;
  final List<MainElementAutomation>? main;

  factory FacilitiesAutomation.fromMap(Map<String, dynamic> json) =>
      FacilitiesAutomation(
        list: json["list"] == null
            ? null
            : List<ListElementAutomation>.from(
                json["list"].map((x) => ListElementAutomation.fromMap(x))),
        main: json["main"] == null
            ? null
            : List<MainElementAutomation>.from(
                json["main"].map((x) => MainElementAutomation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "list": list == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toMap())),
        "main": main == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toMap())),
      };
}

class ListElementAutomation {
  ListElementAutomation({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory ListElementAutomation.fromMap(Map<String, dynamic> json) =>
      ListElementAutomation(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}

class MainElementAutomation {
  MainElementAutomation({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory MainElementAutomation.fromMap(Map<String, dynamic> json) =>
      MainElementAutomation(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}

class Images {
  Images({
    this.baseUri,
    this.cover,
    this.galleryCount,
    this.gallery,
  });

  final String? baseUri;
  final String? cover;
  final int? galleryCount;
  final List<String>? gallery;

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        baseUri: json["baseUri"] == null ? null : json["baseUri"],
        cover: json["cover"] == null ? null : json["cover"],
        galleryCount:
            json["galleryCount"] == null ? null : json["galleryCount"],
        gallery: json["gallery"] == null
            ? null
            : List<String>.from(json["gallery"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "baseUri": baseUri == null ? null : baseUri,
        "cover": cover == null ? null : cover,
        "galleryCount": galleryCount == null ? null : galleryCount,
        "gallery":
            gallery == null ? null : List<dynamic>.from(gallery!.map((x) => x)),
      };
}

class Room {
  Room({
    this.roomName,
    this.facility,
    this.details,
  });

  final String? roomName;
  final List<MainElementAutomation>? facility;
  final List<DetailAutomation>? details;

  factory Room.fromJson(String str) => Room.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Room.fromMap(Map<String, dynamic> json) => Room(
        roomName: json["roomName"] == null ? null : json["roomName"],
        facility: json["facility"] == null
            ? null
            : List<MainElementAutomation>.from(
                json["facility"].map((x) => MainElementAutomation.fromMap(x))),
        details: json["details"] == null
            ? null
            : List<DetailAutomation>.from(
                json["details"].map((x) => DetailAutomation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "roomName": roomName == null ? null : roomName,
        "facility": facility == null
            ? null
            : List<dynamic>.from(facility!.map((x) => x.toMap())),
        "details": details == null
            ? null
            : List<dynamic>.from(details!.map((x) => x.toMap())),
      };
}

class DetailAutomation {
  DetailAutomation({
    this.roomCode,
    this.roomOfferName,
    this.roomType,
    this.nightPrice,
    this.totalPrice,
    this.roomOffer,
  });

  final String? roomCode;
  final String? roomOfferName;
  final String? roomType;
  final double? nightPrice;
  final double? totalPrice;
  final RoomOfferAutomation? roomOffer;

  factory DetailAutomation.fromJson(String str) =>
      DetailAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailAutomation.fromMap(Map<String, dynamic> json) =>
      DetailAutomation(
        roomCode: json["roomCode"] == null ? null : json["roomCode"],
        roomOfferName:
            json["roomOfferName"] == null ? null : json["roomOfferName"],
        roomType: json["roomType"] == null ? null : json["roomType"],
        nightPrice: json["nightPrice"] == null
            ? null
            : double.tryParse('${json["nightPrice"]}') ?? 0.0,
        totalPrice:
            json["totalPrice"] == null ? null : json["totalPrice"].toDouble(),
        roomOffer: json["roomOffer"] == null
            ? null
            : RoomOfferAutomation.fromMap(json["roomOffer"]),
      );

  Map<String, dynamic> toMap() => {
        "roomCode": roomCode == null ? null : roomCode,
        "roomOfferName": roomOfferName == null ? null : roomOfferName,
        "roomType": roomType == null ? null : roomType,
        "nightPrice": nightPrice == null ? null : nightPrice,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "roomOffer": roomOffer == null ? null : roomOffer?.toMap(),
      };
}

class RoomOfferAutomation {
  RoomOfferAutomation({
    this.cancellationPolicy,
    this.payNow,
    this.breakfast,
  });

  final String? cancellationPolicy;
  final String? payNow;
  final int? breakfast;

  factory RoomOfferAutomation.fromJson(String str) =>
      RoomOfferAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomOfferAutomation.fromMap(Map<String, dynamic> json) =>
      RoomOfferAutomation(
        cancellationPolicy: json["cancellationPolicy"] == null
            ? null
            : json["cancellationPolicy"],
        payNow: json["payNow"] == null ? null : json["payNow"],
        breakfast: json["breakfast"] == null ? null : json["breakfast"],
      );

  Map<String, dynamic> toMap() => {
        "cancellationPolicy":
            cancellationPolicy == null ? null : cancellationPolicy,
        "payNow": payNow == null ? null : payNow,
        "breakfast": breakfast == null ? null : breakfast,
      };
}

class MetadataAutomation {
  MetadataAutomation({
    this.source,
    this.timeStamp,
  });

  final String? source;
  final String? timeStamp;

  factory MetadataAutomation.fromJson(String str) =>
      MetadataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MetadataAutomation.fromMap(Map<String, dynamic> json) =>
      MetadataAutomation(
        source: json["source"] == null ? null : json["source"],
        timeStamp: json["timeStamp"] == null ? null : json["timeStamp"],
      );

  Map<String, dynamic> toMap() => {
        "source": source == null ? null : source,
        "timeStamp": timeStamp == null ? null : timeStamp,
      };
}

class StatusAutomation {
  StatusAutomation({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory StatusAutomation.fromJson(String str) =>
      StatusAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusAutomation.fromMap(Map<String, dynamic> json) =>
      StatusAutomation(
        code: json["code"] == null ? null : json["code"],
        header: json["header"] == null ? null : json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "header": header == null ? null : header,
      };
}
