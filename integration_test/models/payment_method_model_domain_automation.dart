import 'dart:convert';

class PaymentMethodModelDomainAutomation {
  PaymentMethodModelDomainAutomation({
    this.getCustomerPaymentMethodDetails,
  });

  final GetCustomerPaymentMethodDetailsAutomation?
      getCustomerPaymentMethodDetails;

  factory PaymentMethodModelDomainAutomation.fromJson(String str) =>
      PaymentMethodModelDomainAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentMethodModelDomainAutomation.fromMap(
          Map<String, dynamic> json) =>
      PaymentMethodModelDomainAutomation(
        getCustomerPaymentMethodDetails:
            json["getCustomerPaymentMethodDetails"] == null
                ? null
                : GetCustomerPaymentMethodDetailsAutomation.fromMap(
                    json["getCustomerPaymentMethodDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getCustomerPaymentMethodDetails":
            getCustomerPaymentMethodDetails == null
                ? null
                : getCustomerPaymentMethodDetails!.toMap(),
      };
}

class GetCustomerPaymentMethodDetailsAutomation {
  GetCustomerPaymentMethodDetailsAutomation({
    this.data,
    this.status,
  });

  final DataAutomation? data;
  final StatusAutomation? status;

  factory GetCustomerPaymentMethodDetailsAutomation.fromJson(String str) =>
      GetCustomerPaymentMethodDetailsAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCustomerPaymentMethodDetailsAutomation.fromMap(
          Map<String, dynamic> json) =>
      GetCustomerPaymentMethodDetailsAutomation(
        data:
            json["data"] == null ? null : DataAutomation.fromMap(json["data"]),
        status: json["status"] == null
            ? null
            : StatusAutomation.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
      };
}

class DataAutomation {
  DataAutomation({
    this.cardCurrent,
    this.cardMaximum,
    this.paymentList,
  });

  final int? cardCurrent;
  final int? cardMaximum;
  final List<PaymentListAutomation>? paymentList;

  factory DataAutomation.fromJson(String str) =>
      DataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAutomation.fromMap(Map<String, dynamic> json) => DataAutomation(
        cardCurrent: json["cardCurrent"] == null ? null : json["cardCurrent"],
        cardMaximum: json["cardMaximum"] == null ? null : json["cardMaximum"],
        paymentList: json["paymentList"] == null
            ? null
            : List<PaymentListAutomation>.from(json["paymentList"]
                .map((x) => PaymentListAutomation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "cardCurrent": cardCurrent == null ? null : cardCurrent,
        "cardMaximum": cardMaximum == null ? null : cardMaximum,
        "paymentList": paymentList == null
            ? null
            : List<dynamic>.from(paymentList!.map((x) => x.toMap())),
      };
}

class PaymentListAutomation {
  PaymentListAutomation({
    this.paymentMethodId,
    this.sortSequence,
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
  final String? cardMask;
  final String? cardType;
  final String? paymentType;
  final String? cardBank;
  final bool? defaultMethodFlag;
  final String? nickname;
  final String? paymentStatus;

  factory PaymentListAutomation.fromJson(String str) =>
      PaymentListAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentListAutomation.fromMap(Map<String, dynamic> json) =>
      PaymentListAutomation(
        paymentMethodId:
            json["paymentMethodId"] == null ? null : json["paymentMethodId"],
        sortSequence:
            json["sortSequence"] == null ? null : json["sortSequence"],
        cardMask: json["cardMask"] == null ? null : json["cardMask"],
        cardType: json["cardType"] == null ? null : json["cardType"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        cardBank: json["cardBank"] == null ? null : json["cardBank"],
        defaultMethodFlag: json["defaultMethodFlag"] == null
            ? null
            : json["defaultMethodFlag"],
        nickname: json["nickname"] == null ? null : json["nickname"],
        paymentStatus:
            json["paymentStatus"] == null ? null : json["paymentStatus"],
      );

  Map<String, dynamic> toMap() => {
        "paymentMethodId": paymentMethodId == null ? null : paymentMethodId,
        "sortSequence": sortSequence == null ? null : sortSequence,
        "cardMask": cardMask == null ? null : cardMask,
        "cardType": cardType == null ? null : cardType,
        "paymentType": paymentType == null ? null : paymentType,
        "cardBank": cardBank == null ? null : cardBank,
        "defaultMethodFlag":
            defaultMethodFlag == null ? null : defaultMethodFlag,
        "nickname": nickname == null ? null : nickname,
        "paymentStatus": paymentStatus == null ? null : paymentStatus,
      };
}

class StatusAutomation {
  StatusAutomation({
    this.code,
    this.header,
    this.description,
  });

  final String? code;
  final String? header;
  final String? description;

  factory StatusAutomation.fromJson(String str) =>
      StatusAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusAutomation.fromMap(Map<String, dynamic> json) =>
      StatusAutomation(
        code: json["code"] == null ? null : json["code"],
        header: json["header"] == null ? null : json["header"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "header": header == null ? null : header,
        "description": description == null ? null : description,
      };
}
