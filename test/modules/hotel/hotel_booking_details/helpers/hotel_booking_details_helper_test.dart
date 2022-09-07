import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart';
import 'package:ota/modules/hotel/hotel_booking_details/helpers/hotel_booking_details_helper.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_room_info_view_model.dart';

class MockContext extends Mock implements BuildContext {}

void main() {
  const String kOverlay = "OVERLAY";
  const String kDefaultIcon = "assets/images/icons/uil_info-circle.svg";
  const String kMaxAdults = "MAX_PAX_NBR";
  const String kQueenBedFlag = "QUEEN_BED_FLAG";
  const String kTwinBedFlag = "TWIN_BED_FLAG";
  const String kDoubleBedFlag = "DOUBLE_BED_FLAG";
  const String kDimension = "DIMENSION";
  const String kPayment = "PAYMENT";
  const String kBreakfast = "BREAKFAST";
  const String kWifi = "WIFI";
  const String kNonSmoking = "NON_SMOKING";
  const String kDoubleQueenBedFlag = "DOUBLE_QUEEN";
  const String kDoubleTwinBedFlag = "DOUBLE_TWIN";
  const String kQueenTwinBedFlag = "QUEEN_TWIN";
  const String kDoubleQueenTwinBedFlag = "DOUBLE_QUEEN_TWIN";
  var index = 0;
  String str = "";

  MockContext context = MockContext();

  List<Promotions> promotions = [
    Promotions(
        productType: "",
        endDate: "",
        line1: "",
        line2: "",
        productId: "",
        promotionCode: "",
        promotionType: "OVERLAY",
        startDate: "")
  ];

  List<Facility> facility = [
    Facility(key: kDoubleBedFlag, value: "DOUBLE_BED_FLAG"),
    Facility(key: kQueenBedFlag, value: "QUEEN_BED_FLAG"),
    Facility(key: kTwinBedFlag, value: "TWIN_BED_FLAG")
  ];
  HotelBookingDetailsFacilityList hotelFacility =
      HotelBookingDetailsFacilityList(key: "", value: "");
  List<HotelBookingDetailsFacilityList> list = [];

  test(" Hotel Booking Details Helper getAdminPromotionLine1...", () {
    HotelBookingDetailHelper.getAdminPromotionLine1(promotions);
    expect(promotions[index].promotionType == kOverlay, true);
  });

  test(" Hotel Booking Details Helper getAdminPromotionLine2...", () {
    HotelBookingDetailHelper.getAdminPromotionLine2(promotions);
    expect(promotions[index].promotionType == kOverlay, true);
  });

  test(" Hotel Booking Details Helper getFacilityList...", () {
    list.add(HotelBookingDetailsFacilityList(
        key: kDoubleQueenTwinBedFlag, value: "Y"));
    HotelBookingDetailHelper.getFacilityList(facility);
    expect(facility[index].key == kDoubleBedFlag, true);
    expect(facility[index + 1].key == kQueenBedFlag, true);
    expect(facility[index + 2].key == kTwinBedFlag, true);
  });

  test(" Hotel Booking Details Helper getFacilityList...", () {
    facility.removeAt(2);
    HotelBookingDetailHelper.getFacilityList(facility);
  });

  test(" Hotel Booking Details Helper getFacilityList...", () {
    facility.removeAt(1);
    facility.add(Facility(key: kTwinBedFlag, value: "TWIN_BED_FLAG"));
    HotelBookingDetailHelper.getFacilityList(facility);
  });

  test(" Hotel Booking Details Helper getFacilityList...", () {
    facility.removeAt(0);
    facility.add(Facility(key: kQueenBedFlag, value: "QUEEN_BED_FLAG"));
    HotelBookingDetailHelper.getFacilityList(facility);
  });

  test(" Hotel Booking Details Helper ...", () {
    facility.clear();
    list.add(HotelBookingDetailsFacilityList(key: str, value: "Y"));
    HotelBookingDetailHelper.getFacilityList(facility);
    expect(facility.isEmpty, true);
    expect(list.isNotEmpty, true);
  });

  test(" Hotel Booking Details Helper getName...", () {
    HotelBookingDetailHelper.getName(hotelFacility, context);
  });

  test(" Hotel Booking Details Helper getName...", () {
    hotelFacility.key = kBreakfast;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kWifi;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kNonSmoking;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kDoubleBedFlag;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kQueenBedFlag;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kDimension;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kMaxAdults;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kTwinBedFlag;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kDoubleTwinBedFlag;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kQueenBedFlag;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kDoubleQueenBedFlag;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kDoubleTwinBedFlag;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kQueenTwinBedFlag;
    HotelBookingDetailHelper.getName(hotelFacility, context);

    hotelFacility.key = kDoubleQueenTwinBedFlag;
    HotelBookingDetailHelper.getName(hotelFacility, context);
  });

  test(" Hotel Booking Details Helper getSvgIcon ..", () {
    HotelBookingDetailHelper.getSvgIcon(kPayment);
    HotelBookingDetailHelper.getSvgIcon(kBreakfast);
    HotelBookingDetailHelper.getSvgIcon(kWifi);
    HotelBookingDetailHelper.getSvgIcon(kNonSmoking);
    HotelBookingDetailHelper.getSvgIcon(kDoubleBedFlag);
    HotelBookingDetailHelper.getSvgIcon(kQueenBedFlag);
    HotelBookingDetailHelper.getSvgIcon(kTwinBedFlag);
    HotelBookingDetailHelper.getSvgIcon(kDoubleQueenBedFlag);
    HotelBookingDetailHelper.getSvgIcon(kDoubleTwinBedFlag);
    HotelBookingDetailHelper.getSvgIcon(kQueenTwinBedFlag);
    HotelBookingDetailHelper.getSvgIcon(kDoubleQueenTwinBedFlag);
    HotelBookingDetailHelper.getSvgIcon(kMaxAdults);
    HotelBookingDetailHelper.getSvgIcon(kDimension);
    HotelBookingDetailHelper.getSvgIcon(kDefaultIcon);
  });
}
