import 'dart:convert';

class LogoutDetail {
  LogoutDetail({
    this.getLogoutDetails,
  });

  final GetLogoutDetails? getLogoutDetails;

  factory LogoutDetail.fromJson(String str) =>
      LogoutDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LogoutDetail.fromMap(Map<String, dynamic> json) => LogoutDetail(
        getLogoutDetails: json["getLogoutDetails"] == null
            ? null
            : GetLogoutDetails.fromMap(json["getLogoutDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getLogoutDetails": getLogoutDetails?.toMap(),
      };
}

class GetLogoutDetails {
  GetLogoutDetails({
    this.status,
  });

  final Status? status;

  factory GetLogoutDetails.fromJson(String str) =>
      GetLogoutDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLogoutDetails.fromMap(Map<String, dynamic> json) =>
      GetLogoutDetails(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status?.toMap(),
      };
}

class Status {
  Status({
    this.description,
    this.header,
    this.code,
  });

  final dynamic description;
  final String? header;
  final String? code;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        description: json["description"],
        header: json["header"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "header": header,
        "code": code,
      };
}
