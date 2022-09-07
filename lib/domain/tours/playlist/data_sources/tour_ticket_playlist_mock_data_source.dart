import 'package:ota/domain/tours/playlist/data_sources/tour_ticket_playlist_remote_data_source.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';

class TourTicketPlaylistMockDataSourceImpl
    implements TourTicketPlaylistRemoteDataSource {
  TourTicketPlaylistMockDataSourceImpl();
  @override
  Future<TourTicketPlaylistModelDomain> getTourTicketPlaylistData(
      TourTicketPlaylistArgumentDomain argument) async {
    await Future.delayed(const Duration(seconds: 2));
    return TourTicketPlaylistModelDomain.fromJson(_responseMock);
  }
}

var _responseMock = '''
{
  "getTourAndTicketPlaylist": {
    "data": {
    "playlistId": "30",
    "playlistName": "Recommend Activity",
      "listOfPlaylist": [
        {
          "id": "MA2111000168",
          "cityId": "MA05110041",
          "countryId": "MA05110001",
          "imageUrl": "https://train.travflex.com/SightSeeing/images/350/CL002/sea_life_ocean_world_bangkok-general1.jpg",
          "name": "Sea Life Ocean World Bangkok",
          "locationName": "Mueang",
          "cityName": "Krabi",
          "styleName": "Museum",
          "startPrice": 800.5,
          "promotionText_line1": "ลด 8%",
          "promotionText_line2": "ทุกทัวร์",
          "capsulePromotion": [{
						"name": "Free Food Delivery",
						"code": "FREE01"
					}]
        },
        {
          "id": "MA2110000413",
          "cityId": "MA05110041",
          "countryId": "MA05110001",
          "imageUrl": "https://train.travflex.com/SightSeeing/images/350/CL002/bangkok_temples-general1.jpg",
          "name": "Bangkok Temples",
          "cityName": "Krabi",
          "locationName": "Mueang",
          "startPrice": 800.5,
          "promotionText_line1": "@",
          "promotionText_line2": "RBH"
        },
        {
          "id": "MA2005000046",
          "cityId": "MA05110041",
          "countryId": "MA05110001",
          "imageUrl": "https://train.travflex.com/SightSeeing/images/350/CL002/bangkok_temples-general1.jpg",
          "name": "Bangkok Temples",
          "cityName": "Krabi",
          "styleName": "Museum",
          "startPrice": 800.5,
          "promotionText_line1": "@",
          "promotionText_line2": "RBH",
          "capsulePromotion": [{
						"name": "Free Food Delivery",
						"code": "FREE01"
					}]
        },
        {
          "id": "MA2005000046",
          "cityId": "MA05110041",
          "countryId": "MA05110001",
          "imageUrl": "https://train.travflex.com/SightSeeing/images/350/CL002/bangkok_temples-general1.jpg",
          "name": "Bangkok Temples",
          "locationName": "Mueang",
          "styleName": "Museum",
          "startPrice": 800.5,
          "promotionText_line1": "@",
          "promotionText_line2": "RBH"
        },
        {
          "id": "MA2005000046",
          "cityId": "MA05110041",
          "countryId": "MA05110001",
          "imageUrl": "https://train.travflex.com/SightSeeing/images/350/CL002/sea_life_ocean_world_bangkok-general1.jpg",
          "name": "Sea Life Ocean World Bangkok",
          "startPrice": 800.5,
          "promotionText_line1": "@",
          "promotionText_line2": "RBH"
        }
      ]
    },
    "status": {
      "code": "1000",
      "header": "success",
      "description": ""
    }
  }
}
''';
