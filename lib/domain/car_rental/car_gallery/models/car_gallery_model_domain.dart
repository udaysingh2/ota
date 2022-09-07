import 'dart:convert';

class CarGalleryModelDomain {
  CarGalleryModelDomain({
    this.getAllCarRentalImages,
  });

  final GetAllCarRentalImages? getAllCarRentalImages;

  factory CarGalleryModelDomain.fromJson(String str) =>
      CarGalleryModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarGalleryModelDomain.fromMap(Map<String, dynamic> json) =>
      CarGalleryModelDomain(
        getAllCarRentalImages: json["getAllCarRentalImages"] == null
            ? null
            : GetAllCarRentalImages.fromMap(json["getAllCarRentalImages"]),
      );

  Map<String, dynamic> toMap() => {
        "getAllCarRentalImages": getAllCarRentalImages == null
            ? null
            : getAllCarRentalImages!.toMap(),
      };
}

class GetAllCarRentalImages {
  GetAllCarRentalImages({
    this.data,
  });

  final GetAllCarRentalImagesData? data;

  factory GetAllCarRentalImages.fromJson(String str) =>
      GetAllCarRentalImages.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllCarRentalImages.fromMap(Map<String, dynamic> json) =>
      GetAllCarRentalImages(
        data: json["data"] == null
            ? null
            : GetAllCarRentalImagesData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}

class GetAllCarRentalImagesData {
  GetAllCarRentalImagesData({
    this.id,
    this.images,
  });

  final String? id;
  final List<Image>? images;

  factory GetAllCarRentalImagesData.fromJson(String str) =>
      GetAllCarRentalImagesData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllCarRentalImagesData.fromMap(Map<String, dynamic> json) =>
      GetAllCarRentalImagesData(
        id: json["id"] == null ? null : json["id"]!,
        images: json["images"] == null
            ? null
            : List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id!,
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toMap())),
      };
}

class Image {
  Image({
    this.thumb,
    this.full,
  });

  final String? thumb;
  final String? full;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        thumb: json["thumb"] == null ? null : json["thumb"]!,
        full: json["full"] == null ? null : json["full"]!,
      );

  Map<String, dynamic> toMap() => {
        "thumb": thumb == null ? null : thumb!,
        "full": full == null ? null : full!,
      };
}
