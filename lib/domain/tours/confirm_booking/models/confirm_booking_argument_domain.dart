const String _kTourString = "TOUR";

class ConfirmBookingArgumentDomain {
  final String bookingUrn;
  final String bookingType;
  final String serviceId;
  final String noOfDays;
  final bool isBookingForSomeoneElse;
  final double totalPrice;
  final CustomerInfoArgument customerInfoArgument;
  final String? additionalNeedText;
  final PickupArgument? pickupArgument;
  final List<GuestInfoArgument>? guestInfoList;

  ConfirmBookingArgumentDomain({
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
  });

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn.addQuote(),
        "bookingType": bookingType.addQuote(),
        if (bookingType == _kTourString) "tourId": serviceId.addQuote(),
        if (bookingType != _kTourString) "ticketId": serviceId.addQuote(),
        if (additionalNeedText != null && additionalNeedText!.isNotEmpty)
          "additionalNeedsText": additionalNeedText!.addQuote(),
        "noOfDays": noOfDays.addQuote(),
        "customerInfo": customerInfoArgument.toMap(),
        "isBookingForSomeoneElse": isBookingForSomeoneElse,
        if (pickupArgument != null) "pickUp": pickupArgument!.toMap(),
        if (guestInfoList != null && guestInfoList!.isNotEmpty)
          "guestInfo": guestInfoList!.map((result) => result.toMap()).toList(),
        "totalPrice": totalPrice,
      };
}

class CustomerInfoArgument {
  final String email;
  final String firstName;
  final String lastName;
  final String mobileNumber;

  CustomerInfoArgument({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
  });

  Map<String, dynamic> toMap() => {
        "email": email.addQuote(),
        "firstName": firstName.addQuote(),
        "lastName": lastName.addQuote(),
        "phoneNumber": mobileNumber.addQuote(),
      };
}

class PickupArgument {
  final String name;
  final String id;

  PickupArgument({
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toMap() => {
        "id": id.addQuote(),
        "name": name.addQuote(),
      };
}

class GuestInfoArgument {
  final String name;
  final String surname;
  final String? paxId;
  final String? weight;
  final String? dateOfBirth;
  final String? passportCountry;
  final String? passportNumber;
  final String? passportCountryIssue;
  final String? expiryDate;

  GuestInfoArgument({
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

  Map<String, dynamic> toMap() => {
        if (paxId != null) "paxId": paxId!.addQuote(),
        "name": name.addQuote(),
        "surname": surname.addQuote(),
        if (weight != null && weight!.isNotEmpty) "weight": weight!.addQuote(),
        if (dateOfBirth != null && dateOfBirth!.isNotEmpty)
          "dateOfBirth": dateOfBirth!.addQuote(),
        if (passportCountry != null && passportCountry!.isNotEmpty)
          "passportCountry": passportCountry!.addQuote(),
        if (passportNumber != null && passportNumber!.isNotEmpty)
          "passportNumber": passportNumber!.addQuote(),
        if (passportCountryIssue != null && passportCountryIssue!.isNotEmpty)
          "passportCountryIssue": passportCountryIssue!.addQuote(),
        if (expiryDate != null && expiryDate!.isNotEmpty)
          "expiryDate": expiryDate!.addQuote(),
      };
}

extension StringQuote on String {
  String addQuote() {
    return "\"${this}\"";
  }
}
