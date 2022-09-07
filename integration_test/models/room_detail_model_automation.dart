import 'dart:convert';

class RoomDetailAutomation {
  RoomDetailAutomation({
    this.data,
  });

  final RoomDetailDataAutomation? data;

  factory RoomDetailAutomation.fromJson(String str) =>
      RoomDetailAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomDetailAutomation.fromMap(Map<String, dynamic> json) => RoomDetailAutomation(
        data:
            json["data"] == null ? null : RoomDetailDataAutomation.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data?.toMap(),
      };
}

class RoomDetailDataAutomation {
  RoomDetailDataAutomation({
    this.getRoomDetails,
  });

  final GetRoomDetailsAutomation? getRoomDetails;

  factory RoomDetailDataAutomation.fromJson(String str) =>
      RoomDetailDataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomDetailDataAutomation.fromMap(Map<String, dynamic> json) => RoomDetailDataAutomation(
        getRoomDetails: json["getRoomDetails"] == null
            ? null
            : GetRoomDetailsAutomation.fromMap(json["getRoomDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getRoomDetails":
            getRoomDetails == null ? null : getRoomDetails?.toMap(),
      };
}

class GetRoomDetailsAutomation {
  GetRoomDetailsAutomation({
    this.data,
    this.status,
  });

  final GetRoomDetailsDataAutomation? data;
  final StatusAutomation? status;

  factory GetRoomDetailsAutomation.fromJson(String str) =>
      GetRoomDetailsAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetRoomDetailsAutomation.fromMap(Map<String, dynamic> json) => GetRoomDetailsAutomation(
        data: json["data"] == null
            ? null
            : GetRoomDetailsDataAutomation.fromMap(json["data"]),
        status: json["status"] == null ? null : StatusAutomation.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data?.toMap(),
        "status": status == null ? null : status?.toMap(),
      };
}

class GetRoomDetailsDataAutomation {
  GetRoomDetailsDataAutomation({
    this.mealType,
    this.roomImage,
    this.roomCategories,
    this.facilities,
    this.cancellationPolicy,
    this.roomFacilities,
    this.totalPrice,
  });

  final String? mealType;
  final dynamic roomImage;
  final List<RoomCategoryAutomation>? roomCategories;
  final List<FacilityAutomation>? facilities;
  final List<CancellationPolicyAutomation>? cancellationPolicy;
  final List<String>? roomFacilities;
  final double? totalPrice;

  factory GetRoomDetailsDataAutomation.fromJson(String str) =>
      GetRoomDetailsDataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetRoomDetailsDataAutomation.fromMap(Map<String, dynamic> json) =>
      GetRoomDetailsDataAutomation(
        mealType: json["mealType"] == null ? null : json["mealType"],
        roomImage: json["roomImage"],
        roomCategories: json["roomCategories"] == null
            ? null
            : List<RoomCategoryAutomation>.from(
                json["roomCategories"].map((x) => RoomCategoryAutomation.fromMap(x))),
        facilities: json["facilities"] == null
            ? null
            : List<FacilityAutomation>.from(
                json["facilities"].map((x) => FacilityAutomation.fromMap(x))),
        cancellationPolicy: json["cancellationPolicy"] == null
            ? null
            : List<CancellationPolicyAutomation>.from(json["cancellationPolicy"]
                .map((x) => CancellationPolicyAutomation.fromMap(x))),
        roomFacilities: json["roomFacilities"] == null
            ? null
            : List<String>.from(json["roomFacilities"].map((x) => x)),
        totalPrice:
            json["totalPrice"] == null ? null : json["totalPrice"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "mealType": mealType == null ? null : mealType,
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
        "roomFacilities": roomFacilities == null
            ? null
            : List<dynamic>.from(roomFacilities!.map((x) => x)),
        "totalPrice": totalPrice == null ? null : totalPrice,
      };
}

class RoomCategoryAutomation {
  RoomCategoryAutomation({
    this.roomName,
    this.roomType,
    this.noOfRooms,
  });

  final String? roomName;
  final String? roomType;
  final int? noOfRooms;

  factory RoomCategoryAutomation.fromJson(String str) =>
      RoomCategoryAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomCategoryAutomation.fromMap(Map<String, dynamic> json) => RoomCategoryAutomation(
        roomName: json["roomName"] == null ? null : json["roomName"],
        roomType: json["roomType"] == null ? null : json["roomType"],
        noOfRooms: json["noOfRooms"] == null ? null : json["noOfRooms"],
      );

  Map<String, dynamic> toMap() => {
        "roomName": roomName == null ? null : roomName,
        "roomType": roomType == null ? null : roomType,
        "noOfRooms": noOfRooms == null ? null : noOfRooms,
      };
}

class CancellationPolicyAutomation {
  CancellationPolicyAutomation({
    this.days,
    this.cancellationDaysDescription,
    this.cancellationChargeDescription,
    this.cancellationStatus,
  });

  final int? days;
  final String? cancellationDaysDescription;
  final String? cancellationChargeDescription;
  final String? cancellationStatus;

  factory CancellationPolicyAutomation.fromJson(String str) =>
      CancellationPolicyAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CancellationPolicyAutomation.fromMap(Map<String, dynamic> json) =>
      CancellationPolicyAutomation(
        days: json["days"] == null ? null : json["days"],
        cancellationDaysDescription: json["cancellationDaysDescription"] == null
            ? null
            : json["cancellationDaysDescription"],
        cancellationChargeDescription:
            json["cancellationChargeDescription"] == null
                ? null
                : json["cancellationChargeDescription"],
        cancellationStatus: json["cancellationStatus"] == null
            ? null
            : json["cancellationStatus"],
      );

  Map<String, dynamic> toMap() => {
        "days": days == null ? null : days,
        "cancellationDaysDescription": cancellationDaysDescription == null
            ? null
            : cancellationDaysDescription,
        "cancellationChargeDescription": cancellationChargeDescription == null
            ? null
            : cancellationChargeDescription,
        "cancellationStatus":
            cancellationStatus == null ? null : cancellationStatus,
      };
}

class FacilityAutomation {
  FacilityAutomation({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory FacilityAutomation.fromJson(String str) => FacilityAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FacilityAutomation.fromMap(Map<String, dynamic> json) => FacilityAutomation(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}

class StatusAutomation {
  StatusAutomation({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory StatusAutomation.fromJson(String str) => StatusAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusAutomation.fromMap(Map<String, dynamic> json) => StatusAutomation(
        code: json["code"] == null ? null : json["code"],
        header: json["header"] == null ? null : json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "header": header == null ? null : header,
      };
}