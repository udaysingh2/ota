import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../models/argument_data_model_automation.dart';
import '../models/argument_data_model_room_detail_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../models/room_detail_model_automation.dart';
import 'package:ota/main.dart' as app;
import '../configs/hoteDetailsConfig.dart' as hotelDetailsConfig;
import '../utils/Reusable/utility.dart';
import '../utils/hotel_detail_data_source_automation.dart';


HotelAutomation hotelAutomation = new HotelAutomation();
List<RoomCapacityAutomation> roomCapacityAutomation=[];
List<RoomData> roomData=[];
AppActions appActions = new AppActions();

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Room Details', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    var config = json.decode(hotelDetailsConfig.HotelDetailsConfig.data);
    HotelDetailRemoteDataSourceAutomation
        hotelDetailRemoteDataSourceAutomation =
        HotelDetailRemoteDataSourceImpl();
    roomData.add(new RoomData(adults: 3, children: 0));
    hotelAutomation =
        await hotelDetailRemoteDataSourceAutomation.getHotelDetail(
      HotelDetailDataArgumentAutomation(
        currency: config[0]['currency'],
        checkOutDate: config[0]['checkOutDate'],
        checkInDate: config[0]['checkInDate'],
        rooms: roomData,
        cityId: config[0]['cityId'],
        countryId: config[0]['countryId'],
        hotelId: config[0]['hotelID'],
      ),
    );
//***************************************************************************************************
    // Getting Room Details using GraphQL model
    String hotelRoomCode = hotelAutomation.data!.hotelDetail!.rooms!.elementAt(0).details!.elementAt(0).roomCode.toString();
    print("RoomCode is -----------> " + hotelRoomCode );
    double roomTotalPrice = hotelAutomation.data!.hotelDetail!.rooms!.elementAt(0).details!.elementAt(0).totalPrice!.toDouble();
    print("roomTotalPrice is -----------> " + roomTotalPrice.toString() );
    roomCapacityAutomation.add(new RoomCapacityAutomation(adult: 3, children: 0));
    RoomDetailDataAutomation roomDetailAutomation = await hotelDetailRemoteDataSourceAutomation.getRoomDetail(
      RoomDetailDataArgumentAutomation(
        currency: config[0]['currency'],
        checkOutDate: config[0]['checkOutDate'],
        checkInDate: config[0]['checkInDate'],
        room: roomCapacityAutomation,
        cityId: config[0]['cityId'],
        countryId: config[0]['countryId'],
        hotelId: config[0]['hotelID'],
        roomCode: hotelRoomCode,
        roomCategory: 0,
        price: roomTotalPrice,
      ),
    );
    Finder logInButtonWidget = appActions.findWidgetBy("Text", "Login with alpha user");
    await appActions.tapOnElement(logInButtonWidget, tester);
    Finder hotel2 = appActions.findWidgetBy("Text", "Hotel 2");
    await appActions.tapOnElement(hotel2, tester);

    List<Room> roomNameTest =
        hotelAutomation.data!.hotelDetail!.rooms!.toList();

    await appActions.scrollToSeeSpecificText("ห้อง", tester);

    print("Tapping on ----> " + roomNameTest.first.roomName.toString());
    Finder firstRoomName = find.text(roomNameTest.first.roomName.toString());
    await appActions.tapOnElement(firstRoomName, tester);
    print("Successfully tapped on " + roomNameTest.elementAt(0).roomName.toString());

    // Finder roomDetailKeys = find.byKey(Key("room_detail_key")).first;
    Finder roomDetailKeys = appActions.findWidgetBy("Key", "room_detail_key");
    await appActions.tapOnElement(roomDetailKeys.first, tester);
    print("Successfully tapped on roomDetailKey");

    print("----------------Getting room price from backend------------------");

    // String roomName = roomDetailAutomation.getRoomDetails!.data!.roomCategories!.elementAt(0).roomName.toString();
    // String roomType = roomDetailAutomation.getRoomDetails!.data!.roomCategories!.elementAt(0).roomType.toString();
    // String noOfRoom = roomDetailAutomation.getRoomDetails!.data!.roomCategories!.elementAt(0).noOfRooms.toString();
    String totalPrice = roomDetailAutomation.getRoomDetails!.data!.totalPrice!.round().toString();
    String expectedRoomPrice = appActions.getFormattedPrice(totalPrice);

    Finder priceWidget = appActions.findWidgetBy("Key","Total_Price");
    String actualRoomPrice = appActions.getTextFromWidget(priceWidget);
    actualRoomPrice = actualRoomPrice.split("ราคารวม")[0].trim();
    expect(actualRoomPrice, expectedRoomPrice);
    print("Successfully validated room price in UI");

    Finder bookNowButton = appActions.findWidgetBy("Key", "BookNowButton");
    expect(bookNowButton,findsOneWidget);
    print("Successfully validated BookNowButton displayed in UI");

    List<RoomCategoryAutomation> roomCategories = roomDetailAutomation.getRoomDetails!.data!.roomCategories!.toList();
    for(RoomCategoryAutomation category in roomCategories) {
      String expectedCategory = category.roomName.toString() + " " +
          category.roomType.toString() + " " +
          "(" + category.noOfRooms.toString() + " ห้องนอน) ";
      print("--------------> " + expectedCategory);
      Finder expectedCategories = appActions.findWidgetBy(
          "Text", expectedCategory);
      expect(expectedCategories, findsOneWidget);
    }
    print("Successfully validated roomCategories in UI");

    String expectedMealType = roomDetailAutomation.getRoomDetails!.data!.mealType.toString();
    Finder expectedMealTypeWidget = appActions.findWidgetBy("Text", expectedMealType);
    expect(expectedMealTypeWidget,findsOneWidget);
    print("Successfully validated MealType in UI");


    //Getting facility list from backend response and comparing one by one with UI data
    List<String> roomFacilities = roomDetailAutomation.getRoomDetails!.data!.roomFacilities!.toList();
    for(String expectedFacility in roomFacilities){
      Finder expectedRoomFacility = appActions.findWidgetBy("Text", expectedFacility);
      expect(expectedRoomFacility,findsOneWidget);
    }
    print("Successfully validated roomFacilities in UI");


    //Getting CancellationPolicy list from backend response and comparing one by one with UI data
    List<CancellationPolicyAutomation> cancellationPolicy = roomDetailAutomation.getRoomDetails!.data!.cancellationPolicy!.toList();
    for(CancellationPolicyAutomation expectedPolicy in cancellationPolicy){
      String dayDescPolicy = expectedPolicy.cancellationDaysDescription.toString();
      Finder expectedDayDescPolicy = appActions.findWidgetBy("Text", dayDescPolicy);
      expect(expectedDayDescPolicy,findsOneWidget);

      String chargeDescPolicy = expectedPolicy.cancellationChargeDescription.toString();
      Finder expectedChargeDescPolicy = appActions.findWidgetBy("Text", chargeDescPolicy);
      expect(expectedChargeDescPolicy,findsOneWidget);
    }
    print("Successfully validated cancellationPolicies in UI");


    List<FacilityAutomation> facilities= roomDetailAutomation.getRoomDetails!.data!.facilities!.toList();

    for(FacilityAutomation facility in facilities){
      String roomFacility = facility.value.toString();
      switch (roomFacility) {
        case "free.wifi":
          roomFacility = "Wi-Fi ฟรี";
          break;
        case "instant.payment":
          roomFacility = "ชำระเงินทันที";
          break;
        case "breakFast.included":
        roomFacility = "รวมอาหารเช้า";
        break;
      }
      print(roomFacility);
      if(roomFacility != "null"){
        Finder expectedFacility = appActions.findWidgetBy("Text", roomFacility);
        expect(expectedFacility, findsOneWidget);
      }
    }
    print("Successfully room offers in UI");
  });
}
