import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/modules/landing/view/widgets/static_playlist_widget.dart';
import 'package:ota/modules/landing/view_model/car_card_view_model.dart';
import 'package:ota/modules/landing/view_model/hotel_card_view_model.dart';
import 'package:ota/modules/landing/view_model/landing_static_playlist_card_view_model.dart';
import 'package:ota/modules/landing/view_model/static_playlist_data_view_model.dart';
import 'package:ota/modules/landing/view_model/tour_card_view_model.dart';
import 'package:ota/modules/playlist/view/widgets/car_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view/widgets/hotel_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view/widgets/tour_ticket_static_playlist_card_widget.dart';

void main() {
  testWidgets('static playlist widget ...', (tester) async {
    await tester.runAsync(() async {
      Widget widget = MaterialApp(
        routes: AppRoutes.getRoutes(),
        home: Scaffold(
          body: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              StaticPlayListWidget(
                playList: [
                  OtaLandingStaticPlayListModel(
                    playlistName: 'All services',
                    playlistId: '31',
                    cardList: [
                      LandingStaticPlayListCardViewModel(
                        productType: 'HOTEL',
                        modelEnum: StaticPlayListModelEnum.hotel,
                        hotel: HotelCardViewModel(
                          id: 'MA0511000344',
                          cityId: 'MA05110041',
                          countryId: 'MA05110001',
                          name: 'Shangri La Bangkok',
                          locationName: 'Wat Suan Phu New',
                          cityName: 'Bangkok',
                          promotionTextLine1: 'Special',
                          promotionTextLine2: 'Deals',
                          capsulePromotion: [
                            HotelCardPromotions(
                              code: 'Free Food Delivery',
                              name: '281',
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                onTitleArrowClick: (id, name) {},
              ),
            ],
          ),
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(HotelStaticPlaylistCard));
    });
  });

  testWidgets('static playlist widget car...', (tester) async {
    await tester.runAsync(() async {
      Widget widget = MaterialApp(
        routes: AppRoutes.getRoutes(),
        home: Scaffold(
          body: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              StaticPlayListWidget(
                playList: [
                  OtaLandingStaticPlayListModel(
                    playlistName: 'Car rental',
                    playlistId: '34',
                    cardList: [
                      LandingStaticPlayListCardViewModel(
                        productType: "CARRENTAL",
                        modelEnum: StaticPlayListModelEnum.carRental,
                        carRental: CarRentalViewModel(
                          id: "MA2110000373",
                          cityId: "MA05110062",
                          countryId: "MA05110001",
                          imageUrl: "",
                          name: " Koh Phi Phi ",
                          locationName: " Ko Phi Phi ",
                          cityName: "Krabi",
                          styleName: "Adventure",
                          pickupLocationId: '12345',
                          rating: 4,
                          returnLocationId: '45677',
                          startPrice: 120.0,
                        ),
                      ),
                    ],
                  )
                ],
                onTitleArrowClick: (id, name) {},
              ),
            ],
          ),
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CarStaticPlaylistCard));
    });
  });

  testWidgets('static playlist widget Tour...', (tester) async {
    await tester.runAsync(() async {
      Widget widget = MaterialApp(
        routes: AppRoutes.getRoutes(),
        home: Scaffold(
          body: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              StaticPlayListWidget(
                playList: [
                  OtaLandingStaticPlayListModel(
                    playlistName: 'Activity',
                    playlistId: '33',
                    cardList: [
                      LandingStaticPlayListCardViewModel(
                        productType: "TOUR",
                        modelEnum: StaticPlayListModelEnum.tour,
                        tour: TourCardViewModel(
                          id: "MA2110000373",
                          cityId: "MA05110062",
                          countryId: "MA05110001",
                          imageUrl: "",
                          name: " Koh Phi Phi ",
                          locationName: " Ko Phi Phi ",
                          cityName: "Krabi",
                          styleName: "Adventure",
                          startPrice: 1445,
                          rating: 0,
                          capsulePromotion: [],
                          infoPromotion: [],
                        ),
                      ),
                    ],
                  ),
                ],
                onTitleArrowClick: (id, name) {},
              ),
            ],
          ),
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(TourTicketStaticPlaylistCard));
    });
  });

  testWidgets('static playlist widget Ticket...', (tester) async {
    await tester.runAsync(() async {
      Widget widget = MaterialApp(
        routes: AppRoutes.getRoutes(),
        home: Scaffold(
          body: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              StaticPlayListWidget(
                playList: [
                  OtaLandingStaticPlayListModel(
                    playlistName: 'Ticket',
                    playlistId: '32',
                    cardList: [
                      LandingStaticPlayListCardViewModel(
                        productType: "TICKET",
                        modelEnum: StaticPlayListModelEnum.ticket,
                        ticket: TourCardViewModel(
                          id: "MA2110000373",
                          cityId: "MA05110062",
                          countryId: "MA05110001",
                          imageUrl: "",
                          name: " Koh Phi Phi ",
                          locationName: " Ko Phi Phi ",
                          cityName: "Krabi",
                          styleName: "Adventure",
                          startPrice: 1445,
                          rating: 0,
                        ),
                      ),
                    ],
                  ),
                ],
                onTitleArrowClick: (id, name) {},
              ),
            ],
          ),
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaNextButton));
      await tester.tap(find.byType(TourTicketStaticPlaylistCard));
    });
  });
}
