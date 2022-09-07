import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/landing/view_model/service_card_view_model.dart';

void main() {
  test('Service card ViewModel', () {
    ServiceCardModel serviceViewModel = ServiceCardModel(
      imageUrl:
          "https://static-dev.alp-robinhood.com/ota/serviceCard/image/ticket.jpg",
      title: "ตั๋วกิจกรรมหลากหลาย",
      imageTitle: "ตั๋วกิจกรรม",
      description: "1000+ ผู้ให้บริการ",
      deeplinkUrl: "https://robinhood/",
    );

    ServiceCardViewModel otaBookingCalendarViewModel = ServiceCardViewModel(
      pageState: ServiceCardPageState.success,
      ticketServiceModel: serviceViewModel,
      tourServiceModel: serviceViewModel,
    );
    expect(otaBookingCalendarViewModel.pageState, ServiceCardPageState.success);
  });
}
