import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/suggetion_view_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_argument.dart';

import '../../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';

void main() {
  test('argument model - HotelDetailArgument ...', () async {
    final hotelDetailArgument = getHotelDetailArgumentMock();
    final hotelDataArgument = hotelDetailArgument.toHotelDataArgument();
    expect(hotelDataArgument.checkInDate, hotelDetailArgument.checkInDate);
    expect(hotelDataArgument.checkOutDate, hotelDetailArgument.checkOutDate);
    expect(hotelDetailArgument.guestCount, 8);
    expect(hotelDetailArgument.childrenCount, 3);
  });

  test('argument model - default argument...', () async {
    final hotelDetailArgument = HotelDetailArgument.getDefaulArgument(
        'MA0511000344', 'MA05110041', 'MA05110001');
    expect(hotelDetailArgument.hotelId, 'MA0511000344');
    expect(hotelDetailArgument.cityId, 'MA05110041');
    expect(hotelDetailArgument.countryCode, 'MA05110001');

    final hotelDetailArgument1 =
        HotelDetailArgument.getDefaulArgument(null, null, null);
    expect(hotelDetailArgument1.hotelId, '');
  });

  test('argument model - booking argument...', () async {
    final hotelDetailArgument = HotelDetailArgument.getBookingArgument(
      hotelId: 'MA0511000344',
      cityId: 'MA05110041',
      countryId: 'MA05110001',
      bookingViewData: BookingViewData(
        checkinDate: "2021-09-01",
        checkoutDate: "2021-09-02",
        roomData: [RoomViewData(roomType: 'Double', numAdult: 2, numChild: 0)],
        numRoom: 1,
      ),
      userType: HotelDetailUserType.loggedInUser,
    );
    expect(hotelDetailArgument.hotelId, 'MA0511000344');
    expect(hotelDetailArgument.cityId, 'MA05110041');
    expect(hotelDetailArgument.countryCode, 'MA05110001');
    expect(hotelDetailArgument.rooms.length, 1);
    expect(hotelDetailArgument.rooms.first.adults, 2);
  });

  group('For class Argument Model group test', () {
    test('For toHotelDataArgument() test', () {
      final result = _argument().toHotelDataArgument();

      expect(result.rooms.isNotEmpty, true);
    });

    test('For fromHotelDetailArgumentAndSuggestions() test', () {
      final result = HotelDetailArgument.fromHotelDetailArgumentAndSuggetions(
        hotelDetailDataArgument: _argument(),
        suggetionViewModel: _viewModel(),
      );

      expect(result.hotelId, 'Hotel111');
      expect(result.rooms.isNotEmpty, true);
    });

    test('For toHotelDetailInterestDataArgument() test', () {
      final result = _argument().toHotelDetailInterestDataArgument();

      expect(result.hotelId, 'hotelId');
      expect(result.checkInDate.isNotEmpty, true);
    });

    test('For getDefaultArgumentForChannel() test', () {
      final result = HotelDetailArgument.getDefaultArgumentForChannel(
        'hotelId',
        'cityId',
        'countryId',
        HotelDetailUserType.guestUser,
      );

      expect(result.hotelId, 'hotelId');
      expect(result.userType, HotelDetailUserType.guestUser);
    });

    test('For factory HotelDetailArgument.getHotelDetailArgument() test', () {
      final result = HotelDetailArgument.getHotelDetailArgument(
        'hotelId',
        'cityId',
        'countryId',
        '11/05/2022',
        '13/05/2022',
        [
          Room(
            adults: 2,
            children: 0,
          )
        ],
        HotelDetailUserType.loggedInUser,
      );

      expect(result.rooms.isNotEmpty, true);
      expect(result.userType, HotelDetailUserType.loggedInUser);
    });

    test(
        'For factory HotelDetailArgument.getHotelDetailArgument() If details NULL test',
        () {
      final result = HotelDetailArgument.getHotelDetailArgument(
        'hotelId',
        'cityId',
        'countryId',
        null,
        null,
        [],
        HotelDetailUserType.loggedInUser,
      );

      expect(result.rooms.isNotEmpty, true);
      expect(result.userType, HotelDetailUserType.loggedInUser);
    });
  });
}

HotelDetailArgument _argument() => HotelDetailArgument(
      userType: HotelDetailUserType.guestUser,
      currencyCode: 'currencyCode',
      checkOutDate: '11/05/2022',
      checkInDate: '13/05/2022',
      rooms: [
        Room(
          adults: 2,
          children: 1,
          childAge1: 10,
        ),
      ],
      cityId: 'cityId',
      countryCode: 'countryCode',
      hotelId: 'hotelId',
    );

SuggetionViewModel _viewModel() => SuggetionViewModel(
      hotelId: 'Hotel111',
      cityId: 'cityId',
      reviewText: 'reviewText',
      ratingText: 'ratingText',
      ratingTitle: 'ratingTitle',
      offerPercent: '50',
      headerText: 'headerText',
      discount: '500',
      addressText: 'addressText',
      adminPromotionLine1: 'adminPromotionLine1',
      adminPromotionLine2: 'adminPromotionLine2',
      imageUrl: 'imageUrl',
      countryCode: 'countryCode',
      amenitiesList: ['AC'],
    );
