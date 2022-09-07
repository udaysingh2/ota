import 'dart:convert';

import 'package:ota/domain/gallery/models/images_model.dart';

class HotelDetailModelAutomation {
  final ImagesModel? images;

  HotelDetailModelAutomation({
    this.images,
  });

  factory HotelDetailModelAutomation.fromJson(String str) =>
      HotelDetailModelAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelDetailModelAutomation.fromMap(Map<String, dynamic> json) =>
      HotelDetailModelAutomation(
        images:
            json["images"] == null ? null : ImagesModel.fromMap(json["images"]),
      );

  Map<String, dynamic> toMap() => {
        "images": images == null ? null : images!.toMap(),
      };
}
