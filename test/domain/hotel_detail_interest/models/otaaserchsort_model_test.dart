import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Ota search Filter model group", () {
    test('Ota search Filter model', () async {
      HotelDetailInterestDataArgument argument =
          HotelDetailInterestDataArgument(
        hotelId: "12333",
        lat: 1.2,
        long: 2.4,
        epoch: "12",
        checkInDate: "12-12-2020",
        checkOutDate: "11-12-2020",
        maxHotel: 7,
        roomCapacity: [
          RoomCapacity(
            adult: 2,
          ),
          RoomCapacity(
            adult: 3,
          ),
        ],
      );
      printDebug(argument.toGraphqlString().toString());
    });
  });
}
