import 'dart:convert';

class CarBookingMailerModelDomain {
  CarBookingMailerModelDomain({
    this.sendEmailConfirmation,
  });

  final SendEmailConfirmation? sendEmailConfirmation;

  factory CarBookingMailerModelDomain.fromJson(String str) =>
      CarBookingMailerModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarBookingMailerModelDomain.fromMap(Map<String, dynamic> json) =>
      CarBookingMailerModelDomain(
        sendEmailConfirmation: json["sendEmailConfirmation"] == null
            ? null
            : SendEmailConfirmation.fromMap(json["sendEmailConfirmation"]),
      );

  Map<String, dynamic> toMap() => {
        "sendEmailConfirmation": sendEmailConfirmation == null
            ? null
            : sendEmailConfirmation!.toMap(),
      };
}

class SendEmailConfirmation {
  SendEmailConfirmation({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory SendEmailConfirmation.fromJson(String str) =>
      SendEmailConfirmation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SendEmailConfirmation.fromMap(Map<String, dynamic> json) =>
      SendEmailConfirmation(
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
    this.actionStatus,
  });

  final String? actionStatus;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        actionStatus: json["actionStatus"],
      );

  Map<String, dynamic> toMap() => {
        "actionStatus": actionStatus,
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
