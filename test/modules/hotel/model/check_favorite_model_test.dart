import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  test("check Favotite Model Test", () {
    Map<String, dynamic> jsonMap =
        json.decode(fixture("hotel/check_favorite.json"));

    ///For class Hotel
    IsFavoritesDomain isFavoriteModel = IsFavoritesDomain.fromMap(jsonMap);
    String jsonStringData = isFavoriteModel.toJson();
    IsFavoritesDomain isFavJson = IsFavoritesDomain.fromJson(jsonStringData);
    expect(isFavJson.checkFavorites != null, true);

    ///For class Data
    CheckFavorites? checkFavorite = isFavoriteModel.checkFavorites;
    String? checkFavString = checkFavorite?.toJson();
    CheckFavorites? checkJson = CheckFavorites?.fromJson(checkFavString ?? '');
    expect(checkJson.data != null, true);

    ///For class Data
    Data? data = isFavoriteModel.checkFavorites?.data;
    String? dataString = data?.toJson();
    Data? dataJson = Data?.fromJson(dataString ?? '');
    expect(dataJson.isFavorite != null, true);

    ///For class Status
    Status? status = isFavoriteModel.checkFavorites?.status;
    expect(status?.code != null, true);
  });
}
