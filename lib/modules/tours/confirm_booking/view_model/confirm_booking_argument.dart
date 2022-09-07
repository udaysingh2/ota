import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/userdetail_view_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_guest_information_argument_model.dart';
import 'package:ota/modules/tours/reservation/view_model/guest_information_argument_model.dart';

class ConfirmBookingArgument {
  final String bookingUrn;
  final String bookingType;
  final String serviceId;
  final String noOfDays;
  final bool isBookingForSomeoneElse;
  final double totalPrice;
  final CustomerInfoData customerInfoArgument;
  final String? additionalNeedText;
  final Pickup? pickupArgument;
  final List<GuestInfo>? guestInfoList;
  final bool? isAdditionalGuestAvailable;

  ConfirmBookingArgument({
    required this.bookingUrn,
    required this.bookingType,
    required this.serviceId,
    required this.noOfDays,
    required this.isBookingForSomeoneElse,
    required this.totalPrice,
    required this.customerInfoArgument,
    this.additionalNeedText,
    this.pickupArgument,
    this.guestInfoList,
    this.isAdditionalGuestAvailable,
  });

  ConfirmBookingArgumentDomain toConfirmBookingArgumentDomain() {
    return ConfirmBookingArgumentDomain(
      bookingUrn: bookingUrn,
      bookingType: bookingType,
      additionalNeedText: additionalNeedText,
      customerInfoArgument: customerInfoArgument.toCustomerInfoArgument(),
      isBookingForSomeoneElse: isBookingForSomeoneElse,
      noOfDays: noOfDays,
      serviceId: serviceId,
      totalPrice: totalPrice,
      guestInfoList: List.generate(guestInfoList?.length ?? 0,
          (index) => guestInfoList![index].toGuestInfoArgument()),
      pickupArgument: pickupArgument?.toPickupArgument(),
    );
  }
}

class CustomerInfoData {
  final String email;
  final String firstName;
  final String lastName;
  final String mobileNumber;

  CustomerInfoData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
  });

  CustomerInfoArgument toCustomerInfoArgument() {
    return CustomerInfoArgument(
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobileNumber: mobileNumber,
    );
  }

  factory CustomerInfoData.mapFromUserDetail(
          UserDetailViewModel userDetailViewModel) =>
      CustomerInfoData(
        email: userDetailViewModel.email,
        firstName: userDetailViewModel.firstName,
        lastName: userDetailViewModel.secondName,
        mobileNumber: userDetailViewModel.mobileNumber,
      );
}

class Pickup {
  final String name;
  final String id;

  Pickup({
    required this.name,
    required this.id,
  });

  PickupArgument toPickupArgument() {
    return PickupArgument(
      name: name,
      id: id,
    );
  }
}

class GuestInfo {
  final String name;
  final String surname;
  final String? paxId;
  final String? weight;
  final String? dateOfBirth;
  final String? passportCountry;
  final String? passportNumber;
  final String? passportCountryIssue;
  final String? expiryDate;

  GuestInfo({
    required this.name,
    required this.surname,
    this.paxId,
    this.weight,
    this.dateOfBirth,
    this.passportCountry,
    this.passportNumber,
    this.passportCountryIssue,
    this.expiryDate,
  });

  GuestInfoArgument toGuestInfoArgument() {
    return GuestInfoArgument(
      paxId: paxId,
      name: name,
      surname: surname,
      dateOfBirth: dateOfBirth,
      expiryDate: expiryDate,
      passportCountry: passportCountry,
      passportCountryIssue: passportCountryIssue,
      passportNumber: passportNumber,
      weight: weight,
    );
  }

  factory GuestInfo.mapFromGuestInformationData(
          GuestInformationData guestData) =>
      GuestInfo(
        paxId: guestData.paxId!,
        name: guestData.guestFirstName,
        surname: guestData.guestLastName,
        dateOfBirth: Helpers.getYYYYmmddFromDateTime(guestData.selectedDob),
        weight: guestData.guestWeight,
        passportCountry: guestData.selectedPassportCountry,
        passportNumber: guestData.guestPassportId,
        passportCountryIssue: guestData.selectedPassportIssuingCountry,
        expiryDate: Helpers.getYYYYmmddFromDateTime(
            guestData.selectedPassportValidityDate),
      );

  factory GuestInfo.mapFromTicketGuestInformationData(
          TicketGuestInformationData guestData) =>
      GuestInfo(
        name: guestData.guestFirstName,
        surname: guestData.guestLastName,
        dateOfBirth: Helpers.getYYYYmmddFromDateTime(guestData.selectedDob),
        weight: guestData.guestWeight,
        passportCountry: guestData.selectedPassportCountry,
        passportNumber: guestData.guestPassportId,
        passportCountryIssue: guestData.selectedPassportIssuingCountry,
        expiryDate: Helpers.getYYYYmmddFromDateTime(
            guestData.selectedPassportValidityDate),
      );
}
