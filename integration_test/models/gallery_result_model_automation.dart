import 'dart:convert';

import 'package:ota/domain/gallery/models/data_model.dart';

class GalleryResultModelAutomation {
  final DataModel? data;

  GalleryResultModelAutomation({
    this.data,
  });

  factory GalleryResultModelAutomation.fromJson(String str) =>
      GalleryResultModelAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GalleryResultModelAutomation.fromMap(Map<String, dynamic> json) =>
      GalleryResultModelAutomation(
        data: json["getImages"] == null
            ? null
            : DataModel.fromMap(json["getImages"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}
