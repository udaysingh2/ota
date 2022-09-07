import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/favourites/models/favourites_add_service_domain.dart';

import '../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final String json = fixture("favourites/favorite_add.json");
  FavouriteAddServiceDomain favouriteAddServiceDomain =
      FavouriteAddServiceDomain.fromJson(json);

  test("FavouriteAddServiceDomain test", () {
    FavouriteAddServiceDomain model = favouriteAddServiceDomain;
    expect(model.markFavorite != null, true);

    favouriteAddServiceDomain.markFavorite?.toJson();
    favouriteAddServiceDomain.markFavorite?.toMap();

    favouriteAddServiceDomain.markFavorite?.status?.toJson();
    favouriteAddServiceDomain.markFavorite?.status?.toMap();

    Map<String, dynamic> map = model.toMap();

    FavouriteAddServiceDomain mapFromModel =
        FavouriteAddServiceDomain.fromMap(map);
    expect(mapFromModel.markFavorite != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
