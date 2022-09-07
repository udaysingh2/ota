import 'dart:convert';

class PreferencesSubmitModelDomain {
  PreferencesSubmitModelDomain({
    this.createPreference,
  });

  final CreatePreference? createPreference;

  factory PreferencesSubmitModelDomain.fromJson(String str) =>
      PreferencesSubmitModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PreferencesSubmitModelDomain.fromMap(Map<String, dynamic> json) =>
      PreferencesSubmitModelDomain(
        createPreference: json["createPreference"] == null
            ? null
            : CreatePreference.fromMap(json["createPreference"]),
      );

  Map<String, dynamic> toMap() => {
        "createPreference":
            createPreference == null ? null : createPreference!.toMap(),
      };
}

class CreatePreference {
  CreatePreference({
    this.status,
  });

  final Status? status;

  factory CreatePreference.fromJson(String str) =>
      CreatePreference.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatePreference.fromMap(Map<String, dynamic> json) =>
      CreatePreference(
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
