import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota/view/widgets/ota_ammenities_widget.dart';

import '../../../../../helper.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Ota Amenities Widget Test false defaultSvg', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(const OtaSuggestionCardAmenities(
      headerText: 'headerText',
      placeholderImage: 'assets/images/illustrations/car_list_placeholder.png',
      description: 'description',
      offerPercent: 'offerPercent',
      isDefaultSvg: false,
      adminPromotionLine1: 'adminPromotionLine1',
      adminPromotionLine2: 'adminPromotionLine2',
      amenitiesList: ['amenitiesList', 'amenitiesList', 'amenitiesList'],
    )));
    await tester.pumpAndSettle();
  });
  testWidgets('Ota Amenities Widget Test true defaultSvg', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(const OtaSuggestionCardAmenities(
      headerText: 'headerText',
      description: 'description',
      offerPercent: 'offerPercent',
      adminPromotionLine1: 'adminPromotionLine1',
      adminPromotionLine2: 'adminPromotionLine2',
      isInHorizontalScroll: false,
      amenitiesList: ['amenitiesList', 'amenitiesList', 'amenitiesList'],
    )));
    await tester.pumpAndSettle();
  });
}
