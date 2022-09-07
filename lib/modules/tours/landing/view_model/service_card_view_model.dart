import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';

class ServiceCardViewModel {
  ServiceCardModel? tourServiceModel;
  ServiceCardModel? ticketServiceModel;
  ServiceCardPageState pageState;
  ServiceCardViewModel({
    this.tourServiceModel,
    this.ticketServiceModel,
    this.pageState = ServiceCardPageState.initial,
  });
}

class ServiceCardModel {
  String? imageTitle;
  String? imageUrl;
  String? title;
  String? description;
  String? deeplinkUrl;
  int? sortSequence;

  ServiceCardModel({
    this.imageTitle,
    this.imageUrl,
    this.title,
    this.description,
    this.deeplinkUrl,
    this.sortSequence,
  });

  ///Constructor That is used to map from the Domain level Model.
  ServiceCardModel.mapFromServiceCard(Ticket serviceCard) {
    imageTitle = serviceCard.imageTitle;
    title = serviceCard.title;
    imageUrl = serviceCard.imageUrl;
    description = serviceCard.description;
    deeplinkUrl = serviceCard.deeplinkUrl;
    sortSequence = serviceCard.sortSeq;
  }
}

enum ServiceCardPageState {
  initial,
  loading,
  success,
  failure,
  failure1899,
  failure1999,
  internetFailure,
}
