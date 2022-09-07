import 'dart:convert';

class InsuranceModelDomain {
  InsuranceModelDomain({
    this.getInsurance,
  });

  final GetInsurance? getInsurance;

  factory InsuranceModelDomain.fromJson(String str) =>
      InsuranceModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InsuranceModelDomain.fromMap(Map<String, dynamic> json) =>
      InsuranceModelDomain(
        getInsurance: json["getInsurance"] == null
            ? null
            : GetInsurance.fromMap(json["getInsurance"]),
      );

  Map<String, dynamic> toMap() => {
        "getInsurance": getInsurance?.toMap(),
      };
}

class GetInsurance {
  GetInsurance({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetInsurance.fromJson(String str) =>
      GetInsurance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetInsurance.fromMap(Map<String, dynamic> json) => GetInsurance(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class Data {
  Data({
    this.serviceBackgroundUrl,
    this.insuranceHeaderTitle,
    this.insuranceFooterTitle,
    this.insurances,
  });

  final String? serviceBackgroundUrl;
  final String? insuranceHeaderTitle;
  final String? insuranceFooterTitle;
  final List<Insurance>? insurances;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        serviceBackgroundUrl: json["serviceBackgroundUrl"],
        insuranceHeaderTitle: json["insuranceHeaderTitle"],
        insuranceFooterTitle: json["insuranceFooterTitle"],
        insurances: json["insurances"] == null
            ? null
            : List<Insurance>.from(
                json["insurances"].map((x) => Insurance.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "serviceBackgroundUrl": serviceBackgroundUrl,
        "insuranceHeaderTitle": insuranceHeaderTitle,
        "insuranceFooterTitle": insuranceFooterTitle,
        "insurances": insurances == null
            ? null
            : List<dynamic>.from(insurances!.map((x) => x.toMap())),
      };
}

class Insurance {
  Insurance({
    this.insuranceId,
    this.sortSeqNo,
    this.insuranceImage,
    this.insuranceTitle,
    this.insuranceDetail,
    this.promotions,
    this.popup,
    this.insuranceCategories,
    this.recommendedForServices,
  });

  final int? insuranceId;
  final int? sortSeqNo;
  final String? insuranceImage;
  final String? insuranceTitle;
  final String? insuranceDetail;
  final Promotions? promotions;
  final Popup? popup;
  final List<String>? insuranceCategories;
  final List<String>? recommendedForServices;

  factory Insurance.fromJson(String str) => Insurance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Insurance.fromMap(Map<String, dynamic> json) => Insurance(
        insuranceId: json["insuranceId"],
        sortSeqNo: json["sortSeqNo"],
        insuranceImage: json["insuranceImage"],
        insuranceTitle: json["insuranceTitle"],
        insuranceDetail: json["insuranceDetail"],
        promotions: json["promotions"] == null
            ? null
            : Promotions.fromMap(json["promotions"]),
        popup: json["popup"] == null ? null : Popup.fromMap(json["popup"]),
        insuranceCategories: json["insuranceCategories"] == null
            ? null
            : List<String>.from(json["insuranceCategories"].map((x) => x)),
        recommendedForServices: json["recommendedForServices"] == null
            ? null
            : List<String>.from(json["recommendedForServices"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "insuranceId": insuranceId,
        "sortSeqNo": sortSeqNo,
        "insuranceImage": insuranceImage,
        "insuranceTitle": insuranceTitle,
        "insuranceDetail": insuranceDetail,
        "promotions": promotions?.toMap(),
        "popup": popup?.toMap(),
        "insuranceCategories": insuranceCategories == null
            ? null
            : List<dynamic>.from(insuranceCategories!.map((x) => x)),
        "recommendedForServices": recommendedForServices == null
            ? null
            : List<dynamic>.from(recommendedForServices!.map((x) => x)),
      };
}

class Popup {
  Popup({
    this.body,
    this.actionType,
    this.actionUrl,
  });

  final String? body;
  final String? actionType;
  final String? actionUrl;

  factory Popup.fromJson(String str) => Popup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Popup.fromMap(Map<String, dynamic> json) => Popup(
        body: json["body"],
        actionType: json["actionType"],
        actionUrl: json["actionUrl"],
      );

  Map<String, dynamic> toMap() => {
        "body": body,
        "actionType": actionType,
        "actionUrl": actionUrl,
      };
}

class Promotions {
  Promotions({
    this.type,
    this.promotionTextLine1,
  });

  final String? type;
  final String? promotionTextLine1;

  factory Promotions.fromJson(String str) =>
      Promotions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Promotions.fromMap(Map<String, dynamic> json) => Promotions(
        type: json["type"],
        promotionTextLine1: json["promotionTextLine1"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "promotionTextLine1": promotionTextLine1,
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
