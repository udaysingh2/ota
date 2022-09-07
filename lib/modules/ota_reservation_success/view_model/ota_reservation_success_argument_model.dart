import 'package:ota/modules/ota_reservation_success/bloc/ota_reservation_success_bloc.dart';

class OtaReservationSuccessArgumentModel {
  ServiceCardType? serviceCardType;
  String? id;
  bool? bookingForTicket;
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

  OtaReservationSuccessArgumentModel({
    this.id,
    this.serviceCardType,
    this.bookingForTicket,
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

  void getFromProvider(OtaReservationSuccessArgumentModel argumentModel) {
    id = argumentModel.id;
    serviceCardType = argumentModel.serviceCardType;
    bookingForTicket = argumentModel.bookingForTicket;
    imageUrl = argumentModel.imageUrl;
    providerName = argumentModel.providerName;
    packageName = argumentModel.packageName;
    highlights = argumentModel.highlights;
    tourOrTicketsType = argumentModel.tourOrTicketsType;
    bookingDate = argumentModel.bookingDate;
    noOfDays = argumentModel.noOfDays;
    activityDuration = argumentModel.activityDuration;
    adultCount = argumentModel.adultCount;
    childCount = argumentModel.childCount;
    referenceId = argumentModel.referenceId;
  }
}

class Highlights {
  Highlights({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;
}

class TourOrTicketsType {
  TourOrTicketsType({
    this.name,
    this.price,
    this.count,
    this.minAge,
    this.maxAge,
  });

  final String? name;
  final double? price;
  final int? count;
  final int? minAge;
  final int? maxAge;
}
