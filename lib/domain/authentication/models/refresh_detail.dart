import 'dart:convert';

class RefreshDetail {
  RefreshDetail({
    this.getRefreshDetails,
  });

  final GetRefreshDetails? getRefreshDetails;

  factory RefreshDetail.fromJson(String str) =>
      RefreshDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RefreshDetail.fromMap(Map<String, dynamic> json) => RefreshDetail(
        getRefreshDetails: json["getRefreshToken"] == null
            ? null
            : GetRefreshDetails.fromMap(json["getRefreshToken"]),
      );

  Map<String, dynamic> toMap() => {
        "getRefreshToken": getRefreshDetails?.toMap(),
      };
}

class GetRefreshDetails {
  GetRefreshDetails({
    this.data,
    this.status,
  });

  final GetRefreshDetailsData? data;
  final Status? status;

  factory GetRefreshDetails.fromJson(String str) =>
      GetRefreshDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetRefreshDetails.fromMap(Map<String, dynamic> json) =>
      GetRefreshDetails(
        data: json["data"] == null
            ? null
            : GetRefreshDetailsData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
      };
}

class GetRefreshDetailsData {
  GetRefreshDetailsData({
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

  factory GetRefreshDetailsData.fromJson(String str) =>
      GetRefreshDetailsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetRefreshDetailsData.fromMap(Map<String, dynamic> json) =>
      GetRefreshDetailsData(
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
