import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/favourites/models/favourites_all_model_domain.dart';

import '../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("favourites/favorites_data.json");
  FavouritesAllModelDomain favouritesAllModelDomain =
      FavouritesAllModelDomain.fromJson(json);

  test("FavouritesAllModelDomain test", () {
    FavouritesAllModelDomain model = favouritesAllModelDomain;
    expect(model.getFavorites != null, true);

    favouritesAllModelDomain.getFavorites?.toJson();
    favouritesAllModelDomain.getFavorites?.toMap();

    favouritesAllModelDomain.getFavorites?.data?.toJson();
    favouritesAllModelDomain.getFavorites?.data?.toMap();

    favouritesAllModelDomain.getFavorites?.status?.toMap();

    Map<String, dynamic> map = model.toMap();

    FavouritesAllModelDomain mapFromModel =
        FavouritesAllModelDomain.fromMap(map);
    expect(mapFromModel.getFavorites != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("AllPromotionList test", () {
    AllPromotionList model = AllPromotionList(startDate: DateTime.now());
    expect(model.productType != null, false);

    Map<String, dynamic> map = model.toMap();

    AllPromotionList mapFromModel = AllPromotionList.fromMap(map);
    expect(mapFromModel.productType != null, false);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
}
