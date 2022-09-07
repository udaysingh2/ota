import 'dart:convert';
import 'package:ota/domain/gallery/models/hotel_detail_model.dart';

class DataModel {
  final HotelDetailModel? hotelDetail;

  DataModel({
    this.hotelDetail,
  });

  factory DataModel.fromJson(String str) => DataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
        hotelDetail: json["data"] == null
            ? null
            : HotelDetailModel.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "hotelDetail": hotelDetail == null ? null : hotelDetail!.toMap(),
      };
}
