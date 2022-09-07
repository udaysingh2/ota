import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_recommendation_card_widget.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_recommendation_view_model.dart';

import '../../../../../helper.dart';

const _kImageUrl =
    'https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg';

void main() {
  testWidgets("Car Recommendation Widget Test", (tester) async {
    Widget widget = getMaterialWrapper(CarRecommendedLocationsWidget(
        recommendedLocationTitle: 'Recommended Locations',
        recommendedLocationList: [
          CarRecommendedLocationModel(
              imageUrl: "",
              placeName: "",
              playlistId: "1",
              hotelId: '12',
              cityId: '123',
              countryId: '1234',
              searchKey: ""),
          CarRecommendedLocationModel(
              imageUrl: _kImageUrl,
              placeName: "Thailand",
              playlistId: "2",
              hotelId: '12',
              cityId: '123',
              countryId: '1234',
              searchKey: ""),
          CarRecommendedLocationModel(
              imageUrl: _kImageUrl,
              placeName: "Singapore",
              playlistId: "3",
              hotelId: '12',
              cityId: '123',
              countryId: '1234',
              searchKey: "")
        ]));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(InkWell).first);
  });

  testWidgets("Car Recommendation Widget Test without Image", (tester) async {
    Widget widget = getMaterialWrapper(CarRecommendedLocationsWidget(
        recommendedLocationTitle: 'Recommended Locations',
        recommendedLocationList: [
          CarRecommendedLocationModel(
              imageUrl: "",
              placeName: "",
              playlistId: "1",
              hotelId: '12',
              cityId: '123',
              countryId: '1234',
              searchKey: ""),
          CarRecommendedLocationModel(
              imageUrl: "",
              placeName: "Thailand",
              playlistId: "2",
              hotelId: '12',
              cityId: '123',
              countryId: '1234',
              searchKey: ""),
          CarRecommendedLocationModel(
              imageUrl: "",
              placeName: "Singapore",
              playlistId: "3",
              hotelId: '12',
              cityId: '123',
              countryId: '1234',
              searchKey: "")
        ]));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
