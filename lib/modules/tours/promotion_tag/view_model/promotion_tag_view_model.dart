import 'package:ota/domain/tickets/confirm_booking/models/ticket_confirm_booking_model_domain.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_models.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart';
import 'package:ota/domain/tours/confirm_booking/models/tour_confirm_booking_model_domain.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_models.dart';
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart';

class PromotionTagViewModel {
  PromotionTagViewModel({
    this.productType,
    this.promotionCode,
    this.title,
    this.description,
    this.web,
  });

  final String? productType;
  final String? promotionCode;
  final String? title;
  final String? description;
  final String? web;

  factory PromotionTagViewModel.fromTourDetailPromotionList(
      TourDetailPromotionList listItem) {
    return PromotionTagViewModel(
      productType: listItem.productType,
      promotionCode: listItem.promotionCode,
      title: listItem.title,
      description: listItem.description,
      web: listItem.web,
    );
  }

  factory PromotionTagViewModel.fromTicketDetailPromotionList(
      TicketDetailPromotionList listItem) {
    return PromotionTagViewModel(
      productType: listItem.productType,
      promotionCode: listItem.promotionCode,
      title: listItem.title,
      description: listItem.description,
      web: listItem.web,
    );
  }
  factory PromotionTagViewModel.fromTourReservationPromotionList(
      TourReservationPromotionList listItem) {
    return PromotionTagViewModel(
      productType: listItem.productType,
      promotionCode: listItem.promotionCode,
      title: listItem.title,
      description: listItem.description,
      web: listItem.web,
    );
  }

  factory PromotionTagViewModel.fromTicketReservationPromotionList(
      TicketReservationPromotionList listItem) {
    return PromotionTagViewModel(
      productType: listItem.productType,
      promotionCode: listItem.promotionCode,
      title: listItem.title,
      description: listItem.description,
      web: listItem.web,
    );
  }

  factory PromotionTagViewModel.fromTicketConfirmationPromotionList(
      TicketConfirmationPromotionList listItem) {
    return PromotionTagViewModel(
      productType: listItem.productType,
      promotionCode: listItem.promotionCode,
      title: listItem.title,
      description: listItem.description,
      web: listItem.web,
    );
  }

  factory PromotionTagViewModel.fromTourConfirmationPromotionList(
      TourConfirmationPromotionList listItem) {
    return PromotionTagViewModel(
      productType: listItem.productType,
      promotionCode: listItem.promotionCode,
      title: listItem.title,
      description: listItem.description,
      web: listItem.web,
    );
  }

  factory PromotionTagViewModel.fromTourBookingDetailPromotionList(
      TourBookingDetailPromotionList listItem) {
    return PromotionTagViewModel(
      productType: listItem.productType,
      promotionCode: listItem.promotionCode,
      title: listItem.title,
      description: listItem.description,
      web: listItem.web,
    );
  }

  factory PromotionTagViewModel.fromTicketBookingDetailPromotionList(
      TicketBookingDetailPromotionList listItem) {
    return PromotionTagViewModel(
      productType: listItem.productType,
      promotionCode: listItem.promotionCode,
      title: listItem.title,
      description: listItem.description,
      web: listItem.web,
    );
  }
}
