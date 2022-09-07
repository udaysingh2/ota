import 'package:ota/domain/playlist/dynamic_playlist/data_sources/dynamic_playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_data_argument_domain.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_model_domain.dart';

class DynamicPlayListMockDataSourceImpl
    implements DynamicPlayListRemoteDataSource {
  DynamicPlayListMockDataSourceImpl();

  @override
  Future<DynamicPlaylistModel> getDynamicPlayListData(
      DynamicPlayListDataArgumentModelDomain argument) async {
    await Future.delayed(const Duration(milliseconds: 10));
    return DynamicPlaylistModel.fromJson(_responseMock);
  }
}

var _responseMock = """ 
{
    "getDynamicPlaylists": {
      "data": [
        {
          "name": null,
          "source": "dynamic",
          "serviceName": "hotels",
          "list": [
            {
              "address": {
                "locationId": "MA05110074",
                "address1": "18  Chakapong  Road  Banglumphu"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/sawasdee_khaosan_inn-general1jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA0511000412",
              "hotelName": "Sawasdee Khaosan Inn "
            },
            {
              "address": {
                "locationId": "MA05110011",
                "address1": "128/1  Sukhumvit  Soi  4  Klongtoey"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/woraburi_sukhumvit_hotel_and_resort-general1jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA0511000433",
              "hotelName": "Woraburi Sukhumvit Hotel and Resort "
            },
            {
              "address": {
                "locationId": "MA06100226",
                "address1": "737/12 Mung Talay Road"
              },
              "rating": 5,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/veranda_resort_and_villas_hua_hin_cha_am_mgallery-general1.jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA0604000289",
              "hotelName": "Veranda Resort and Villas Hua Hin Cha Am MGallery"
            },
            {
              "address": {
                "locationId": "MA06040037",
                "address1": "1129 Kraisorasit Road Vieng District Amphur Muang"
              },
              "rating": 5,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/riverie_by_katathani_(the)-general1.jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA0604000353",
              "hotelName": "Riverie by Katathani (The)"
            },
            {
              "address": {
                "locationId": "MA05110068",
                "address1": "514  Ramkhamhaeng  39   Prachautiit    Road"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/jazzotel_bangkok-general1.jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA0711050519",
              "hotelName": "Jazzotel Bangkok "
            },
            {
              "address": {
                "locationId": "MA05110074",
                "address1": "30  Rambuttri  Road  Phanakorn"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/sawasdee_krungthep_inn-general1.jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA0711050535",
              "hotelName": "Sawasdee Krungthep Inn "
            },
            {
              "address": {
                "locationId": "MA06100169",
                "address1": "108 Chang Klan Road Tambol Chang klan,"
              },
              "rating": 5,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/le_meridien_chiang_mai-general1.jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA0807071851",
              "hotelName": "Le Meridien Chiang Mai"
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "7/149  Moo  1  Soi  Suphaphong  1  Yak  6   Srinakarin  40  Road   Nongbon  Praves"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/heritage_srinakarin-general1jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA0909050543",
              "hotelName": "Heritage Srinakarin "
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "27  Soi  Charoen  Nakhon  17,   Charoen  Nakhon  Road   Banglamphulang,  Klongsarn"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/ibis_bangkok_riverside-general1jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA1008080157",
              "hotelName": "Ibis Bangkok Riverside "
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "2  North  Sathorn  Road  Bangrak"
              },
              "rating": 5,
              "review": null,
              "promotion": [],
              "image": "",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA1109000057",
              "hotelName": "So Bangkok "
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "9 Rajdamneon Road, Soi 1"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/vieng_mantra-general1.jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA1204040080",
              "hotelName": "Vieng Mantra"
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "15  Soi  Nai-Lert  Wireless  Road    Lumpini  Prathumwan"
              },
              "rating": 4,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/arcadia_suites_bangkok-general1jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA1301010134",
              "hotelName": "Arcadia Suites Bangkok "
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "351,  353,  355  Charoen  Krung  43  Road"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/poste_43_residence-general1jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA1306060916",
              "hotelName": "Poste 43 Residence "
            },
            {
              "address": {
                "locationId": "MA08020027",
                "address1": "888,  Moo 7,  Tumbol Padaed"
              },
              "rating": 4,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/athitan_boutique__chiang_mai-general1.jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA13090131",
              "hotelName": "Athitan Boutique  Chiang Mai"
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "90/41-44,90/79-81  Ratchaprarop  Rd"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/cozy_villa_bangkok-general1jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA13100679",
              "hotelName": "Cozy Villa Bangkok "
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "22  20  Mituna  Soi  13  Huai-Kwang"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/mestyle_place-general1jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA13110022",
              "hotelName": "MeStyle Place "
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "31/1,33  Soi  Thaniya2   Surawongse  Road,  Bang  Rak"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/suriwongse-general1jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA13110066",
              "hotelName": "Suriwongse "
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "27/12  Soi  Nai  Lert   Wireless  Road,  Pathumwan"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/nantra_ploenchit-general1.jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA14010253",
              "hotelName": "Nantra Ploenchit "
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "707  Soi  Lat  Phrao  130   Lat  Phrao  Road   Bang  Kapi"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/livotel_bangkok-general1.jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA14030556",
              "hotelName": "Livotel Bangkok "
            },
            {
              "address": {
                "locationId": "NONE",
                "address1": "66/2-5  Ramkamhaeng  Road   Sukapiban  3"
              },
              "rating": 3,
              "review": null,
              "promotion": [],
              "image": "https://trbhmanage.travflex.com/ImageData/Hotel/13_coins_airportl_minburi-general1jpg",
              "adminPromotion": {
                "adminPromotionLine1": null,
                "adminPromotionLine2": null,
                "promotionText1": null,
                "promotionText2": null
              },
              "hotelId": "MA14063503",
              "hotelName": "13 Coins Airportl Minburi "
            }
          ]
        }
      ],
      "status": {
        "code": "1000",
        "header": "Success",
        "description": null,
        "errors": null
      }
    }
}
""";
