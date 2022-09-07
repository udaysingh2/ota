import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/landing/view/widgets/service_cards_widget.dart';
import 'package:ota/modules/tours/landing/view_model/service_card_view_model.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  ServiceCardModel ticketServiceModel = ServiceCardModel(
    imageUrl:
        "https://static-dev.alp-robinhood.com/ota/serviceCard/image/ticket.jpg",
    title: "ตั๋วกิจกรรมหลากหลาย",
    imageTitle: "ตั๋วกิจกรรม",
    description: "1000+ ผู้ให้บริการ",
    deeplinkUrl: "https://robinhood/",
  );
  ServiceCardModel tourServiceModel = ServiceCardModel(
    imageTitle: "ทัวร์",
    imageUrl:
        "https://static-dev.alp-robinhood.com/ota/serviceCard/image/tour.jpg",
    title: "เดย์ทัวร์และเพคเกจทัวร์",
    description: "3,000+ ผู้ให้บริการ",
    deeplinkUrl: "https://robinhood/",
  );

  tourServiceFun() {}

  testWidgets('Service Card Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(ServiceCardsWidget(
      onTicketServicePress: tourServiceFun,
      ticketService: ticketServiceModel,
      tourService: tourServiceModel,
      onTourServicePress: tourServiceFun,
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(ServiceCardsWidget), findsOneWidget);
  });
}
