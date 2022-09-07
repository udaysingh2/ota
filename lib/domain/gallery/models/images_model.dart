import 'dart:convert';

class ImagesModel {
  final String? baseUri;
  final String? cover;
  final int? galleryCount;
  final List<String?>? gallery;

  ImagesModel({
    this.baseUri,
    this.cover,
    this.galleryCount,
    this.gallery,
  });

  factory ImagesModel.fromJson(String str) =>
      ImagesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImagesModel.fromMap(Map<String, dynamic> json) => ImagesModel(
        baseUri: json["baseUri"],
        cover: json["cover"],
        galleryCount: json["galleryCount"],
        gallery: json["gallery"] == null
            ? null
            : List<String>.from(json["gallery"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "baseUri": baseUri,
        "cover": cover,
        "galleryCount": galleryCount,
        "gallery":
            gallery == null ? null : List<dynamic>.from(gallery!.map((x) => x)),
      };
}
