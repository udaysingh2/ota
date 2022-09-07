import 'package:ota/domain/car_rental/car_detail/data_source/car_detail_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favourite_model_domain.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_argument_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/check_favourite_domain_model.dart';

import '../../../favourites/models/unfavourite_model_domain.dart';

class CarDetailMockDataSourceImpl implements CarDetailRemoteDataSource {
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<CarDetailDomainModel> getCarDetail(
      CarDetailDomainArgumentModel argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return CarDetailDomainModel.fromJson(_responseMock);
  }

  @override
  Future<AddfavouriteModelDomain> addFavouriteCar(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel,
      required String serviceName}) async {
    await Future.delayed(const Duration(seconds: 1));
    return AddfavouriteModelDomain.fromJson(addFavouriteResponse);
  }

  @override
  Future<CheckFavouriteDomainModel> checkFavouriteCar(
      {required String supplierId,
      required String carId,
      required String serviceName}) async {
    await Future.delayed(const Duration(seconds: 1));
    return CheckFavouriteDomainModel.fromJson(checkFavouriteResponse);
  }

  @override
  Future<UnFavouriteModelDomain> unfavouritesCar(
      {required String id,
      required String supplierId,
      required String serviceName}) async {
    await Future.delayed(const Duration(seconds: 1));
    return UnFavouriteModelDomain.fromJson(addFavouriteResponse);
  }
}

var _responseMock = """
  {
    "data": {
      "carInfo": {
        "brand": "Toyota",
        "crafttype": "Medium cars",
        "images": {
          "thumb": "https://trbhmanage.travflex.com/imagedata/Car/800/vios-2-1.jpg",
          "full": "https://trbhmanage.travflex.com/ImageData/Car/vios-2-1.jpg"
        },
        "name": "Vios"
      },
      "carDetail": {
        "id": "11",
        "allowLateReturn": 1,
        "supplier": {
          "id": "MA2111000062",
          "name": "Krungthai Car Rent & Lease PLC",
          "logo": {
            "url": "https://trbhmanage.travflex.com/ImageData/Supplier/krungthai_car_rent___lease_plc-logo.gif"
          }
        },
        "car": {
          "id": "2",
          "name": "Vios",
          "brand": "Toyota",
          "crafttype": "Medium cars",
          "seatNbr": "4",
          "doorNbr": "4",
          "bagLargeNbr": "1",
          "bagSmallNbr": "2",
          "engine": "1500",
          "gear": "A",
          "facilities": [
            "Apple CarPlay",
            "Backup camera",
            "Bluetooth",
            "Leather seats",
            "Navigation system",
            "Third-row seating"
          ],
          "images": {
            "thumb": "https://trbhmanage.travflex.com/imagedata/Car/800/vios-2-1.jpg",
            "full": "https://trbhmanage.travflex.com/ImageData/Car/vios-2-1.jpg"
          },
          "year": "2021",
          "color": "White",
          "fuelType": "Gasoline",
          "description": "",
          "generalInfo": "",
          "conditionInfo": ""
        },
        "toDate": "2022-12-31",
        "fromDate": "2021-11-10",
        "pickupCounter": {
          "name": "Don Muang Airport (DMK)",
          "id": "6",
          "address": "<span>222 Vibhavadi Rangsit Rd, Sanambin, Don Mueang, Bangkok 10210<br>Tel:&#160;</span><a>02 535 1192</a>",
          "cityName": "Bangkok",
          "locationId": "MA06030005",
          "opentime": "05:00",
          "locationName": "Don Muang",
          "closetime": "18:00",
          "description": "Don Muang Airport, (DMK)&#160; 1st Floor, Exit No.3"
        },
        "currency": "THB",
        "isIncludeDriver": "false",
        "isPromotion": "false",
        "generalInfo": "<div>Car rental document</div><div>1. ID card</div><div>2. Driver's license</div><div>3. Credit card for minimum guarantee 10,000 baht depending on vehicle model</div><div>4. Evidence of work such as salary slip</div>",
        "description": "",
        "conditionInfo": "Driver must have a driver license",
        "rateKey": "eNqLVjI0VNKJNjKN1THUMTLVMTPQMdAxMosFAEAQBRw=",
        "refCode": "CL213",
        "totalPrice": 899,
        "pricePerDay": 899,
        "termsAndCondition": "<p>This price is not driver</p>",
        "returnCounter": {
          "id": "6",
          "name": "Don Muang Airport (DMK)",
          "address": "<span>222 Vibhavadi Rangsit Rd, Sanambin, Don Mueang, Bangkok 10210<br>Tel:&#160;</span><a>02 535 1192</a>",
          "locationId": "MA06030005",
          "locationName": "Don Muang",
          "latitude": "13.91370000",
          "longitude": "100.59920000",
          "opentime": "05:00",
          "closetime": "18:00",
          "description": "Don Muang Airport, (DMK)&#160; 1st Floor, Exit No.3"
        },
        "promotions": []
      }
    },
    "status": {
      "code": "1000",
      "header": "Success"
    }
  }
""";

var addFavouriteResponse = """{ 
  "addFavorite":{
    "status": 
  { 
  "code": "1899", 
  "header": "Limit exceeded",
  "description": "You have exceeded the maximum numbers of favorites added" 
  } 
  }
}
""";

var checkFavouriteResponse = """{
    "data": {
        "isFavorite": {
            "data": {
                "isFavorite": true
            },
            "status": {
                "code": "1000",
                "header": "Success",
                "description": null
            }
        }
    }
}""";
