import 'dart:convert';

class VirtualPaymentModelDomain {
  VirtualPaymentModelDomain({
    this.getVaBalance,
  });

  final GetVaBalance? getVaBalance;

  factory VirtualPaymentModelDomain.fromJson(String str) =>
      VirtualPaymentModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VirtualPaymentModelDomain.fromMap(Map<String, dynamic> json) =>
      VirtualPaymentModelDomain(
        getVaBalance: json["getVaBalance"] == null
            ? null
            : GetVaBalance.fromMap(json["getVaBalance"]),
      );

  Map<String, dynamic> toMap() => {
        "getVaBalance": getVaBalance?.toMap(),
      };
}

class GetVaBalance {
  GetVaBalance({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetVaBalance.fromJson(String str) =>
      GetVaBalance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetVaBalance.fromMap(Map<String, dynamic> json) => GetVaBalance(
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
    this.pocketStatus,
    this.balance,
    this.currency,
    this.balanceStatus,
  });

  final String? pocketStatus;
  final double? balance;
  final String? currency;
  final String? balanceStatus;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        pocketStatus: json["pocketStatus"],
        balance: json["balance"]?.toDouble(),
        currency: json["currency"],
        balanceStatus: json["balanceStatus"],
      );

  Map<String, dynamic> toMap() => {
        "pocketStatus": pocketStatus,
        "balance": balance,
        "currency": currency,
        "balanceStatus": balanceStatus,
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
