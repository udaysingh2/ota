import 'dart:convert';

class LoginDetail {
  LoginDetail({
    this.getLoginDetails,
  });

  final GetLoginDetails? getLoginDetails;

  factory LoginDetail.fromJson(String str) =>
      LoginDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginDetail.fromMap(Map<String, dynamic> json) => LoginDetail(
        getLoginDetails: json["getLoginDetails"] == null
            ? null
            : GetLoginDetails.fromMap(json["getLoginDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getLoginDetails": getLoginDetails?.toMap(),
      };
}

class GetLoginDetails {
  GetLoginDetails({
    this.data,
    this.status,
  });

  final GetLoginDetailsData? data;
  final Status? status;

  factory GetLoginDetails.fromJson(String str) =>
      GetLoginDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLoginDetails.fromMap(Map<String, dynamic> json) => GetLoginDetails(
        data: json["data"] == null
            ? null
            : GetLoginDetailsData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
      };
}

class GetLoginDetailsData {
  GetLoginDetailsData({
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.scope,
    this.idToken,
  });

  final String? accessToken;
  final String? refreshToken;
  final int? expiresIn;
  final int? refreshExpiresIn;
  final String? scope;
  final String? idToken;

  factory GetLoginDetailsData.fromJson(String str) =>
      GetLoginDetailsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLoginDetailsData.fromMap(Map<String, dynamic> json) =>
      GetLoginDetailsData(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
        refreshExpiresIn: json["refreshExpiresIn"],
        scope: json["scope"],
        idToken: json["idToken"],
      );

  Map<String, dynamic> toMap() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "refreshExpiresIn": refreshExpiresIn,
        "scope": scope,
        "idToken": idToken,
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
