import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/room_detail/view/room_detail_screen.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_argument_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_category_view_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_detail_view_model.dart';

GlobalKey<RoomDetailScreenState> key = GlobalKey(debugLabel: "key");
RoomDetailScreen roomDetailScreen = RoomDetailScreen(
  key: key,
);

void main() {
  RoomDetailArgument roomDetailArgument = RoomDetailArgument(
    address: "address",
    rating: "rating",
    hotelId: "MA0511000344",
    cityId: "MA05110041",
    checkInDate: "2021-09-18",
    checkOutDate: "2021-09-19",
    rooms: [Room(adults: 2, children: 2), Room(adults: 5, children: 0)],
    currency: AppConfig().currency,
    countryId: "MA05110001",
    roomCode: "MA07080326",
    roomCategory: 1,
    price: 5040.00,
    freefoodDelivery: false,
    supplierId: '123',
    supplierName: 'Mark All Services Co., Ltd',
    mealCode: 'BB',
  );
  testWidgets('Room Detail Screen Test Success', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        routes: Routes.getRoutes(),
        supportedLocales: [
          Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode),
          Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode),
        ],
        localizationsDelegates: const [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          return supportedLocales.elementAt(0);
        },
        home: Scaffold(
          body: Builder(builder: (context) {
            return TextButton(
              child: const Text("press"),
              onPressed: () => Navigator.pushNamed(context, Routes.roomDetails,
                  arguments: roomDetailArgument),
            );
          }),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await tester.pump();

      //Conditional Cancellation
      key.currentState?.roomDetailViewBloc.state.pageState =
          RoomDetailViewPageState.success;
      key.currentState?.roomDetailViewBloc.state.data = RoomDetailModel(
          supplierId: '123',
          supplierName: 'Mark All Services Co., Ltd',
          totalAmount: 1000.96,
          discountPercent: 50,
          nightPriceBeforeDiscount: 2000.0,
          perNightPrice: 1000.96,
          roomImage: "",
          cancellationPolicies: [
            CancellationPolicyModel(
              cancellationChargeDescription: "given Discription",
              cancellationDaysDescription: "5 days concellation",
              cancellationPolicyState:
                  CancellationPolicyState.conditionalCancellation,
            )
          ],
          facilityList: [FacilityModel("key", "value")],
          roomDetailCancellationPolicyType:
              RoomDetailCancellationPolicyType.conditionalCancellation,
          roomFacilities: ["wifi", "payment"],
          roomList: [
            RoomCategoryViewModel(
                noOfRoomsAndName: "2 x DELUXE",
                roomCount: 2,
                roomName: "Delux",
                roomType: "Ac")
          ],
          roomType: "Double Bed");
      key.currentState?.roomDetailViewBloc
          .emit(key.currentState!.roomDetailViewBloc.state);
      await tester.pump(const Duration(seconds: 5));
      key.currentState?.roomDetailViewBloc
          .emit(key.currentState!.roomDetailViewBloc.state);
      await tester.pump(const Duration(seconds: 5));

      //free Cancellation
      key.currentState?.roomDetailViewBloc.state.data = RoomDetailModel(
          supplierId: '123',
          supplierName: 'Mark All Services Co., Ltd',
          totalAmount: 1000.96,
          discountPercent: 50,
          nightPriceBeforeDiscount: 2000.0,
          perNightPrice: 1000.96,
          roomImage: "",
          cancellationPolicies: [
            CancellationPolicyModel(
              cancellationChargeDescription: "given Discription",
              cancellationDaysDescription: "5 days concellation",
              cancellationPolicyState: CancellationPolicyState.freeCancellation,
            )
          ],
          facilityList: [FacilityModel("key", "value")],
          roomDetailCancellationPolicyType:
              RoomDetailCancellationPolicyType.freeCancellation,
          roomFacilities: ["wifi", "payment"],
          roomList: [
            RoomCategoryViewModel(
                noOfRoomsAndName: "2 x DELUXE",
                roomCount: 2,
                roomName: "Delux",
                roomType: "Ac")
          ],
          roomType: "Double Bed");
      key.currentState?.roomDetailViewBloc
          .emit(key.currentState!.roomDetailViewBloc.state);
      await tester.pump(const Duration(seconds: 5));
      key.currentState?.roomDetailViewBloc
          .emit(key.currentState!.roomDetailViewBloc.state);
      await tester.pump(const Duration(seconds: 5));

      //Non Refundable Cancellation
      key.currentState?.roomDetailViewBloc.state.data = RoomDetailModel(
          supplierId: '123',
          supplierName: 'Mark All Services Co., Ltd',
          totalAmount: 1000.96,
          discountPercent: 50,
          nightPriceBeforeDiscount: 2000.0,
          perNightPrice: 1000.96,
          roomImage: "",
          cancellationPolicies: [
            CancellationPolicyModel(
              cancellationChargeDescription: "given Discription",
              cancellationDaysDescription: "5 days concellation",
              cancellationPolicyState: CancellationPolicyState.nonRefundable,
            )
          ],
          facilityList: [FacilityModel("key", "value")],
          roomDetailCancellationPolicyType:
              RoomDetailCancellationPolicyType.nonRefundable,
          roomFacilities: ["wifi", "payment"],
          roomList: [
            RoomCategoryViewModel(
                noOfRoomsAndName: "2 x DELUXE",
                roomCount: 2,
                roomName: "Delux",
                roomType: "Ac")
          ],
          roomType: "Double Bed");
      key.currentState?.roomDetailViewBloc
          .emit(key.currentState!.roomDetailViewBloc.state);
      await tester.pump(const Duration(seconds: 5));
      key.currentState?.roomDetailViewBloc
          .emit(key.currentState!.roomDetailViewBloc.state);
      await tester.pump(const Duration(seconds: 5));

      key.currentState?.roomDetailViewBloc.state.pageState =
          RoomDetailViewPageState.failure;
      key.currentState?.roomDetailViewBloc
          .emit(key.currentState!.roomDetailViewBloc.state);
      await tester.pump(const Duration(seconds: 5));
      key.currentState?.roomDetailViewBloc
          .emit(key.currentState!.roomDetailViewBloc.state);
      await tester.pump(const Duration(seconds: 5));
    });
  });
}

class Routes {
  static const String roomDetails = '/roomDetails';

  static Map<String, WidgetBuilder> getRoutes() {
    return {roomDetails: (context) => roomDetailScreen};
  }
}
