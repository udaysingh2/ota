import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';

import 'car_supplier_remote_data_source.dart';

class CarSupplierMockDataSourceImpl implements CarSupplierRemoteDataSource {
  CarSupplierMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<CarSupplierModelDomainData> getCarSupplierData(
      CarSupplierArgumentModel argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return CarSupplierModelDomainData.fromJson(_responseMock);
  }
}

var _responseMock = '''
{
    "getCarRentalSupplier": {
      "status": {
        "code": "1000",
        "header": "Success"
      },
      "data": {
        "supplierData": [
          {
            "id": "45",
            "allowLateReturn": 0,
            "supplier": {
              "id": "MA2111000064",
              "name": "Chic Car Rent",
              "logo": {
                "url": "https://trbhmanage.travflex.com/ImageData/Supplier/chic_car_rent-logo.jpg"
              }
            },
            "car": {
              "id": "1",
              "name": "Almera",
              "brand": "Nissan",
              "crafttype": "Small cars",
              "seatNbr": "4",
              "doorNbr": "4",
              "bagLargeNbr": "1",
              "bagSmallNbr": "2",
              "engine": "1200",
              "gear": "A",
              "images": {
                "thumb": "https://trbhmanage.travflex.com/imagedata/Car/800/almera-1-1.jpg",
                "full": "https://trbhmanage.travflex.com/ImageData/Car/almera-1-1.jpg"
              }
            },
            "fromDate": "2021-12-13",
            "toDate": "2022-12-31",
            "currency": "THB",
            "totalPrice": "2396",
            "pricePerDay": "599.0",
            "rateKey": "eNqLVjIxVdKJNjQwjdUx0jEy1DE11THUsbSIBQBFpAVd",
            "refCode": "CL213",
            "pickupCounterId": "29",
            "returnCounterId": "29"
          },
          {
            "id": "16",
            "allowLateReturn": 1,
            "supplier": {
              "id": "MA2111000066",
              "name": "Pan Car Rental Supplier",
              "logo": {
                "url": "https://trbhmanage.travflex.com/ImageData/Supplier/pan_car_rental_supplier-logo.jpg"
              }
            },
            "car": {
              "id": "1",
              "name": "Almera",
              "brand": "Nissan",
              "crafttype": "Small cars",
              "seatNbr": "4",
              "doorNbr": "4",
              "bagLargeNbr": "1",
              "bagSmallNbr": "2",
              "engine": "1200",
              "gear": "A",
              "images": {
                "thumb": "https://trbhmanage.travflex.com/imagedata/Car/800/almera-1-1.jpg",
                "full": "https://trbhmanage.travflex.com/ImageData/Car/almera-1-1.jpg"
              }
            },
            "fromDate": "2021-11-10",
            "toDate": "2022-12-31",
            "currency": "THB",
            "totalPrice": "2700",
            "pricePerDay": "900.0",
            "rateKey": "eNqLVjI0U9KJNjaN1THUMTLQMTPQMdAxNokFAEBXBRw=",
            "refCode": "CL213",
            "pickupCounterId": "9",
            "returnCounterId": "9"
          }
        ],
        "promotionList": [
          {
            "productType": "CARRENTAL",
            "promotionCode": "FREEDELIVERY",
            "title": "Free Food Delivery",
            "description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
            "web": "https://www.tourismthailand.org/home"
          }
        ]
      }
    }
}
''';
