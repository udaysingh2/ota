import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_model_domain.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  var responseMock = """
{
	"getTourRecentlyViewedItems": {
		"data": {
			"recentViewPlaylist": [{
					"id": "MA2111000168",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"name": "Dream World(Hello We Sell Tour & Ticket)",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"locationName": "Rangsit-Bangkok",
					"category": "Theme park",
					"type": "TICKET",
					"promotions": [{
							"productId": "MA2111000168",
							"productType": "TICKET",
							"promotionType": "OVERLAY",
							"promotionCode": "FREEDELIVERY",
							"line1": "Free delivery",
							"line2": "",
							"startDate": "2021-10-15 00:00:00",
							"endDate": "2022-10-20 23:59:00",
							"title": "ฟรีค่าส่งอาหารโรบินฮู้ด"
						},
						{
							"productId": "GLOBAL",
							"productType": "TICKET",
							"promotionType": "CAPSULE",
							"promotionCode": "228",
							"line1": "Free Food Delivery",
							"line2": "",
							"startDate": "2022-06-21 00:00:00",
							"endDate": "2022-07-30 23:59:59",
							"title": "Book now get free Robinhood food delivery fee"
						}
					]
				},
				{
					"id": "MA2110000413",
					"cityId": "MA05110041",
					"countryId": "MA05110001",
					"name": "JJ Green Market Tour(Wangthong Garden)",
					"image": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/jj-green-market-tour-ma2110000413-general1.jpg",
					"locationName": "Chatuchak,Bangkok",
					"category": "City Tour",
					"type": "TOUR",
					"promotions": [{
						"productId": "GLOBAL",
						"productType": "TOUR",
						"promotionType": "CAPSULE",
						"promotionCode": "228",
						"line1": "Free Food Delivery",
						"line2": "",
						"startDate": "2022-06-21 00:00:00",
						"endDate": "2022-07-30 23:59:59",
						"title": "Book now get free Robinhood food delivery fee"
					}]
				}
			]
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
""";

  TourRecentPlaylistModelDomain tourRecentPlaylistModelDomain =
      TourRecentPlaylistModelDomain.fromJson(responseMock);

  test("TourRecentPlaylistModelDomain test", () {
    TourRecentPlaylistModelDomain model = tourRecentPlaylistModelDomain;
    expect(model.getTourRecentlyViewedItems != null, true);

    tourRecentPlaylistModelDomain.getTourRecentlyViewedItems?.toJson();
    tourRecentPlaylistModelDomain.getTourRecentlyViewedItems?.toMap();

    tourRecentPlaylistModelDomain.getTourRecentlyViewedItems?.data?.toJson();
    tourRecentPlaylistModelDomain.getTourRecentlyViewedItems?.data?.toMap();

    tourRecentPlaylistModelDomain.getTourRecentlyViewedItems?.status?.toJson();
    tourRecentPlaylistModelDomain.getTourRecentlyViewedItems?.status?.toMap();

    Map<String, dynamic> map = model.toMap();

    TourRecentPlaylistModelDomain mapFromModel =
        TourRecentPlaylistModelDomain.fromMap(map);
    expect(mapFromModel.getTourRecentlyViewedItems != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("RecentViewPlaylist test", () {
    RecentViewPlaylist model = RecentViewPlaylist(location: "sdfghj");
    expect(model.location != null, true);
    model.toJson();

    Map<String, dynamic> map = model.toMap();

    RecentViewPlaylist mapFromModel = RecentViewPlaylist.fromMap(map);
    expect(mapFromModel.location != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("Promotions test", () {
    Promotions model = Promotions(productType: "dfghj");
    expect(model.productType != null, true);
    model.toJson();

    Map<String, dynamic> map = model.toMap();

    Promotions mapFromModel = Promotions.fromMap(map);
    expect(mapFromModel.productType != null, true);

    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
}
