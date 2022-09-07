import 'dart:convert';

import 'package:ota/domain/gallery/models/hotel_detail_model.dart';

class DataModelAutomation {
  final HotelDetailModel? hotelDetail;

  DataModelAutomation({
    this.hotelDetail,
  });

  factory DataModelAutomation.fromJson(String str) =>
      DataModelAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataModelAutomation.fromMap(Map<String, dynamic> json) =>
      DataModelAutomation(
        hotelDetail: json["data"] == null
            ? null
            : HotelDetailModel.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "hotelDetail": hotelDetail == null ? null : hotelDetail!.toMap(),
      };
}
