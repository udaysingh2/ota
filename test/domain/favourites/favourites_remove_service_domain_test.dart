import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/favourites/models/favourites_remove_service_domain.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  var removeFavoriteMock = """
{
        "removeFavorite": {
            "status": {
                "code": "1000",
                "header": "Success",
                "description": null
            }
        }
}
""";

  group("Customer model test group", () {
    test('Customer model test', () async {
      FavouriteRemoveServiceDomain favouriteRemoveServiceDomain =
          FavouriteRemoveServiceDomain.fromJson(removeFavoriteMock);
      expect(favouriteRemoveServiceDomain.removeFavorite?.status?.code, '1000');
      favouriteRemoveServiceDomain.toJson();
      favouriteRemoveServiceDomain.toMap();
      favouriteRemoveServiceDomain.removeFavorite?.toMap();
      favouriteRemoveServiceDomain.removeFavorite?.toJson();
      favouriteRemoveServiceDomain.removeFavorite?.status?.toMap();
      favouriteRemoveServiceDomain.removeFavorite?.status?.toJson();
    });
  });
}
