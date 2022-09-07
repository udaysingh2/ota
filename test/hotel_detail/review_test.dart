import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/review_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/review_view_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Review Widget", () {
    testWidgets('Review Widget test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ReviewWidget(reviewList: [
                ReviewViewModel(
                  rating: 10,
                  date: "22 May '21",
                  comment: 'The room atmosphere is very good. 😍',
                  profileName: "Wichapon M.",
                  profileDate: 'June 2021',
                  profileCitizen: "🇹🇭Thai",
                  profileRoomType: 'Superior',
                  profileTravelType: 'travel alone',
                  // profileImageUrl:
                  //     'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
                ),
                ReviewViewModel(
                  rating: 10,
                  date: "22 May '21",
                  comment: 'The room atmosphere is very good. 😍',
                  profileName: "Wichapon M.",
                  profileDate: 'June 2021',
                  profileCitizen: "🇹🇭Thai",
                  profileRoomType: 'Superior',
                  profileTravelType: 'travel alone',
                  // profileImageUrl:
                  //     'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
                ),
              ]),
            ),
          ),
        );
        await tester.pump();
      });
    });
  });
}
