// To parse this JSON data, do
//
//     final updateCustomerData = updateCustomerDataFromMap(jsonString);

import 'dart:convert';

class UpdateCustomerData {
  UpdateCustomerData({
    this.updateCustomerDetails,
  });

  final UpdateCustomerDetails? updateCustomerDetails;

  factory UpdateCustomerData.fromJson(String str) =>
      UpdateCustomerData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateCustomerData.fromMap(Map<String, dynamic> json) =>
      UpdateCustomerData(
        updateCustomerDetails: json["updateCustomerDetails"] == null
            ? null
            : UpdateCustomerDetails.fromMap(json["updateCustomerDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "updateCustomerDetails": updateCustomerDetails?.toMap(),
      };
}

class UpdateCustomerDetails {
  UpdateCustomerDetails({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory UpdateCustomerDetails.fromJson(String str) =>
      UpdateCustomerDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateCustomerDetails.fromMap(Map<String, dynamic> json) =>
      UpdateCustomerDetails(
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
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
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
