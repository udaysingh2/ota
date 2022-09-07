import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/top_detail_section.dart';
import '../../../../../helper/material_wrapper.dart';

void main(){
  group("Ota top detail Section Widget", () {
  testWidgets('Ota top detail Section Widget', (tester) async {
    Widget widget = getMaterialWrapper(const OtaTopDetailsSection(
      title: "SEA LIFE Bangkok Ocean World",
      serviceType: "tour",
      categoryName: "พิพิธภัณฑ์",
      categoryLocation: "เมือง, กรุงเทพ",
      imageUrl: "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
      subTitle: "subTitle",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets('Ota top detail Section Widget', (tester) async {
    Widget widget = getMaterialWrapper(const OtaTopDetailsSection(
      title: "SEA LIFE Bangkok Ocean World",
      serviceType: "ticket",
      categoryLocation: "เมือง, กรุงเทพ",
      imageUrl: "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
      subTitle: "subTitle",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets('Ota top detail Section Widget', (tester) async {
    Widget widget = getMaterialWrapper(const OtaTopDetailsSection(
      title: "SEA LIFE Bangkok Ocean World",
      serviceType: "tour",
      categoryName: "พิพิธภัณฑ์",
      imageUrl: "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
      subTitle: "subTitle",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  });
}