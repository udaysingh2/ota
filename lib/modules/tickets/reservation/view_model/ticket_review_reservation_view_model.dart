import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_models.dart';
import 'package:ota/modules/tickets/reservation/helper/ticket_reservation_helper.dart';

class TicketReviewReservationViewModel {
  TicketReviewReservationViewModel({
    required this.bookingUrn,
    required this.ticketName,
    required this.ticketImage,
    required this.ticketId,
    required this.totalPrice,
    required this.lastPrice,
    required this.totalSelectedTicket,
    this.ticketPackage,
    this.location,
    this.category,
    required this.promotionData,
  });

  final String bookingUrn;
  final String ticketName;
  final String ticketImage;
  final String ticketId;
  final double totalPrice;
  double lastPrice;
  final int totalSelectedTicket;
  final TicketPackageViewModel? ticketPackage;
  final String? location;
  final String? category;
  final List<OtaFreeFoodPromotionModel> promotionData;

  factory TicketReviewReservationViewModel.fromData(
          {required Data data,
          required double totalPrice,
          required List<TicketReservationPromotionList> promotionList}) =>
      TicketReviewReservationViewModel(
        bookingUrn: data.bookingUrn!,
        ticketName: data.ticketName!,
        ticketImage: data.ticketImage!,
        ticketId: data.ticketDetails!.id!,
        totalPrice: TicketReservationHelper.getTotalPrice(
            TicketReservationHelper.getFirstPackage(data.ticketDetails!)),
        lastPrice: totalPrice,
        totalSelectedTicket: TicketReservationHelper.getTotalSelectedTickets(
            TicketReservationHelper.getFirstPackage(data.ticketDetails!)),
        ticketPackage: TicketReservationHelper.getPackage(
            TicketReservationHelper.getFirstPackage(data.ticketDetails!)),
        location: data.ticketDetails?.location,
        category: data.ticketDetails?.category,
        promotionData: TicketReservationHelper.generatePromotion(promotionList),
      );
}

class TicketPackageViewModel {
  TicketPackageViewModel({
    this.name,
    this.ticketHighlights,
    this.cancellationPolicy,
    this.cancellationHeader,
    this.currency,
    this.refCode,
    this.serviceId,
    this.rateKey,
    this.durationText,
    this.duration,
    this.zoneId,
    this.requireInfo,
    this.ticketTypeList,
  });

  final String? name;
  final List<TicketHighlight>? ticketHighlights;
  final String? cancellationPolicy;
  final String? cancellationHeader;
  final String? currency;
  final String? refCode;
  final String? serviceId;
  final String? rateKey;
  final String? durationText;
  final String? duration;
  final String? zoneId;
  final TicketRequireInfoViewModel? requireInfo;
  final List<TicketTypeViewModel>? ticketTypeList;

  factory TicketPackageViewModel.fromPackage(Package package) =>
      TicketPackageViewModel(
        name: package.name,
        ticketHighlights: TicketReservationHelper.getHighlights(package),
        cancellationPolicy: package.cancellationPolicy,
        cancellationHeader: TicketReservationHelper.getCancellationHeader(
            TicketReservationHelper.getHighlights(package)),
        currency: package.currency,
        refCode: package.refCode,
        serviceId: package.serviceId,
        rateKey: package.rateKey,
        durationText: package.durationText,
        //Fixed no of days to 1 as part of OTA-4182. Should be updated once this featured is implemented.
        duration: "1",
        zoneId: package.zoneId,
        requireInfo: TicketRequireInfoViewModel.fromRequiredInfoModel(
            package.requireInfo),
        ticketTypeList: TicketReservationHelper.getTicketTypeList(package),
      );
}

class TicketHighlight {
  TicketHighlight({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory TicketHighlight.fromHighLight(Highlight? highlight) =>
      TicketHighlight(
        key: highlight?.key,
        value: highlight?.value,
      );
}

class TicketTypeViewModel {
  final String paxId;
  final String name;
  final double price;
  final int noOfTickets;

  TicketTypeViewModel({
    required this.paxId,
    required this.name,
    required this.price,
    required this.noOfTickets,
  });

  factory TicketTypeViewModel.mapWithTicketType(TicketType ticketType) =>
      TicketTypeViewModel(
          paxId: ticketType.paxId!,
          name: ticketType.name!,
          price: ticketType.price ?? 0,
          noOfTickets: ticketType.noOfTickets ?? 0);
}

class TicketRequireInfoViewModel {
  TicketRequireInfoViewModel({
    this.weight,
    this.allName,
    this.guestName,
    this.passportId,
    this.dateOfBirth,
    this.passportCountry,
    this.passportValidDate,
    this.passportCountryIssue,
  });

  final bool? weight;
  final bool? allName;
  final bool? guestName;
  final bool? passportId;
  final bool? dateOfBirth;
  final bool? passportCountry;
  final bool? passportValidDate;
  final bool? passportCountryIssue;

  factory TicketRequireInfoViewModel.fromRequiredInfoModel(
          RequireInfo? requireInfo) =>
      TicketRequireInfoViewModel(
        weight: requireInfo?.weight,
        allName: requireInfo?.allName,
        guestName: requireInfo?.guestName,
        passportId: requireInfo?.passportId,
        dateOfBirth: requireInfo?.dateOfBirth,
        passportCountry: requireInfo?.passportCountry,
        passportValidDate: requireInfo?.passportValidDate,
        passportCountryIssue: requireInfo?.passportCountryIssue,
      );
}
