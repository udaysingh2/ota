import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_domain_model.dart';

void main() {
  var stringJson = """
{
  "data": {
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
          "returnExtraCharge": 0,
          "totalDaysExtraCharge": 3596,
          "total": 3596,
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
        "extraCharges": null
      },
      "status": {
        "code": "1000",
        "header": "Success"
      }
    }
}
""";

  var extracharge = """
{
  
        "id": 1000,
        "carRateId": 1,
        "fromDate": null,
        "toDate": null,
        "price": 1,
        "isCompulsory": true,
        "chargeType": 1000,
        "description": "description",
        "extraChargeGroup": {
           "id": 1000,
        "name": "name",
        "description": "null"
        }
}
""";

  var returnCounter = """
{ 
        "id": "1000",
        "carRateId": "1",
        "address": "address",
        "countryId": "countryId",
        "countryName": "countryName",
        "cityId": "cityId",
        "cityName": "cityName",
        "locationId": "locationId",
        "locationName": "locationName",
        "longitude": "longitude",
        "opentime": "opentime",
        "closetime": "locationId",
        "description": "locationId"
}
""";

  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    CarReservationScreenDomain carReservationScreenDomainData =
        CarReservationScreenDomain.fromJson(stringJson);
    expect(carReservationScreenDomainData.data != null, true);
    carReservationScreenDomainData.toMap();
    carReservationScreenDomainData.toJson();
  });

  test("extracharge model", () {
    ///Convert into Model
    ExtraCharge extraCharge = ExtraCharge.fromJson(extracharge);
    expect(extraCharge.chargeType, 1000);
    extraCharge.toMap();
    extraCharge.toJson();
    extraCharge.extraChargeGroup?.toMap();
    extraCharge.extraChargeGroup?.toJson();
  });

  test("PromotionList Model test ", () {
    Map<String, dynamic> json = {
      "productType": "2",
      "promotionCode": "2",
      "title": "2",
      "description": "2",
      "web": "2",
      "iconImage": "2",
      "bannerDescDisplay": true,
      "line1": "2",
      "line2": "2",
      "productId": "2",
      "promotionType": "2"
    };
    PromotionList promotionModel = PromotionList.fromMap(json);
    expect(promotionModel.productType, '2');
    promotionModel.toMap();
    promotionModel.toJson();
  });

  test("extracharge model", () {
    ///Convert into Model
    ReturnCounter returnCounterobj = ReturnCounter.fromJson(returnCounter);
    expect(returnCounterobj.id, '1000');
    returnCounterobj.toJson();
    returnCounterobj.toMap();
  });
}
