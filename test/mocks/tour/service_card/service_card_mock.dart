import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';
import 'package:ota/modules/tours/landing/view_model/service_card_view_model.dart';

ServiceCardModelDomain getServiceCardDataMock() {
  return ServiceCardModelDomain(
    getTourServiceCards: null,
  );
}

ServiceCardModel getServiceCardMock() {
  return ServiceCardModel(
    imageUrl:
        "https://static-dev.alp-robinhood.com/ota/serviceCard/image/ticket.jpg",
    title: "ตั๋วกิจกรรมหลากหลาย",
    imageTitle: "ตั๋วกิจกรรม",
    description: "1000+ ผู้ให้บริการ",
    deeplinkUrl: "https://robinhood/",
  );
}
