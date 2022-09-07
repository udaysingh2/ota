import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_recommended_locations_widget.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/recommended_location_view_model.dart';

import '../../../../../helper.dart';

const _kImageUrl =
    'https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg';

void main() {
  testWidgets("Hotel Recommendation Widget Test", (tester) async {
    Widget widget = getMaterialWrapper(HotelRecommendedLocationsWidget(
        recommendedLocationTitle: 'Recommended Locations',
        recommendedLocationList: [
          RecommendedLocationModel(
              imageUrl: "",
              placeName: "",
              playlistId: "1",
              hotelId: '12',
              cityId: '123',
              countryId: '1234',
              searchKey: ""),
          RecommendedLocationModel(
              imageUrl: _kImageUrl,
              placeName: "Thailand",
              playlistId: "2",
              hotelId: '12',
              cityId: '123',
              countryId: '1234',
              searchKey: ""),
          RecommendedLocationModel(
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
  });

  testWidgets("Hotel Recommendation Widget Test without Image", (tester) async {
    Widget widget = getMaterialWrapper(HotelRecommendedLocationsWidget(
        recommendedLocationTitle: 'Recommended Locations',
        recommendedLocationList: [
          RecommendedLocationModel(
              imageUrl: "",
              placeName: "",
              playlistId: "1",
              hotelId: '12',
              cityId: '123',
              countryId: '1234',
              searchKey: ""),
          RecommendedLocationModel(
              imageUrl: "",
              placeName: "Thailand",
              playlistId: "2",
              hotelId: '12',
              cityId: '123',
              countryId: '1234',
              searchKey: ""),
          RecommendedLocationModel(
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
