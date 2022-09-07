import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/booking_initiate/data_sources/reservation_remote_data_source_mock.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';
import 'package:ota/domain/hotel/booking_initiate/repositories/reservation_repository_impl.dart';
import 'package:ota/domain/hotel/booking_initiate/usecases/reservation_room_usecases.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  ReservationRoomUseCase? reservationRoomUseCase;
  RoomCapacity roomCapacity = RoomCapacity(
    adult: 1,
  );
  ReservationDataArgument argument = ReservationDataArgument(
    hotelId: 'HotelId',
    cityId: 'CityId',
    checkInDate: 'CheckInDate',
    checkOutDate: 'CheckOutDate',
    room: [roomCapacity],
    currency: 'TBH',
    countryId: 'CountryId',
    roomCode: 'RoomCode',
    roomCategory: 1,
    price: 0.0,
    supplierId: 'CL213',
    supplierName: 'Mark All Services Co., Ltd',
    mealCode: 'BB',
  );

  setUpAll(() async {
    /// Code coverage for default implementation.
    ReservationRepository reservationRepository = ReservationRepositoryImpl(
        remoteDataSource: ReservationMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    reservationRoomUseCase =
        ReservationRoomUseCasesImpl(repository: reservationRepository);
  });

  test('Reservation romm usecases', () async {
    /// Consent user cases impl
    final otaSearchResult =
        await reservationRoomUseCase!.getRoomDetail(argument);
    expect(otaSearchResult?.isLeft, false);
  });
}
