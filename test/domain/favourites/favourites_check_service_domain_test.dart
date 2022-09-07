import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/favourites/models/favourites_check_service_domain.dart';

import '../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final String json = fixture("favourites/favorite_check.json");

  FavouriteCheckServiceDomain favouriteCheckServiceDomain =
      FavouriteCheckServiceDomain.fromJson(json);

  test("FavouriteCheckServiceDomain test", () {
    FavouriteCheckServiceDomain model = favouriteCheckServiceDomain;
    expect(model.isFavorite != null, true);

    favouriteCheckServiceDomain.isFavorite?.toJson();
    favouriteCheckServiceDomain.isFavorite?.toMap();

    favouriteCheckServiceDomain.isFavorite?.data?.toJson();
    favouriteCheckServiceDomain.isFavorite?.data?.toMap();

    favouriteCheckServiceDomain.isFavorite?.status?.toJson();
    favouriteCheckServiceDomain.isFavorite?.status?.toMap();

    Map<String, dynamic> map = model.toMap();

    FavouriteCheckServiceDomain mapFromModel =
        FavouriteCheckServiceDomain.fromMap(map);
    expect(mapFromModel.isFavorite != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
