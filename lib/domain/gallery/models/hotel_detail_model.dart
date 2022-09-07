import 'dart:convert';

import 'package:ota/domain/gallery/models/images_model.dart';

class HotelDetailModel {
  final ImagesModel? images;

  HotelDetailModel({
    this.images,
  });

  factory HotelDetailModel.fromJson(String str) =>
      HotelDetailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelDetailModel.fromMap(Map<String, dynamic> json) =>
      HotelDetailModel(
        images:
            json["images"] == null ? null : ImagesModel.fromMap(json["images"]),
      );

  Map<String, dynamic> toMap() => {
        "images": images == null ? null : images!.toMap(),
      };
}
