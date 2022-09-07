import 'dart:convert';

class ImagesModelAutomation {
  final String? baseUri;
  final String? cover;
  final int? galleryCount;
  final List<String?>? gallery;

  ImagesModelAutomation({
    this.baseUri,
    this.cover,
    this.galleryCount,
    this.gallery,
  });

  factory ImagesModelAutomation.fromJson(String str) =>
      ImagesModelAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImagesModelAutomation.fromMap(Map<String, dynamic> json) =>
      ImagesModelAutomation(
        baseUri: json["baseUri"] == null ? null : json["baseUri"],
        cover: json["cover"] == null ? null : json["cover"],
        galleryCount:
            json["galleryCount"] == null ? null : json["galleryCount"],
        gallery: json["gallery"] == null
            ? null
            : List<String>.from(json["gallery"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "baseUri": baseUri == null ? null : baseUri,
        "cover": cover == null ? null : cover,
        "galleryCount": galleryCount == null ? null : galleryCount,
        "gallery":
            gallery == null ? null : List<dynamic>.from(gallery!.map((x) => x)),
      };
}
