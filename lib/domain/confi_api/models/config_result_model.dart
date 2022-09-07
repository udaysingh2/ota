import 'dart:convert';

class ConfigResultModel {
  ConfigResultModel({
    this.getConfigDetails,
  });

  final GetConfigDetails? getConfigDetails;

  factory ConfigResultModel.fromJson(String str) =>
      ConfigResultModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConfigResultModel.fromMap(Map<String, dynamic> json) =>
      ConfigResultModel(
        getConfigDetails: json["getConfigDetails"] == null
            ? null
            : GetConfigDetails.fromMap(json["getConfigDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getConfigDetails":
            getConfigDetails == null ? null : getConfigDetails!.toMap(),
      };
}

class GetConfigDetails {
  GetConfigDetails({
    this.data,
    this.status,
  });

  final List<Datum>? data;
  final Status? status;

  factory GetConfigDetails.fromJson(String str) =>
      GetConfigDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetConfigDetails.fromMap(Map<String, dynamic> json) =>
      GetConfigDetails(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "status": status == null ? null : status!.toMap(),
      };
}

class Datum {
  Datum({
    this.name,
    this.value,
    this.type,
  });

  final String? name;
  final String? value;
  final Type? type;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        name: json["name"],
        value: json["value"],
        type: json["type"] == null ? null : typeValues.map![json["type"]],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "value": value,
        "type": type == null ? null : typeValues.reverse![type],
      };
}

enum Type { room, hotel, search, infotech, ota }

final typeValues = EnumValues({
  "hotel": Type.hotel,
  "room": Type.room,
  "search": Type.search,
  "infotech": Type.infotech,
  "ota": Type.ota
});

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

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
