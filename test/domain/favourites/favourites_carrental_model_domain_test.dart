import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/favourites/models/favourites_carrental_model_domain.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  String emptyResponseMock = '''
{
  "getAllFavorites": {
    "status": {
      "code": "1000",
			"description": "Success",
			"header": ""
		},
    "data": {
      "favorites": [{
          "hotelId": "MA15062148",
          "hotelName": "Money Motel",
          "cityId": "MA05110041",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Money Motel",
          "promotionList":[{
            "line1":"abc",
            "line2":"def",
            "promotionType":"OVERLAY"
          }]
        },
        {
          "hotelId": "MA1912002718",
          "hotelName": "Rimping Boutique Chiangmai",
          "cityId": "MA05110001",
          "countryId": "MA05110001",
          "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
          "latitude": 33.43,
          "longitude": 99.32,
          "location": "Morakot Road",
          "promotionList":[{
            "line1":"abc"
          }]
        }]
    }
  }
}
''';

  FavouritesCarRentalModelDomain.fromJson(emptyResponseMock);

  test("FavouritesCarRentalModelDomain test", () {
    FavouritesCarRentalModelDomain model =
        FavouritesCarRentalModelDomain(getAllFavorites: GetAllFavorites());
    expect(model.getAllFavorites != null, true);

    Map<String, dynamic> map = model.toMap();

    FavouritesCarRentalModelDomain mapFromModel =
        FavouritesCarRentalModelDomain.fromMap(map);
    expect(mapFromModel.getAllFavorites != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("GetAllFavorites test", () {
    GetAllFavorites? model =
        GetAllFavorites(data: GetAllFavoritesData(favorites: [Favorite()]));
    expect(model.data != null, true);

    Map<String, dynamic>? map = model.toMap();

    GetAllFavorites mapFromModel = GetAllFavorites.fromMap(map);
    expect(mapFromModel.data != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("Favorite test", () {
    Favorite? model =
        Favorite(location: "dfghj", promotionList: [CarPromotionList()]);
    expect(model.location != null, true);

    Map<String, dynamic>? map = model.toMap();

    Favorite mapFromModel = Favorite.fromMap(map);
    expect(mapFromModel.location != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("CarPromotionList test", () {
    CarPromotionList? model =
        CarPromotionList(productType: "productType", startDate: DateTime.now());
    expect(model.productType != null, true);

    Map<String, dynamic>? map = model.toMap();

    CarPromotionList mapFromModel = CarPromotionList.fromMap(map);
    expect(mapFromModel.productType != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("Status test", () {
    Status? model = Status(code: "code");
    expect(model.code != null, true);

    Map<String, dynamic>? map = model.toMap();

    Status mapFromModel = Status.fromMap(map);
    expect(mapFromModel.code != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
}
