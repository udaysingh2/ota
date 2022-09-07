// To parse this JSON data, do
//
//     final popupModel = popupModelFromMap(jsonString);

import 'dart:convert';

class PopupModelDomain {
  PopupModelDomain({
    this.getPopups,
  });

  final GetPopups? getPopups;

  factory PopupModelDomain.fromJson(String str) =>
      PopupModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PopupModelDomain.fromMap(Map<String, dynamic> json) => PopupModelDomain(
        getPopups: json["getPopups"] == null
            ? null
            : GetPopups.fromMap(json["getPopups"]),
      );

  Map<String, dynamic> toMap() => {
        "getPopups": getPopups?.toMap(),
      };
}

class GetPopups {
  GetPopups({
    this.data,
    this.status,
  });

  final GetPopupsData? data;
  final Status? status;

  factory GetPopups.fromJson(String str) => GetPopups.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPopups.fromMap(Map<String, dynamic> json) => GetPopups(
        data: json["data"] == null ? null : GetPopupsData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class GetPopupsData {
  GetPopupsData({
    this.popups,
  });

  final List<Popup>? popups;

  factory GetPopupsData.fromJson(String str) =>
      GetPopupsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPopupsData.fromMap(Map<String, dynamic> json) => GetPopupsData(
        popups: json["popups"] == null
            ? null
            : List<Popup>.from(json["popups"].map((x) => Popup.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "popups": popups == null
            ? null
            : List<dynamic>.from(popups!.map((x) => x.toMap())),
      };
}

class Popup {
  Popup({
    this.popupId,
    this.type,
    this.startDate,
    this.endDate,
    this.priority,
    this.imageFilename,
    this.deeplinkUrl,
    this.deeplinkType,
    this.function,
    this.orderSection,
  });

  final String? popupId;
  final String? type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? priority;
  final String? imageFilename;
  final String? deeplinkUrl;
  final String? deeplinkType;
  final String? function;
  final String? orderSection;

  factory Popup.fromJson(String str) => Popup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Popup.fromMap(Map<String, dynamic> json) => Popup(
        popupId: json["popupId"],
        type: json["type"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.tryParse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.tryParse(json["endDate"]),
        priority: json["priority"],
        imageFilename: json["imageFilename"],
        deeplinkUrl: json["deeplinkUrl"],
        deeplinkType: json["deeplinkType"],
        function: json["function"],
        orderSection: json["orderSection"],
      );

  Map<String, dynamic> toMap() => {
        "popupId": popupId,
        "type": type,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "priority": priority,
        "imageFilename": imageFilename,
        "deeplinkUrl": deeplinkUrl,
        "deeplinkType": deeplinkType,
        "function": function,
        "orderSection": orderSection,
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
