import 'ota_reservation_success_argument_model.dart';

class OtaReservationSuccessViewModel {
  OtaReservationDetailModel otaReservationDetailModel;
  List<OtaResrvationServiceCardViewModel> otaResrvationServiceCardViewModel;

  OtaReservationSuccessViewModel({
    required this.otaResrvationServiceCardViewModel,
    required this.otaReservationDetailModel,
  });
}

class OtaResrvationServiceCardViewModel {
  final String? serviceText;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? largeImageUrl;
  final String? serviceBackgroundUrl;
  final String? service;
  final String? deeplinkUrl;

  OtaResrvationServiceCardViewModel({
    this.serviceText,
    this.title,
    this.description,
    this.imageUrl,
    this.largeImageUrl,
    this.serviceBackgroundUrl,
    this.service,
    this.deeplinkUrl,
  });
}

class OtaReservationDetailModel {
  String? id;
  String? imageUrl;
  String? providerName;
  String? packageName;
  List<Highlights>? highlights;
  List<TourOrTicketsType>? tourOrTicketsType;
  DateTime? bookingDate;
  int? noOfDays;
  String? activityDuration;
  int? adultCount;
  int? childCount;
  String? referenceId;

  OtaReservationDetailModel({
    required this.id,
    this.imageUrl,
    this.providerName,
    this.packageName,
    this.highlights,
    this.tourOrTicketsType,
    this.bookingDate,
    this.noOfDays,
    this.activityDuration,
    this.adultCount,
    this.childCount,
    this.referenceId,
  });
}
