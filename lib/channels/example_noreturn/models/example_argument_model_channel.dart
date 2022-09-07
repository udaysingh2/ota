// To parse this JSON data, do
//
//     final exampleArgumentModelChannel = exampleArgumentModelChannelFromMap(jsonString);

import 'dart:convert';

class ExampleArgumentModelChannel {
  ExampleArgumentModelChannel({
    this.source,
    this.envId,
  });

  final String? source;
  final String? envId;

  factory ExampleArgumentModelChannel.fromJson(String str) =>
      ExampleArgumentModelChannel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExampleArgumentModelChannel.fromMap(Map<String, dynamic> json) =>
      ExampleArgumentModelChannel(
        source: json["source"],
        envId: json["envId"],
      );

  Map<String, dynamic> toMap() => {
        "source": source,
        "envId": envId,
      };
}
