import 'dart:convert';

class RoomGalleryModelDomain {
  RoomGalleryModelDomain({
    this.getRoomImages,
  });

  final GetRoomImages? getRoomImages;

  factory RoomGalleryModelDomain.fromJson(String str) =>
      RoomGalleryModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomGalleryModelDomain.fromMap(Map<String, dynamic> json) =>
      RoomGalleryModelDomain(
        getRoomImages: json["getRoomImages"] == null
            ? null
            : GetRoomImages.fromMap(json["getRoomImages"]),
      );

  Map<String, dynamic> toMap() => {
        "getRoomImages": getRoomImages == null ? null : getRoomImages!.toMap(),
      };
}

class GetRoomImages {
  GetRoomImages({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetRoomImages.fromJson(String str) =>
      GetRoomImages.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetRoomImages.fromMap(Map<String, dynamic> json) => GetRoomImages(
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
    this.roomImageCount,
    this.images,
  });

  final int? roomImageCount;
  final List<Image>? images;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        roomImageCount: json["roomImageCount"],
        images: json["images"] == null
            ? null
            : List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "roomImageCount": roomImageCount,
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toMap())),
      };
}

class Image {
  Image({
    this.url,
  });

  final String? url;

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        url: json["URL"],
      );

  Map<String, dynamic> toMap() => {
        "URL": url,
      };
}

class Status {
  Status({
    this.description,
    this.header,
    this.code,
  });

  final String? description;
  final String? header;
  final String? code;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        description: json["description"],
        header: json["header"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "header": header,
        "code": code,
      };
}
