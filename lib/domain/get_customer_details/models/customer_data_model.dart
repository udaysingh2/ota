// To parse this JSON data, do
//
//     final customerData = customerDataFromMap(jsonString);

import 'dart:convert';

class CustomerData {
  CustomerData({
    this.status,
    this.data,
  });

  final Status? status;
  final Data? data;

  factory CustomerData.fromJson(String str) =>
      CustomerData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerData.fromMap(Map<String, dynamic> json) => CustomerData(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status?.toMap(),
        "data": data?.toMap(),
      };
}

class Data {
  Data({this.firstName, this.lastName, this.email, this.phoneNumber});

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

  final int? code;
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
