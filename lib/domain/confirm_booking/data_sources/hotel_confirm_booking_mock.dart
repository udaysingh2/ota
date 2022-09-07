import 'package:ota/domain/confirm_booking/data_sources/hotel_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';

class HotelConfirmBookingMockDataSourceImpl
    implements HotelConfirmBookingRemoteDataSource {
  HotelConfirmBookingMockDataSourceImpl();
  @override
  Future<BookingConfirmationData> getHotelConfirmBooking(
      HotelConfirmBookingArgumentModelDomain argument) async {
    await Future.delayed(const Duration(seconds: 1));
    return BookingConfirmationData.fromJson(_responseMock);
  }

  static String getMockData() {
    return _responseMock;
  }
}

var _responseMock = """{
    "data": {
        "bookingUrn": "H20211013AA0066",
        "totalAmount": 171700.0,
        "totalFees": 0.0,
        "totalTaxes": 0.0,
        "totalDiscount": 0.0,
        "status": "INITIATED",
        "hotelBookingDetails": {
            "hotelId": "MA0511000344",
            "cityId": "MA05110041",
            "countryId": "MA05110001",
            "checkInDate": "2021-11-01",
            "checkOutDate": "2021-12-02",
            "roomCode": "MA07080326",
            "roomCategory": "1",
            "requestedRoomDetails": [
                {
                    "roomType": null,
                    "adults": 2,
                    "children": 2,
                    "childAge1": 1,
                    "childAge2": 1
                }
            ],
            "roomDetails": {
                "mealType": "Deluxe balcony room only",
                "roomImage": null,
                "roomCategories": [
                    {
                        "roomName": "DELUXE BALCONY ROOM",
                        "roomType": "Double",
                        "noOfRooms": 1
                    }
                ],
                "facilities": [
                    {
                        "key": "WIFI",
                        "value": "free.wifi"
                    },
                    {
                        "key": "BREAKFAST",
                        "value": "breakFast.included"
                    },
                    {
                        "key": "PAYMENT",
                        "value": "instant.payment"
                    }
                ],
                "cancellationPolicy": [
                    {
                        "days": null,
                        "cancellationDaysDescription": null,
                        "cancellationChargeDescription": null,
                        "cancellationStatus": "policy.cancellation.free"
                    }
                ],
                "roomFacilities": [
                    "Non-smoking Room",
                    "Bath Robe",
                    "Air-condition",
                    "Hairdryer",
                    "Radio",
                    "Fridge",
                    "TV",
                    "Make up mirror",
                    "Telephone",
                    "CD Player",
                    "24 Hrs. Room Service",
                    "Babycot",
                    "Electric Kettle",
                    "Alarm Clock",
                    "Bathtub",
                    "Minibar",
                    "Workdesk",
                    "IDD Phone",
                    "Wi-Fi",
                    "Shower",
                    "Tea / Coffee",
                    "Toiletries",
                    "Slippers"
                ],
                "totalPrice": 170500.0,
                "perNightPrice": 5500.0,
                "numberOfNights": "31",
                "rateKey": "211101|211202|MA05110001|LOCAL|MA0511000344|MA07080326|NONE|CL213|RO|Double|2|2|1|1|False|1|1|Y|170500.00@FC076B0A",
                "supplier": "CL213",
                "hotelName": "Shangri La Bangkok",
                "hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
                "discountPercent": 91.0,
                "nightPriceBeforeDiscount": 12000.0
            },
            "addOnServices": [
                {
                    "price": "2100",
                    "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
                    "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>",
                    "hotelServiceId": "279",
                    "hotelServiceName": "Golf Course",
                    "serviceDate": "2021-12-02",
                    "quantity": 1,
                    "isFlightRequired": false
                }
            ],
            "additionalNeedsTxt": "Technocrat, Lo Hang Guo, Bento Champion Climax Diet Foam Hot Dog Stock Rama Institute",
            "fees": 0.0,
            "taxes": 0.0,
            "discount": 0.0,
            "freeFoodDelivery": true
        },
        "currency": "THB",
        "locale": "en_TH",
        "guestInfo": [
            {
                "firstName": "roy",
                "lastName": "alpha"
            },
            {
                "firstName": "atore",
                "lastName": "ds",
                "title": "Mrs"
            }
        ],
        "customerInfo": {
            "firstName": "roy",
            "lastName": "alpha",
            "customerId": "test",
            "membershipId": "M1234567890"
        },
        "bookingForSomeoneElse": false
    },
    "status": {
        "code": "1000",
        "header": "Success",
        "description": "Success"
    }
}
""";
