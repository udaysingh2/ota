import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;

import '../models/argument_data_model_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../models/ota_search_model_automation.dart';
import '../utils/consolidated_data_source_automation.dart';

HotelAutomation hotelAutomation = HotelAutomation();
OtaSearchAutomation otaSearchAutomation = OtaSearchAutomation();
OtaConsolidatedRemoteDataSource otaConsolidatedRemoteDataSource =
    OtaConsolidatedRemoteDataSourceImpl();
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Test graphql data', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    //await tester.tap(find.text("Login with alpha user"));
    await tester.pumpAndSettle();
    /*OtaSearchDataAutomation otaSearchDataAutomation =
        await otaConsolidatedRemoteDataSource
            .getOtaSearchData(OtaSearchDataArgumentAutomation(
      searchKey: 'Money motel',
      userId: '1234',
      latitude: 140.54256,
      longitude: 19.7618,
      pageNumber: 1,
      pageSize: '365',
      hotelData: HotelDataAutomation(
        cityId: 'MA05110041',
        locationId: '',
        bookingData: BookingDataAutomation(
            checkOutDate: '2022-12-12',
            checkInDate: '2022-12-11',
            numRoom: 1,
            roomData: [
              RoomDataAutomation(
                  roomType: 'Double',
                  numAdult: 2,
                  numChild: 0,
                  childAge1: null,
                  childAge2: null)
            ]),
        filterData: FilterDataAutomation(
            maxPrice: 10000, minPrice: 999, sortingMode: 'sortingMode'),
      ),
    ));

    print(
        '--------------------${otaSearchDataAutomation.getSearchDetail?.status?.code}');
    print(
        '-----------------------------${otaSearchDataAutomation.getSearchDetail?.data?.hotel?.hotelList!}');*/
    List<RoomData> roomData = [];
    roomData.add(
        new RoomData(adults: 2, children: 0, childAge1: null, childAge2: null));
    hotelAutomation = await otaConsolidatedRemoteDataSource.getHotelDetail(
        HotelDetailDataArgumentAutomation(
            hotelId: "MA0909060653",
            cityId: "MA05110041",
            checkInDate: "2022-12-14",
            checkOutDate: "2022-12-15",
            currency: "THB",
            countryId: "MA05110001",
            rooms: roomData));

    print(
        'The room name is -------------${hotelAutomation.data!.hotelDetail!.rooms!.length}');
  });
}
