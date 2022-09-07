import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/hotel/hotel_detail/view/hotel_detail.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/primary_hotel_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/secondary_hotel_widget.dart';

import '../configs/hoteDetailsConfig.dart' as hotelDetailsConfig;
import '../models/argument_data_model_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../utils/hotel_detail_data_source_automation.dart';

HotelAutomation hotelAutomation = new HotelAutomation();
DetailAutomation detailAutomation = new DetailAutomation();
DataAutomation dataAutomation = new DataAutomation();
Room room = new Room();
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Hotel Details', (WidgetTester tester) async {
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
    List<RoomData> roomData = [];
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
    await tester.tap(find.text("Login with alpha user"));
    await tester.pumpAndSettle();
    Finder hotel2 = find.text("Hotel 2");
    await tester.tap(hotel2);
    await tester.pumpAndSettle(Duration(seconds: 10));
    List<Room>? roomObj = hotelAutomation.data?.hotelDetail?.rooms;

    //Graphql data
    for (var i = 0; i < roomObj!.length; i++) {
      for (var j = 0; j < roomObj[i].details!.length; j++) {
        print("inside for looop" + i.toString());
        print(roomObj[i].details![j].nightPrice);
        print("this is night price");
        print(roomObj[i].details![j].roomOfferName);
        print("this is room offer naaaaaame" +
            roomObj[i].details![j].roomOfferName!);
        print(roomObj[i].details![j].roomType);
        print("this is roooom typeee");
        print(roomObj[i].details![j].totalPrice);
        print("this is total priceeeeee");
      }
    }
    for (var m = 0; m < roomObj.length; m++) {
      for (var n = 0; n < roomObj[m].facility!.length; n++) {
        print(roomObj[m].facility![n].key);
      }
    }

    //UI data
    // await tester.dragUntilVisible(find.byType(PrimaryHotelView),
    //     find.byType(HotelDetailView), Offset(0, -100));

    // // await tester.drag(find.byType(PrimaryHotelView), Offset(0, -100));
    // await tester.pumpAndSettle();
    Finder hotelNameObjPrimary = find.byType(PrimaryHotelView);
    Iterable<Widget> primaryViewObj = tester.widgetList(hotelNameObjPrimary);

    // HotelDetailViewModel hotelDetailViewModel =
    //     new HotelDetailViewModel(pageState: HotelDetailViewPageState.success);
    // List<PrimaryViewModel>? hotelObjPrimary =
    //     hotelDetailViewModel.data!.roomList;
    print("------------------below is from UI");
    for (var i = 0; i < primaryViewObj.length; i++) {
      print("inside for looop" + i.toString());

      await tester.dragUntilVisible(find.byType(PrimaryHotelView),
          find.byType(HotelDetailView), Offset(0, -100));
      await tester.pumpAndSettle();

      PrimaryHotelView primaryVar =
          primaryViewObj.elementAt(i) as PrimaryHotelView;
      print(primaryVar.primaryViewModel.roomName);
      await tester.tap(find.text(primaryVar.primaryViewModel.roomName));
      await tester.pumpAndSettle();

      Finder hotelNameObjSecondary = find.byType(SecondaryHotelView);
      Iterable<Widget> secondaryViewObj =
          tester.widgetList(hotelNameObjSecondary);

      for (var j = 0; j < secondaryViewObj.length; j++) {
        SecondaryHotelView secondaryVar =
            secondaryViewObj.elementAt(j) as SecondaryHotelView;
        print(secondaryVar.secondaryViewModel.nightPrice);
        print(secondaryVar.secondaryViewModel.roomType);
        print(secondaryVar.secondaryViewModel.roomName);
        print(secondaryVar.secondaryViewModel.totalPrice);
        // print(secondaryVar.secondaryViewModel.facilityList!.facilityName);
        //expect(find.text(secondaryVar.secondaryViewModel.nightPrice.t),findsWidgets);
        // expect(find.text(secondaryVar.secondaryViewModel.roomName),
        //     findsOneWidget);
        // expect(find.text(secondaryVar.secondaryViewModel.roomType),
        //     findsOneWidget);
        // expect(find.text(secondaryVar.secondaryViewModel.totalPrice.toString()),
        //     findsOneWidget);

        // secondaryVar.secondaryViewModel.facilityList!.forEach((element) {
        //   expect(find.text(element.facilityName), findsOneWidget);
        // });
      }
    }
  });
}
