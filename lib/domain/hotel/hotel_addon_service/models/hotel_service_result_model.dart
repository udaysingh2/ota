import 'dart:convert';

class HotelServiceResultModel {
  HotelServiceResultModel({
    this.getAddonServices,
  });

  final GetAddonServices? getAddonServices;

  factory HotelServiceResultModel.fromJson(String str) =>
      HotelServiceResultModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelServiceResultModel.fromMap(Map<String, dynamic> json) =>
      HotelServiceResultModel(
        getAddonServices: json["getAddonServices"] == null
            ? null
            : GetAddonServices.fromMap(json["getAddonServices"]),
      );

  Map<String, dynamic> toMap() => {
        "getAddonServices":
            getAddonServices == null ? null : getAddonServices!.toMap(),
      };
}

class GetAddonServices {
  GetAddonServices({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetAddonServices.fromJson(String str) =>
      GetAddonServices.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAddonServices.fromMap(Map<String, dynamic> json) =>
      GetAddonServices(
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
    this.hotelEnhancements,
  });

  final List<HotelEnhancement>? hotelEnhancements;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        hotelEnhancements: json["hotelEnhancements"] == null
            ? null
            : List<HotelEnhancement>.from(json["hotelEnhancements"]
                .map((x) => HotelEnhancement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "hotelEnhancements": hotelEnhancements == null
            ? null
            : List<dynamic>.from(hotelEnhancements!.map((x) => x.toMap())),
      };
}

class HotelEnhancement {
  HotelEnhancement({
    this.hotelEnhancementId,
    this.hotelEnhancementName,
    this.currency,
    this.price,
    this.image,
    this.isFlight,
    this.description,
  });

  final String? hotelEnhancementId;
  final String? hotelEnhancementName;
  final String? currency;
  final String? price;
  final String? image;
  final bool? isFlight;
  final String? description;

  factory HotelEnhancement.fromJson(String str) =>
      HotelEnhancement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelEnhancement.fromMap(Map<String, dynamic> json) =>
      HotelEnhancement(
        hotelEnhancementId: json["hotelEnhancementId"],
        hotelEnhancementName: json["hotelEnhancementName"],
        currency: json["currency"],
        price: json["price"],
        image: json["image"],
        isFlight: json["isFlight"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "hotelEnhancementId": hotelEnhancementId,
        "hotelEnhancementName": hotelEnhancementName,
        "currency": currency,
        "price": price,
        "image": image,
        "isFlight": isFlight,
        "description": description,
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
