import 'dart:convert';

class RemovePromoCodeModelDomain {
  RemovePromoCodeModelDomain({
    this.removePromoCode,
  });

  RemovePromoCode? removePromoCode;

  factory RemovePromoCodeModelDomain.fromJson(String str) =>
      RemovePromoCodeModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RemovePromoCodeModelDomain.fromMap(Map<String, dynamic> json) =>
      RemovePromoCodeModelDomain(
        removePromoCode: json["removePromoCode"] == null
            ? null
            : RemovePromoCode.fromMap(json["removePromoCode"]),
      );

  Map<String, dynamic> toMap() => {
        "removePromoCode": removePromoCode?.toMap(),
      };
}

class RemovePromoCode {
  RemovePromoCode({
    this.data,
    this.status,
  });

  RemovePromoCodeData? data;
  Status? status;

  factory RemovePromoCode.fromJson(String str) =>
      RemovePromoCode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RemovePromoCode.fromMap(Map<String, dynamic> json) => RemovePromoCode(
        data: json["data"] == null
            ? null
            : RemovePromoCodeData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class RemovePromoCodeData {
  RemovePromoCodeData({
    this.removed,
    this.priceDetails,
  });

  bool? removed;
  PriceDetails? priceDetails;

  factory RemovePromoCodeData.fromJson(String str) =>
      RemovePromoCodeData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RemovePromoCodeData.fromMap(Map<String, dynamic> json) =>
      RemovePromoCodeData(
        removed: json["removed"],
        priceDetails: json["priceDetails"] != null
            ? PriceDetails.fromMap(json["priceDetails"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "removed": removed,
        "priceDetails": priceDetails?.toMap(),
      };
}

class PriceDetails {
  PriceDetails({
    this.orderPrice,
    this.addonPrice,
    this.totalAmount,
  });

  double? orderPrice;
  double? addonPrice;
  double? totalAmount;

  factory PriceDetails.fromJson(String str) =>
      PriceDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PriceDetails.fromMap(Map<String, dynamic> json) => PriceDetails(
        orderPrice: json["orderPrice"]?.toDouble(),
        addonPrice: json["addonPrice"]?.toDouble(),
        totalAmount: json["totalAmount"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "orderPrice": orderPrice,
        "addonPrice": addonPrice,
        "totalAmount": totalAmount,
      };
}

class Status {
  Status({
    this.code,
    this.header,
    this.description,
  });

  String? code;
  String? header;
  String? description;

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
