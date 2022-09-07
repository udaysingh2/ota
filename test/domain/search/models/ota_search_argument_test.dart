import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';

void main() {
  test('For class OtaSearchDataArgument => toMap() Test', () {
    OtaSearchDataArgument otaSearchDataArgument = OtaSearchDataArgument(
      searchKey: 'test',
      userId: 'test_1',
      latitude: 1.1476,
      longitude: 30.876,
      pageNumber: 1,
      pageSize: '10',
      searchAvailableApi: true,
      tourAndTicketData:
          TourAndTicketData(cityId: 'cityId', countryId: 'countryId'),
    );

    Map<String, dynamic> actual = otaSearchDataArgument.toMap();

    expect(actual.isNotEmpty, true);
  });

  test('Ota Search Argument Test => class FlightData', () {
    Map<String, dynamic> actual = FlightData().toMap();

    expect(actual.isEmpty, true);
  });

  test('Ota Search Argument Test constructor with static data', () {
    FilterData filterData = FilterData(
      maxPrice: 10000,
      minPrice: 999,
      sortingMode: 'sortingMode',
      rating: [5],
      sha: ['SHA'],
      availableHotel: true,
      capsulePromotion: [],
      promotion: [],
      reviewScore: [],
    );

    Map<String, dynamic> actual = filterData.toMap();

    expect(actual.isNotEmpty, true);
  });

  test('For class PromotionCapsule test', () {
    PromotionCapsule capsule = PromotionCapsule(
      name: 'Free Food',
      code: '111',
    );

    Map<String, dynamic> actual = capsule.toMap();

    expect(actual.isNotEmpty, true);
  });

  test('For class BookingData test', () {
    BookingData bookingData = BookingData(
      numRoom: 1,
      checkInDate: '',
      checkOutDate: '',
      roomData: [],
    );

    Map<String, dynamic> actual = bookingData.toMap();

    expect(actual.isNotEmpty, true);
  });

  test('For class RoomData test', () {
    RoomData roomData = RoomData(
      roomType: 'Double',
      numAdult: 1,
      numChild: 1,
      childAge1: 10,
    );

    Map<String, dynamic> actual = roomData.toMap();

    expect(actual.isNotEmpty, true);
  });

  test('For class HotelData test', () {
    HotelData hotelData = HotelData(
      hotelId: 'hotelId',
      cityId: 'cityId',
      locationId: 'locationId',
      bookingData: BookingData(
          checkInDate: 'checkInDate',
          checkOutDate: 'checkOutDate',
          roomData: [
            RoomData(
                roomType: 'roomType',
                numAdult: 2,
                numChild: 1,
                childAge1: 6,
                childAge2: null)
          ],
          numRoom: 1),
      filterData: FilterData(
        maxPrice: 10000,
        minPrice: 999,
        sortingMode: 'sortingMode',
        rating: [5],
        sha: ['SHA'],
        availableHotel: true,
        capsulePromotion: [],
        promotion: [],
        reviewScore: [],
      ),
    );

    Map<String, dynamic> actual = hotelData.toMap();

    expect(actual.isNotEmpty, true);
  });

  test("For class TourAndTicketData test", () {
    TourAndTicketData tourAndTicketData = TourAndTicketData(
      countryId: 'countryId',
      cityId: 'cityId',
      filter: ToursAndTicketFilter.toDefault(),
    );

    Map<String, dynamic> actual = tourAndTicketData.toMap();

    expect(actual.isNotEmpty, true);
  });

  test("For class carData test", () {
    CarData carData = CarData(
      returnDate: 'returnDate',
      includeDriver: true,
      age: 45,
      returnTime: 'returnTime',
      pickupTime: 'pickupTime',
      pickupDate: 'pickupDate',
      pickupLocationId: 'pickupLocationId',
      returnLocationId: 'returnLocationId',
    );

    Map<String, dynamic> actual = carData.toMap();

    CarData mapFromModel = CarData.fromMap(actual);
    expect(mapFromModel.includeDriver, true);

    expect(actual.isNotEmpty, true);
  });
}

OtaSearchDataArgument otaSearchData() => OtaSearchDataArgument(
      searchKey: 'test',
      userId: 'test_1',
      latitude: 1.1476,
      longitude: 30.876,
      pageNumber: 1,
      pageSize: '10',
      hotelData: HotelData(
        hotelId: 'hotelId',
        cityId: 'cityId',
        locationId: 'locationId',
        bookingData: BookingData(
            checkInDate: 'checkInDate',
            checkOutDate: 'checkOutDate',
            roomData: [
              RoomData(
                  roomType: 'roomType',
                  numAdult: 2,
                  numChild: 1,
                  childAge1: 6,
                  childAge2: null)
            ],
            numRoom: 1),
        filterData: FilterData(
          maxPrice: 10000,
          minPrice: 999,
          sortingMode: 'sortingMode',
          rating: [5],
          sha: ['SHA'],
          availableHotel: true,
          capsulePromotion: [],
          promotion: [],
          reviewScore: [],
        ),
      ),
      searchAvailableApi: true,
    );
