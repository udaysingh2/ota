import 'dart:convert';

import 'package:ota/domain/gallery/models/data_model.dart';

class GalleryResultModel {
  final DataModel? data;

  GalleryResultModel({
    this.data,
  });

  factory GalleryResultModel.fromJson(String str) =>
      GalleryResultModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GalleryResultModel.fromMap(Map<String, dynamic> json) =>
      GalleryResultModel(
        data: json["getImages"] == null
            ? null
            : DataModel.fromMap(json["getImages"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}
