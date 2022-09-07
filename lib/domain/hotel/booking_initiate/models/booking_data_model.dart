// To parse this JSON data, do
//
//     final BookingData = BookingDataFromMap(jsonString);

import 'dart:convert';

class BookingData {
  BookingData({
    this.status,
    this.data,
  });

  final Status? status;
  final Data? data;

  factory BookingData.fromJson(String str) =>
      BookingData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookingData.fromMap(Map<String, dynamic> json) => BookingData(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status?.toMap(),
        "data": data?.toMap(),
      };
}

class Data {
  Data({
    this.hotelName,
    this.hotelImage,
    this.bookingUrn,
    this.roomDetails,
    this.promotionList,
  });

  final String? hotelName;
  final String? hotelImage;
  final String? bookingUrn;
  final RoomDetails? roomDetails;
  final List<PromotionList>? promotionList;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        hotelName: json["hotelName"],
        hotelImage: json["hotelImage"],
        bookingUrn: json["bookingUrn"],
        roomDetails: json["roomDetails"] == null
            ? null
            : RoomDetails.fromMap(json["roomDetails"]),
        promotionList: json["promotionList"] == null
            ? null
            : List<PromotionList>.from(
                json["promotionList"].map((x) => PromotionList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "hotelName": hotelName,
        "hotelImage": hotelImage,
        "bookingUrn": bookingUrn,
        "roomDetails": roomDetails?.toMap(),
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap()))
      };
}

class PromotionList {
  PromotionList({
    this.productType,
    this.promotionCode,
    this.title,
    this.description,
    this.web,
    this.iconImage,
    this.bannerDescDisplay,
    this.line1,
    this.line2,
    this.productId,
    this.promotionType,
  });

  final String? productType;
  final String? promotionCode;
  final String? title;
  final String? description;
  final String? web;
  final String? iconImage;
  final bool? bannerDescDisplay;
  final String? line1;
  final String? line2;
  final String? productId;
  final String? promotionType;

  factory PromotionList.fromMap(Map<String, dynamic> json) => PromotionList(
        productType: json["productType"],
        promotionCode: json["promotionCode"],
        title: json["title"],
        description: json["description"],
        web: json["web"],
        iconImage: json["iconImage"],
        bannerDescDisplay: json["bannerDescDisplay"],
        line1: json["line1"],
        line2: json["line2"],
        productId: json["productId"],
        promotionType: json["promotionType"],
      );

  Map<String, dynamic> toMap() => {
        "productType": productType,
        "promotionCode": promotionCode,
        "title": title,
        "description": description,
        "web": web,
        "iconImage": iconImage,
        "bannerDescDisplay": bannerDescDisplay,
        "line1": line1,
        "line2": line2,
        "productId": productId,
        "promotionType": promotionType,
      };
}

class RoomDetails {
  RoomDetails({
    this.rateKey,
    this.supplier,
    this.mealType,
    this.roomImage,
    this.roomCategories,
    this.facilities,
    this.cancellationPolicy,
    this.totalPrice,
    this.perNightPrice,
    this.numberOfNights,
    this.specialPromotions,
  });

  final String? rateKey;
  final String? supplier;
  final String? mealType;
  final String? roomImage;
  final List<RoomCategory>? roomCategories;
  final List<Facility>? facilities;
  final List<CancellationPolicy>? cancellationPolicy;
  final double? totalPrice;
  final double? perNightPrice;
  final String? numberOfNights;
  final List<HotelBenefit>? specialPromotions;

  factory RoomDetails.fromJson(String str) =>
      RoomDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomDetails.fromMap(Map<String, dynamic> json) => RoomDetails(
        rateKey: json["rateKey"],
        supplier: json["supplier"],
        mealType: json["mealType"],
        roomImage: json["roomImage"],
        roomCategories: json["roomCategories"] == null
            ? null
            : List<RoomCategory>.from(
                json["roomCategories"].map((x) => RoomCategory.fromMap(x))),
        facilities: json["facilities"] == null
            ? null
            : List<Facility>.from(
                json["facilities"].map((x) => Facility.fromMap(x))),
        cancellationPolicy: json["cancellationPolicy"] == null
            ? null
            : List<CancellationPolicy>.from(json["cancellationPolicy"]
                .map((x) => CancellationPolicy.fromMap(x))),
        totalPrice: json["totalPrice"]?.toDouble(),
        perNightPrice: json["perNightPrice"]?.toDouble(),
        numberOfNights: json["numberOfNights"],
        specialPromotions: json["hotelBenefits"] == null
            ? null
            : List<HotelBenefit>.from(
                json["hotelBenefits"].map((x) => HotelBenefit.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "rateKey": rateKey,
        "supplier": supplier,
        "mealType": mealType,
        "roomImage": roomImage,
        "roomCategories": roomCategories == null
            ? null
            : List<dynamic>.from(roomCategories!.map((x) => x.toMap())),
        "facilities": facilities == null
            ? null
            : List<dynamic>.from(facilities!.map((x) => x.toMap())),
        "cancellationPolicy": cancellationPolicy == null
            ? null
            : List<dynamic>.from(cancellationPolicy!.map((x) => x.toMap())),
        "totalPrice": totalPrice,
        "perNightPrice": perNightPrice,
        "numberOfNights": numberOfNights,
        "hotelBenefits": specialPromotions == null
            ? null
            : List<dynamic>.from(specialPromotions!.map((x) => x.toMap()))
      };
}

class CancellationPolicy {
  CancellationPolicy({
    this.days,
    this.cancellationDaysDescription,
    this.cancellationChargeDescription,
    this.cancellationStatus,
  });

  final int? days;
  final String? cancellationDaysDescription;
  final String? cancellationChargeDescription;
  final String? cancellationStatus;

  factory CancellationPolicy.fromJson(String str) =>
      CancellationPolicy.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CancellationPolicy.fromMap(Map<String, dynamic> json) =>
      CancellationPolicy(
        days: json["days"],
        cancellationDaysDescription: json["cancellationDaysDescription"],
        cancellationChargeDescription: json["cancellationChargeDescription"],
        cancellationStatus: json["cancellationStatus"],
      );

  Map<String, dynamic> toMap() => {
        "days": days,
        "cancellationDaysDescription": cancellationDaysDescription,
        "cancellationChargeDescription": cancellationChargeDescription,
        "cancellationStatus": cancellationStatus,
      };
}

class HotelBenefit {
  HotelBenefit({
    this.longDescription,
    this.shortDescription,
  });

  final String? longDescription;
  final String? shortDescription;

  factory HotelBenefit.fromJson(String str) =>
      HotelBenefit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelBenefit.fromMap(Map<String, dynamic> json) => HotelBenefit(
        longDescription: json["longDescription"],
        shortDescription: json["shortDescription"],
      );

  Map<String, dynamic> toMap() => {
        "longDescription": longDescription,
        "shortDescription": shortDescription,
      };
}

class Facility {
  Facility({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory Facility.fromJson(String str) => Facility.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Facility.fromMap(Map<String, dynamic> json) => Facility(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": value,
      };
}

class RoomCategory {
  RoomCategory({
    this.noOfRoomsAndName,
    this.roomName,
    this.roomType,
    this.noOfRooms,
  });

  final String? noOfRoomsAndName;
  final String? roomName;
  final String? roomType;
  final int? noOfRooms;

  factory RoomCategory.fromJson(String str) =>
      RoomCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomCategory.fromMap(Map<String, dynamic> json) => RoomCategory(
        noOfRoomsAndName: json["noOfRoomsAndName"],
        roomName: json["roomName"],
        roomType: json["roomType"],
        noOfRooms: json["noOfRooms"],
      );

  Map<String, dynamic> toMap() => {
        "noOfRoomsAndName": noOfRoomsAndName,
        "roomName": roomName,
        "roomType": roomType,
        "noOfRooms": noOfRooms,
      };
}

class Status {
  Status({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
      };
}
