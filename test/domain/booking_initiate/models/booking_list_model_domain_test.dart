import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';

void main() {
  var stringJson = """
{
  "getBookingSummaryV2": {
    "status": {
      "code": "1000",
      "header": "Success"
    },
    "data": {
      "totalPageNumber": 10,
      "bookingDetails": [
        {
          "serviceType": "serviceType",
          "sortDateTime": "sortDateTime",
          "sortPriority": 1,
          "hotel": {
            "name": "name",
            "totalPrice": 100,
            "checkInDate": null,
            "checkOutDate": null,
            "bookingUrn": "bookingUrn",
            "status": "status",
            "bookingId": "bookingId",
            "paymentStatus": "paymentStatus",
            "activityStatus": "activityStatus"
          },
          "tour": {
            "subServiceType": "subServiceType",
            "name": "name",
            "totalPrice": 100,
            "startTimeAMPM": "startTimeAmpm",
            "bookingUrn": "bookingUrn",
            "status": "status",
            "bookingDate": null,
            "bookingId": "bookingId",
            "paymentStatus": "paymentStatus",
            "activityStatus": "activityStatus"
          },
          "car": {
            "name": "name",
            "totalPrice": 100,
            "supplierName": "supplierName",
            "bookingUrn": "bookingUrn",
            "status": "status",
            "bookingSummaryStatus": "bookingSummaryStatus",
            "pickupDateTime": null,
            "returnDateTime": null,
            "bookingId": "bookingId",
            "returnExtraCharge": 100.0
          },
          "flight": {
            "reservationId": "reservationId",
            "bookingUrn": "bookingUrn",
            "bookingStatus": "bookingStatus",
            "activityStatus": "activityStatus",
            "totalAmount": 100,
            "journeyType": 1,
            "departureDetails": {
              "arrCode": "arrCode",
              "depCode": "depCode",
              "depDate": null,
              "arrDate": null,
              "numOfStops": 10,
              "airwaysCode": "airwaysCode",
              "routeInfo": [{
                "airwaysName": "airwaysName",
                "flightLogo": "flightLogo",
                "depDate": "depDate",
                "arrDate": "arrDate"
              }]
            },
            "returnDetails": {
              "arrCode": "arrCode",
              "depCode": "depCode",
              "depDate": null,
              "arrDate":null,
              "numOfStops": 10,
              "airwaysCode": "airwaysCode",
              "routeInfo": [{
                "airwaysName": "airwaysName",
                "flightLogo": "flightLogo",
                "depDate": "depDate",
                "arrDate": "arrDate"
              }]
            }
          }
        }
      ]
    }
  }
}
""";

  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    BookingListModelDomain bookingListModelDomain =
        BookingListModelDomain.fromJson(stringJson);
    expect(bookingListModelDomain.getBookingSummaryV2 != null, true);
    bookingListModelDomain.toJson();
    bookingListModelDomain.toMap();
    bookingListModelDomain.getBookingSummaryV2?.toJson();
    bookingListModelDomain.getBookingSummaryV2?.toMap();
    expect(bookingListModelDomain.getBookingSummaryV2?.data != null, true);
    bookingListModelDomain.getBookingSummaryV2?.data?.toJson();
    bookingListModelDomain.getBookingSummaryV2?.data?.toMap();
    expect(
        bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails !=
            null,
        true);
    bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails?.first
        .toJson();
    bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails?.first
        .toMap();
    expect(
        bookingListModelDomain
                .getBookingSummaryV2?.data?.bookingDetails?.first.car !=
            null,
        true);
    expect(
        bookingListModelDomain
                .getBookingSummaryV2?.data?.bookingDetails?.first.flight !=
            null,
        true);
    expect(
        bookingListModelDomain
                .getBookingSummaryV2?.data?.bookingDetails?.first.hotel !=
            null,
        true);
    expect(
        bookingListModelDomain
                .getBookingSummaryV2?.data?.bookingDetails?.first.tour !=
            null,
        true);
    bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails?.first.car
        ?.toJson();
    bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails?.first.car
        ?.toMap();
    bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails?.first.hotel
        ?.toJson();
    bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails?.first.hotel
        ?.toMap();  
    bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails?.first.tour
        ?.toJson();
    bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails?.first.tour
        ?.toMap(); 
    bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails?.first.flight
        ?.toJson();
    bookingListModelDomain.getBookingSummaryV2?.data?.bookingDetails?.first.flight
        ?.toMap();         
  });
}
