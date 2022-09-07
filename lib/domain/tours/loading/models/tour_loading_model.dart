import 'dart:convert';

class TourLoadingData {
  TourLoadingData({
    this.getTourServiceCards,
  });

  final GetTourServiceCards? getTourServiceCards;

  factory TourLoadingData.fromJson(String str) =>
      TourLoadingData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourLoadingData.fromMap(Map<String, dynamic> json) =>
      TourLoadingData(
        getTourServiceCards: json["getTourServiceCards"] == null
            ? null
            : GetTourServiceCards.fromMap(json["getTourServiceCards"]),
      );

  Map<String, dynamic> toMap() => {
    "getTourServiceCards": getTourServiceCards == null ? null : getTourServiceCards!.toMap(),
  };
}

class GetTourServiceCards {
  GetTourServiceCards({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTourServiceCards.fromJson(String str) =>
      GetTourServiceCards.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTourServiceCards.fromMap(Map<String, dynamic> json) => GetTourServiceCards(
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
    this.serviceBackgroundUrl,
  });

  final String? serviceBackgroundUrl;

  factory Data.fromJson(String str) =>
      Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    serviceBackgroundUrl: json["serviceBackgroundUrl"],
  );

  Map<String, dynamic> toMap() => {
    "serviceBackgroundUrl": serviceBackgroundUrl,
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
  final dynamic description;

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
