// To parse this JSON data, do
//
//     final galleryModelDomain = galleryModelDomainFromMap(jsonString);

import 'dart:convert';

class GalleryModelDomain {
  GalleryModelDomain({
    this.getAllTourImages,
    this.getAllTicketImages,
  });

  final GetAllTourImages? getAllTourImages;
  final GetAllTicketImages? getAllTicketImages;
  factory GalleryModelDomain.fromJson(String str) =>
      GalleryModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GalleryModelDomain.fromMap(Map<String, dynamic> json) =>
      GalleryModelDomain(
        getAllTourImages: json["getAllTourImages"] == null
            ? null
            : GetAllTourImages.fromMap(json["getAllTourImages"]),
        getAllTicketImages: json["getAllTicketImages"] == null
            ? null
            : GetAllTicketImages.fromMap(json["getAllTicketImages"]),
      );

  Map<String, dynamic> toMap() => {
        "getAllTourImages":
            getAllTourImages == null ? null : getAllTourImages!.toMap(),
        "getAllTicketImages":
            getAllTicketImages == null ? null : getAllTicketImages!.toMap(),
      };
}

class GetAllTourImages {
  GetAllTourImages({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetAllTourImages.fromJson(String str) =>
      GetAllTourImages.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllTourImages.fromMap(Map<String, dynamic> json) =>
      GetAllTourImages(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
      };
}

class GetAllTicketImages {
  GetAllTicketImages({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetAllTicketImages.fromJson(String str) =>
      GetAllTicketImages.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllTicketImages.fromMap(Map<String, dynamic> json) =>
      GetAllTicketImages(
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
    this.images,
  });

  final List<String>? images;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
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
