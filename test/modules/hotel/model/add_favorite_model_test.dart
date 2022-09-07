import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  test("Add Favotite Model Test", () {
    Map<String, dynamic> jsonMap =
        json.decode(fixture("hotel/add_favorite.json"));

    ///For class Hotel
    AddFavoriteModelDomain addFavoriteModel =
        AddFavoriteModelDomain.fromMap(jsonMap);
    String jsonStringData = addFavoriteModel.toJson();
    AddFavoriteModelDomain addFavJson =
        AddFavoriteModelDomain.fromJson(jsonStringData);
    expect(addFavJson.addFavorite != null, true);

    ///For class Data
    AddFavorite? addFavorite = addFavoriteModel.addFavorite;
    String? dataString = addFavorite?.toJson();
    AddFavorite? dataJson = AddFavorite?.fromJson(dataString ?? '');
    expect(dataJson.status != null, true);

    ///For class Status
    Status? status = addFavoriteModel.addFavorite?.status;
    String? statusStringData = status?.toJson();
    Status statusJson = Status?.fromJson(statusStringData ?? '');
    expect(statusJson.code != null, true);
  });
}
