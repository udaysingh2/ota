import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/tickets/confirm_booking/models/ticket_confirm_booking_model_domain.dart';
import 'package:ota/modules/tickets/confirm_booking/helper/ticket_confirm_booking_helper.dart';

const String _kDefaultNumberOfDays = "1";
const double _kDefaultAmount = 0;

class TicketConfirmBookingModel {
  final String bookingUrn;
  final String ticketId;
  final String cityId;
  final String countryId;
  final DateTime bookingDate;
  final String ticketName;
  final String packageName;
  final List<TicketTypeViewModel> ticketList;
  final double totalAmount;
  final double totalFees;
  final double totalTax;
  final double totalDiscount;
  double promoDiscount;
  // final double netPrice;
  final String noOfDays;
  final TicketCustomerInfoViewModel customerInfo;
  final List<TicketParticipantInfoViewModel>? participantList;
  final String? startTime;
  final String? location;
  final String? category;
  final List<TicketHighlightViewModel>? ticketHighLights;
  final String? ticketImageUrl;
  final String? cancellationPolicy;
  final String? durationText;
  final String? cancellationHeader;
  final bool showTravellerInformation;
  final List<OtaFreeFoodPromotionModel> promotionData;

  TicketConfirmBookingModel({
    required this.bookingUrn,
    required this.ticketId,
    required this.cityId,
    required this.countryId,
    required this.bookingDate,
    required this.ticketName,
    required this.packageName,
    required this.ticketList,
    required this.totalAmount,
    required this.totalFees,
    required this.totalTax,
    required this.totalDiscount,
    this.promoDiscount = 0.0,
    // required this.netPrice,
    required this.noOfDays,
    required this.customerInfo,
    required this.showTravellerInformation,
    required this.promotionData,
    this.startTime,
    this.participantList,
    this.ticketHighLights,
    this.location,
    this.category,
    this.ticketImageUrl,
    this.cancellationPolicy,
    this.durationText,
    this.cancellationHeader,
  });

  factory TicketConfirmBookingModel.mapFromTicketData(
          Data data, bool? showTravllerInformation) =>
      TicketConfirmBookingModel(
        bookingUrn: data.bookingUrn!,
        ticketId: data.ticketId!,
        cityId: data.cityId!,
        countryId: data.countryId!,
        bookingDate: Helpers().parseDateTime(data.bookingDate!),
        ticketName: data.name!,
        ticketImageUrl: data.image,
        location: data.location,
        category: data.category,
        promoDiscount: 0.0,
        packageName: data.packageDetail!.name!,
        ticketHighLights: TicketConfirmBookingHelper.getTicketHighLightList(
            data.packageDetail!),
        totalAmount: data.totalAmount!,
        totalFees: data.totalFees ?? _kDefaultAmount,
        totalTax: data.totalTaxes ?? _kDefaultAmount,
        totalDiscount: data.totalDiscount ?? _kDefaultAmount,
        // netPrice: TicketConfirmBookingHelper.getTotalPrice(data.totalAmount!,
        //     data.totalFees, data.totalTaxes, data.totalDiscount),
        noOfDays: data.noOfDays ?? _kDefaultNumberOfDays,
        customerInfo:
            TicketCustomerInfoViewModel.fromCustomerInfo(data.customerInfo!),
        participantList: TicketConfirmBookingHelper.getParticipantInfoList(
            data.participantInfo),
        cancellationPolicy: data.packageDetail!.cancellationPolicy,
        durationText: data.packageDetail!.durationText,
        startTime: data.startTimeAMPM,
        cancellationHeader: TicketConfirmBookingHelper.getCancellationHeader(
            TicketConfirmBookingHelper.getTicketHighLightList(
                data.packageDetail!)),
        showTravellerInformation: showTravllerInformation ?? false,
        ticketList: List.generate(
            data.packageDetail!.ticketTypes!.length,
            (index) => TicketTypeViewModel.mapFromTicketType(
                data.packageDetail!.ticketTypes!.elementAt(index))),
        promotionData:
            TicketConfirmBookingHelper.generatePromotion(data.promotionList),
      );

  double getTotalPrice() {
    double totalPrice = totalAmount + totalFees + totalTax - promoDiscount;
    if (totalPrice >= 0) {
      return totalPrice;
    } else {
      return 0.0;
    }
  }

  double getWalletAmountTobeDeducted(double balance) {
    double totalValueAfterPromoApplied = getTotalPrice();
    if (balance > 0) {
      if (balance >= totalValueAfterPromoApplied) {
        return totalValueAfterPromoApplied;
      } else if (balance < totalValueAfterPromoApplied) {
        return balance;
      }
    }
    return 0.0;
  }

  double getGrandTotalWithWalletApplied(bool walletState, double balance) {
    double totalAmount = getTotalPrice();
    double walletAmount = getWalletAmountTobeDeducted(balance);
    if (totalAmount >= 0 && walletState) {
      return totalAmount - walletAmount;
    } else {
      return totalAmount;
    }
  }
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

  factory TicketTypeViewModel.mapFromTicketType(TicketType ticket) =>
      TicketTypeViewModel(
        paxId: ticket.paxId!,
        name: ticket.name!,
        price: ticket.price!,
        noOfTickets: ticket.noOfTickets ?? 0,
      );
}

class TicketParticipantInfoViewModel {
  TicketParticipantInfoViewModel({
    this.paxId,
    this.name,
    this.surname,
    this.weight,
    this.dateOfBirth,
    this.passportCountry,
    this.passportNumber,
    this.passportCountryIssue,
    this.expiryDate,
  });

  final String? paxId;
  final String? name;
  final String? surname;
  final String? weight;
  final String? dateOfBirth;
  final String? passportCountry;
  final String? passportNumber;
  final String? passportCountryIssue;
  final String? expiryDate;

  factory TicketParticipantInfoViewModel.fromParticipantInfo(
          ParticipantInfo info) =>
      TicketParticipantInfoViewModel(
        paxId: info.paxId,
        name: info.name,
        surname: info.surname,
        weight: info.weight,
        dateOfBirth: info.dateOfBirth,
        passportCountry: info.passportCountry,
        passportNumber: info.passportNumber,
        passportCountryIssue: info.passportCountryIssue,
        expiryDate: info.expiryDate,
      );
}

class TicketCustomerInfoViewModel {
  TicketCustomerInfoViewModel({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;

  factory TicketCustomerInfoViewModel.fromCustomerInfo(CustomerInfo info) =>
      TicketCustomerInfoViewModel(
        email: info.email,
        firstName: info.firstName,
        lastName: info.lastName,
        phoneNumber: info.phoneNumber,
      );
}

class TicketHighlightViewModel {
  String? key;
  String? value;
  TicketHighlightViewModel.mapFromTicketHighlight(Highlight? highlight) {
    if (highlight?.key != null && highlight?.value != null) {
      key = highlight?.key;
      value = highlight?.value;
    }
  }
}
