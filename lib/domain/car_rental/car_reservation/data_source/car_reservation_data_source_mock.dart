import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_argument_model.dart';

import '../models/car_reservation_domain_model.dart';
import 'car_reservation_remote_data_source.dart';

class CarReservationMockDataSourceImpl
    implements CarReservationRemoteDataSource {
  CarReservationMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  static String getMockData2() {
    return _responseMock2;
  }

  static String get1899MockData() {
    return _response1899Mock;
  }

  @override
  Future<CarReservationScreenDomainData> getCarReservationData(
      CarReservationDomainArgumentModel argument) async {
    await Future.delayed(const Duration(milliseconds: 10));
    return CarReservationScreenDomainData.fromJson(_responseMock2);
  }
}

var _responseMock = """ 
{
  "getCarInitiateBookingResponse": {
    "data": {
      "bookingUrn": "C220322-AA-0001",
      "image": "https://trbhmanage.travflex.com/ImageData/Car/vios-2-1.jpg",
      "car": {
        "id": 2,
        "name": "Vios",
        "brand": "Toyota",
        "crafttype": "Medium cars",
        "seatNbr": 4,
        "doorNbr": 4,
        "bagLargeNbr": 1,
        "bagSmallNbr": 0,
        "gear": "A",
        "year": 0
      },
      "supplier": {
        "id": "MA2111000062",
        "name": "Krungthai Car Rent & Lease PLC",
        "logo": {
          "url": "https://trbhmanage.travflex.com/ImageData/Supplier/krungthai_car_rent___lease_plc-logo.gif",
          "title": "Krungthai Car Rent & Lease PLC",
          "alt": "Krungthai Car Rent & Lease PLC"
        }
      },
      "fromDate": "2021-11-10",
      "pickupCounter": {
        "id": 0,
        "locationName": "Don Muang",
        "opentime": "05:00"
      },
      "ratePerDays": {
        "ratePerDay": 899,
        "returnCounter": {
          "locationName": "Don Muang",
          "opentime": "05:00"
        },
        "total": 3596,
         "totalDaysExtraCharge": 3596,
        "returnExtraCharge": 0,
        "totalDays": 899,
        "rateKey": "eNqLVjI0VNKJNjKN1THUMTLVMTPQMdAxMosFAEAQBRw=",
        "refCode": "CL213"
      },
      "toDate": "2022-12-31",
      "rentalDays": 2,
      "cancellationPolicy": [
        {
          "cancelDays": 30,
          "message": "Free of Charge for Cancellations 30 days days before the rental start date, Otherwise a full charge of the entire booking value will be applied, In case of No Show is non-refundable"
        },
        {
          "cancelDays": 45,
          "message": "Free of Charge for Cancellations 45 days days before the rental start date, Otherwise 50% of the entire booking value will be applied, In case of No Show is non-refundable"
        }
      ],
      "extraCharges": [
      {
        "id": 13,
        "car_rate_id": 0,
        "fromDate": "2021-11-10",
        "toDate": "2022-12-31",
        "extraChargeGroup": {
          "id": 7,
          "name": "Andriod TV",
          "description":"Optional TV setup in car"
        },
        "price": 1000,
        "isCompulsory": true,
        "chargeType": 1,
        "description": ""
      }
    ]
    },
    	"status": {
			"code": "1000",
			"header": "Success"
		}
  }
}  
 """;

var _responseMock2 = '''
{
  "getCarInitiateBookingResponse": {
    "data": {
      "bookingUrn": "C220526-AA-0157",
      "id": 78,
      "allowLateReturn": 2,
      "rentalDays": 3,
      "image": "https://trbhmanage.travflex.com/ImageData/Car/yaris-4-1.jpg",
      "fromDate": "2022-01-10",
      "toDate": "2022-12-31",
      "currency": "THB",
      "isIncludeDriver": false,
      "isPromotion": false,
      "generalInfo": "<p># Rental Documents<br />To pick up the car, the renter must provide an identity card. Driver's License and credit card with the driver's name or cash for a deposit</p>",
      "conditionInfo": "<p># Rental documents to be prepared<br />To pick up the car, the renter must be prepared. ID card / Driving License and a Credit Card indicating the driver's name</p>",
      "description": "<p># In Case of Damage<br />The vehicle's deductible in case of loss of the car is ฿100,000.00 including tax. If the rental car company has included the deductible with basic insurance (CDW), the customer does not have to purchase the deductible. of the damages, the first part added</p>",
      "includeDriver": false,
      "promotion": false,
      "promotionList": [
        {
          "productType": "CARRENTAL",
          "promotionCode": "FREEDELIVERY",
          "title": "Free Food Delivery",
          "description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
          "web": "https://www.tourismthailand.org/home"
        }
      ],
      "extraCharges": [
        {
          "id": 116,
          "car_rate_id": 0,
          "fromDate": "2022-01-10",
          "toDate": "2022-12-31",
          "price": 1000,
          "isCompulsory": false,
          "chargeType": 0,
          "description": "",
          "extraChargeGroup": {
            "id": 27,
            "name": "Insurance",
            "description": ""
          }
        }
      ],
      "cancellationPolicy": [
        {
          "cancelDays": 999,
          "message": "The policy of this product is non-refundable, After the reservation has been made and if any require of cancel booking, there will be no refund."
        }
      ],
      "returnCounter": {
        "id": "40",
        "name": "Don Muang Airport Counter",
        "address": "",
        "countryId": "MA05110001",
        "countryName": "Thailand",
        "cityId": "MA05110041",
        "cityName": "Bangkok",
        "locationId": "MA06030005",
        "locationName": "Don Muang",
        "latitude": "0.00000000",
        "longitude": "0.00000000",
        "opentime": "08:30",
        "closetime": "20:00",
        "description": ""
      },
      "ratePerDays": {
        "ratePerDay": 3000,
        "rateKey": "eNqLVjK3UNKJNrQ0iNUx1DEy0DE30DHQMTI2iAUAS34FhQ==",
        "refCode": "CL213",
        "minDay": "1",
        "minAge": "20",
        "maxAge": "70",
        "totalDays": 9000,
        "isMileageLimit": false,
        "mileageDescription": "",
        "conditionInfo": "<p>Age Condition<br />The minimum age requirement for this vehicle is 21. The rental car company has age-related charges and restrictions.</p>",
        "returnCounter": null,
        "returnExtraCharge": 100,
        "totalDaysExtraCharge": 9000,
        "extraChargesCompulsory": 0,
        "total": 9000
      },
      "pickupCounter": {
        "id": 40,
        "name": "Don Muang Airport Counter",
        "address": "",
        "countryId": "MA05110001",
        "countryName": "Thailand",
        "cityId": "MA05110041",
        "cityName": "Bangkok",
        "locationId": "MA06030005",
        "locationName": "Don Muang",
        "latitude": "0.00000000",
        "longitude": "0.00000000",
        "opentime": "08:30",
        "closetime": "20:00",
        "description": ""
      },
      "supplier": {
        "id": "MA2201000015",
        "name": "Doctor Car Rental",
        "logo": {
          "url": "https://trbhmanage.travflex.com/ImageData/Supplier/doctor_car_rental-logo.jpg",
          "title": "Doctor Car Rental",
          "alt": "Doctor Car Rental"
        }
      },
      "car": {
        "id": 4,
        "name": "Yaris",
        "nameBy": "",
        "brand": "Toyota",
        "crafttype": "Small cars",
        "seatNbr": 4,
        "doorNbr": 4,
        "bagLargeNbr": 1,
        "bagSmallNbr": 1,
        "engine": "1200",
        "gear": "A",
        "year": 2021,
        "color": "White",
        "fuelType": "Gasoline",
        "licensePlateNbr": "",
        "description": "",
        "generalInfo": "",
        "conditionInfo": "",
        "facilities": [
          "Apple CarPlay",
          "Bluetooth",
          "Navigation system",
          "Remote start"
        ]
      }
    },
    "status": {
      "code": "1000",
      "header": "Success",
      "description": null,
      "errors": null
    }
  }
}
''';

var _response1899Mock = """ 
{
  "getCarInitiateBookingResponse": {
    "data": null,
    	"status": {
			"code": "1899",
			"header": "Data Not Found"
		}
  }
}  
 """;
