import 'dart:convert';

class PaymentMethodModelDomain {
  PaymentMethodModelDomain({
    this.getCustomerPaymentMethodDetails,
  });

  final GetCustomerPaymentMethodDetails? getCustomerPaymentMethodDetails;

  factory PaymentMethodModelDomain.fromJson(String str) =>
      PaymentMethodModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentMethodModelDomain.fromMap(Map<String, dynamic> json) =>
      PaymentMethodModelDomain(
        getCustomerPaymentMethodDetails:
            json["getCustomerPaymentMethodDetails"] == null
                ? null
                : GetCustomerPaymentMethodDetails.fromMap(
                    json["getCustomerPaymentMethodDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getCustomerPaymentMethodDetails":
            getCustomerPaymentMethodDetails == null
                ? null
                : getCustomerPaymentMethodDetails!.toMap(),
      };
}

class GetCustomerPaymentMethodDetails {
  GetCustomerPaymentMethodDetails({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetCustomerPaymentMethodDetails.fromJson(String str) =>
      GetCustomerPaymentMethodDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCustomerPaymentMethodDetails.fromMap(Map<String, dynamic> json) =>
      GetCustomerPaymentMethodDetails(
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
    this.cardCurrent,
    this.cardMaximum,
    this.paymentList,
  });

  final int? cardCurrent;
  final int? cardMaximum;
  final List<PaymentList>? paymentList;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        cardCurrent: json["cardCurrent"],
        cardMaximum: json["cardMaximum"],
        paymentList: json["paymentList"] == null
            ? null
            : List<PaymentList>.from(
                json["paymentList"].map((x) => PaymentList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "cardCurrent": cardCurrent,
        "cardMaximum": cardMaximum,
        "paymentList": paymentList == null
            ? null
            : List<dynamic>.from(paymentList!.map((x) => x.toMap())),
      };
}

class PaymentList {
  PaymentList({
    this.paymentMethodId,
    this.sortSequence,
    this.cardRef,
    this.cardMask,
    this.cardType,
    this.paymentType,
    this.cardBank,
    this.defaultMethodFlag,
    this.nickname,
    this.paymentStatus,
  });

  final String? paymentMethodId;
  final int? sortSequence;
  final String? cardRef;
  final String? cardMask;
  final String? cardType;
  final String? paymentType;
  final String? cardBank;
  final bool? defaultMethodFlag;
  final String? nickname;
  final String? paymentStatus;

  factory PaymentList.fromJson(String str) =>
      PaymentList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentList.fromMap(Map<String, dynamic> json) => PaymentList(
        paymentMethodId: json["paymentMethodId"],
        sortSequence: json["sortSequence"],
        cardRef: json["cardRef"],
        cardMask: json["cardMask"],
        cardType: json["cardType"],
        paymentType: json["paymentType"],
        cardBank: json["cardBank"],
        defaultMethodFlag: json["defaultMethodFlag"],
        nickname: json["nickname"],
        paymentStatus: json["paymentStatus"],
      );

  Map<String, dynamic> toMap() => {
        "paymentMethodId": paymentMethodId,
        "sortSequence": sortSequence,
        "cardRef": cardRef,
        "cardMask": cardMask,
        "cardType": cardType,
        "paymentType": paymentType,
        "cardBank": cardBank,
        "defaultMethodFlag": defaultMethodFlag,
        "nickname": nickname,
        "paymentStatus": paymentStatus,
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
