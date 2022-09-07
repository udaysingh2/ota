import 'dart:convert';

class OtaUpdateCustomerDetailsData {
  OtaUpdateCustomerDetailsData({
    this.updateCustomerDetails,
  });

  final UpdateCustomerDetails? updateCustomerDetails;

  factory OtaUpdateCustomerDetailsData.fromJson(String str) =>
      OtaUpdateCustomerDetailsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaUpdateCustomerDetailsData.fromMap(Map<String, dynamic> json) =>
      OtaUpdateCustomerDetailsData(
        updateCustomerDetails: json["updateCustomerDetails"] == null
            ? null
            : UpdateCustomerDetails.fromMap(json["updateCustomerDetails"]),
      );

  Map<String, dynamic> toMap() => {
    "updateCustomerDetails": updateCustomerDetails == null ? null : updateCustomerDetails!.toMap(),
  };
}

class UpdateCustomerDetails {
  UpdateCustomerDetails({
    this.status,
  });

  final Status? status;

  factory UpdateCustomerDetails.fromJson(String str) =>
      UpdateCustomerDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateCustomerDetails.fromMap(Map<String, dynamic> json) => UpdateCustomerDetails(
    status: json["status"] == null ? null : Status.fromMap(json["status"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status!.toMap(),
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
