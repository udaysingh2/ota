// To parse this JSON data, do
//
//     final pickUpPointDomain = pickUpPointDomainFromMap(jsonString);

import 'dart:convert';

class PickUpPointDomain {
  PickUpPointDomain({
    this.getPickUpDetails,
  });

  final GetPickUpDetails? getPickUpDetails;

  factory PickUpPointDomain.fromJson(String str) =>
      PickUpPointDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PickUpPointDomain.fromMap(Map<String, dynamic> json) =>
      PickUpPointDomain(
        getPickUpDetails: json["getPickUpDetails"] == null
            ? null
            : GetPickUpDetails.fromMap(json["getPickUpDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getPickUpDetails":
            getPickUpDetails == null ? null : getPickUpDetails!.toMap(),
      };
}

class GetPickUpDetails {
  GetPickUpDetails({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetPickUpDetails.fromJson(String str) =>
      GetPickUpDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPickUpDetails.fromMap(Map<String, dynamic> json) =>
      GetPickUpDetails(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
      };
}

class Data {
  Data({
    this.pickupPoints,
  });

  final List<PickupPoint>? pickupPoints;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        pickupPoints: json["pickupPoints"] == null
            ? null
            : List<PickupPoint>.from(
                json["pickupPoints"].map((x) => PickupPoint.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "pickupPoints": pickupPoints == null
            ? null
            : List<dynamic>.from(pickupPoints!.map((x) => x.toMap())),
      };
}

class PickupPoint {
  PickupPoint({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  factory PickupPoint.fromJson(String str) =>
      PickupPoint.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PickupPoint.fromMap(Map<String, dynamic> json) => PickupPoint(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
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
  final String? description;

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
