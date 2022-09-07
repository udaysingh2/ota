import 'dart:convert';

class AuthModel {
  AuthModel({
    this.idToken,
    this.accessToken,
  });

  final String? idToken;
  final String? accessToken;

  factory AuthModel.fromJson(String str) => AuthModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
        idToken: json["idToken"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toMap() => {
        "idToken": idToken,
        "accessToken": accessToken,
      };
}
