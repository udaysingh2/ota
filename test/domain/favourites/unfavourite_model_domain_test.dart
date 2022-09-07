import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/favourites/models/unfavourite_model_domain.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  var removeFavoriteMock = """
{
        "status": {
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
      UnFavouriteModelDomain favouriteRemoveServiceDomain =
          UnFavouriteModelDomain.fromJson(removeFavoriteMock);
      favouriteRemoveServiceDomain.toMap();
    });
  });
}
