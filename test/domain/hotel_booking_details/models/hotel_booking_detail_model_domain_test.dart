import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json =
      fixture("hotel_booking_detail/hotel_booking_details.json");
  HotelBookingDetailModelDomain hotelBookingDetailModelDomain =
      HotelBookingDetailModelDomain.fromJson(json);

  test("BookingData Model", () {
    ///Convert into Model
    HotelBookingDetailModelDomain model = hotelBookingDetailModelDomain;
    expect(model.data != null, true);
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("Promotion Model test ", () {
    Map<String, dynamic> json = {
      "promotionId": 2,
      "promotionName": "2",
      "shortDescription": "2",
      "discount": 2.0,
      "maximumDiscount": 2.0,
      "discountFor": "2",
      "promotionLink": "true",
      "promotionType": "2",
      "iconUrl": "2",
      "voucherCode": "2",
      "startDate": '2.0',
      "endDate": '2.0',
      "applicationKey": '2.0'
    };
    Promotion? promotion = Promotion.fromMap(json);
    expect(promotion.promotionId, 2);
    promotion.toMap();
  });

  test("PromoPriceDetails Model test ", () {
    Map<String, dynamic> json = {
      "effectiveDiscount": 2.0,
      "orderPrice": 2.0,
      "addonPrice": 2.0,
      "billingAmount": 2.0,
      "totalAmount": 2.0,
    };
    PromoPriceDetails? promoPriceDetails = PromoPriceDetails.fromMap(json);
    expect(promoPriceDetails.orderPrice, 2.0);
    promoPriceDetails.toMap();
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
  });

  test("status Model test ", () {
    var json = """
{
        "code": "1000",
        "header": "Success",
        "description": null
}
""";

    Status status = Status.fromJson(json);
    expect(status.code, '1000');
  });

  test("RoomFacility Model test ", () {
    var json = """
{
        "code": "1000",
        "name": "Success"
}
""";

    RoomFacility status = RoomFacility.fromJson(json);
    expect(status.code, '1000');
  });

   test("Promotions Model test ", () {
    Map<String, dynamic> json = {
      "productId": '2',
      "productType": "2",
      "promotionCode": "2",
      "line1": '2.0',
      "line2": '2.0',
      "startDate": '2.0',
      "endDate": '2.0',
    };
    Promotions? promotion = Promotions.fromMap(json);
    expect(promotion.productId, '2');
    promotion.toMap();
  });

  test("Details Model", () {
    ///Convert into Model
    BookingDetailsData? model = hotelBookingDetailModelDomain.data;
    expect(model?.bookingUrn != null, true);
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
  test(" Hotel Details Model", () {
    ///Convert into Model
    HotelDetails? model =
        hotelBookingDetailModelDomain.data?.hotelBookingDetail?.hotelDetails;
    expect(model?.checkInDate != null, false);
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
  test(" Hotel Details Model", () {
    ///Convert into Model
    HotelDetails? model =
        hotelBookingDetailModelDomain.data?.hotelBookingDetail?.hotelDetails;
    expect(model?.checkInDate != null, false);
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
}
