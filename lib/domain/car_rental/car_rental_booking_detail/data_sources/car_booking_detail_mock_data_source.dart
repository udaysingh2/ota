import 'package:ota/domain/car_rental/car_rental_booking_detail/data_sources/car_booking_detail_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/model/car_booking_detail_domain_model.dart';

class CarBookingDetailMockDataSourceImpl
    implements CarBookingDetailRemoteDataSource {
  CarBookingDetailMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<CarBookingDetailDomainModel> getCarBookingDetailData({
    required String bookingId,
    required String bookingUrn,
    required String bookingType,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return CarBookingDetailDomainModel.fromString(_responseMock);
  }
}

var _responseMock = '''
{
    "status": {
        "code": "1000",
        "header": "Success"
    },
    "data": {
        "displayStatus": "Confirmed",
        "bookingStatus": "CONFIRMED",
        "activityStatus": "SUCCESS",
        "bookingUrn": "C220427-AA-0108",
        "bookingId": "B2CMMA220421836",
        "serviceNumber": "527",
        "bookingType": "CARRENTAL",
        "promotion": {
          "promotionId": 1,
          "promotionName": "RBH Special",
          "shortDescription": "ส่วนลดมูลค่า 50 บาท",
          "discount": 40,
          "maximumDiscount": 100.6,
          "discountType": "PERCENT",
          "discountFor": "ORDER",
          "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
          "promotionType": "PUBLIC",
          "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
          "voucherCode": "RBH50",
          "promotionCode": "RBH50",
          "startDate": "2022-06-24T08:44:39.000+00:00",
          "endDate": "2022-09-24T08:44:39.000+00:00",
          "applicationKey": "CARRENTAL"
          },
          "promoPriceDetails": {
          "effectiveDiscount": 80,
          "orderPrice": 200,
          "addonPrice": 200,
          "billingAmount": 320,
          "totalAmount": 400
          }, 
        "carBookingDetails": {
            "car": {
                "carId": "1",
                "seatNbr": 4,
                "doorNbr": 4,
                "bagLargeNbr": 1,
                "bagSmallNbr": 2,
                "engine": "1200",
                "gear": "A",
                "year": 2021,
                "name": "Almera",
                "brand": "Nissan",
                "images": {
                    "thumb": "https://trbhmanage.travflex.com/imagedata/Car/800/almera-1-1.jpg",
                    "full": "https://trbhmanage.travflex.com/ImageData/Car/almera-1-1.jpg"
                },
                "craftType": "Small cars",
                "fuelType": "Gasoline",
                "generalInfo": "",
                "conditionInfo": "",
                "facilities": [
                    "Apple CarPlay",
                    "Bluetooth",
                    "Navigation system",
                    "Remote start"
                ]
            },
            "pickupDateTime": "2022-04-28T10:00:00",
            "returnDateTime": "2022-05-01T10:00:00",
            "rentalDays": 3,
            "allowLateReturn": 0,
            "cancellationPolicy": [
                {
                    "cancelDays": 3,
                    "message": "Free of Charge for Cancellations 3 days days before the rental start date, Otherwise a full charge of the entire booking value will be applied, In case of No Show is non-refundable"
                },
                {
                    "cancelDays": 7,
                    "message": "Free of Charge for Cancellations 7 days days before the rental start date, Otherwise 50% of the entire booking value will be applied, In case of No Show is non-refundable"
                },
                {
                    "cancelDays": 30,
                    "message": "Free of Charge for Cancellations 30 days days before the rental start date, Otherwise 5% of the entire booking value will be applied, In case of No Show is non-refundable"
                }
            ],
            "pickupCounter": {
                "counterId": 29,
                "name": "Don Mueang International Airport",
                "locationId": "MA06030005",
                "opentime": "05:00",
                "closetime": "22:00",
                "address": "<p>222 Vibhavadi Rangsit Rd, Sanambin, Don Mueang, Bangkok 10210</p>",
                "locationName": "Don Muang",
                "description": "<p>Exit 4 Floor 1</p>",
                "latitude": "13.9198596",
                "longitude": "100.5578377"
            },
            "returnCounter": {
                "counterId": 29,
                "name": "Don Mueang International Airport",
                "locationId": "MA06030005",
                "opentime": "05:00",
                "closetime": "22:00",
                "address": "<p>222 Vibhavadi Rangsit Rd, Sanambin, Don Mueang, Bangkok 10210</p>",
                "locationName": "Don Muang",
                "description": "<p>Exit 4 Floor 1</p>",
                "latitude": "13.9198596",
                "longitude": "100.5578377"
            },
            "payment": [
            {
              "amount": "104.00",
              "cardNickName": "test",
              "cardNo": "***5454",
              "cardType": "UNION_PAY",
              "type": "CARD",
              "name": "Credit Card"
            },
            {
              "amount": "16304.00",
              "cardNickName": null,
              "cardNo": null,
              "cardType": null,
              "type": "VA",
              "name": "Wallet"
            }
          ],
            "supplier": {
                "id": "MA2111000064",
                "name": "Chic Car Rent",
                "logo": {
                    "url": "https://trbhmanage.travflex.com/ImageData/Supplier/chic_car_rent-logo.jpg"
                }
            },
            "driverName": "Gokul c",
            "flightNumber": "",
            "generalInfo": "<p># Rental Documents<br />To pick up the car, the renter must provide an identity card. Driver's License and credit card with the driver's name or cash for a deposit</p>",
            "conditionInfo": "<p># Age Condition<br />The minimum age requirement for this vehicle is 21. The rental car company has age-related charges and restrictions.</p>",
            "paymentStatus": "CONFIRMED",
            "extraCharges": null,
            "netPrice": 1797.0,
            "totalPrice": 1797.0,
            "totalPayablePrice": 1797.0,
            "extrasOnlinePrice": 0.0,
            "extrasCounterPrice": 0.0,
            "totalDiscount": 0.0,
            "confirmationDate": "2022-04-27",
            "cancellationDate": null,
            "cancellationCharge": 0.0,
            "cancellationReason": null,
            "processingCharge": 0.0,
            "totalRefundAmount": 0.0
        }
    }
}
''';
