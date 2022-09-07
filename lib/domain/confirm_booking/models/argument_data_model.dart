class HotelConfirmBookingArgumentModelDomain {
  String bookingUrn;
  String hotelId;
  bool bookingForSomeoneElse;
  String roomCode;
  String additionalNeedsText;
  double totalPrice;
  List<AddonDataDomain>? addOnServices;
  CustomerInfoDataDomain customerInfo;
  List<GuestInfoDataDomain>? guestInfo;
  HotelConfirmBookingArgumentModelDomain({
    required this.additionalNeedsText,
    required this.bookingForSomeoneElse,
    required this.bookingUrn,
    required this.hotelId,
    required this.roomCode,
    required this.totalPrice,
    this.addOnServices,
    required this.customerInfo,
    this.guestInfo,
  });
  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn.addQuote(),
        "hotelId": hotelId.addQuote(),
        if (addOnServices != null)
          "addOnServices":
              addOnServices!.map((result) => result.toMap()).toList(),
        "customerInfo": customerInfo.toMap(),
        "bookingForSomeoneElse": bookingForSomeoneElse,
        if (guestInfo != null)
          "guestInfo": guestInfo!.map((result) => result.toMap()).toList(),
        "roomCode": roomCode.addQuote(),
        "additionalNeedsText": additionalNeedsText.addQuote(),
        "totalPrice": totalPrice,
      };
}

class GuestInfoDataDomain {
  String firstName;
  String lastName;
  String? title;
  GuestInfoDataDomain(
      {required this.firstName, required this.lastName, this.title});
  Map<String, dynamic> toMap() => {
        "firstName": firstName.addQuote(),
        "lastName": lastName.addQuote(),
        if (title != null) "title": title!.addQuote(),
      };
}

class CustomerInfoDataDomain {
  String firstName;
  String lastName;
  String membershipId;
  CustomerInfoDataDomain(
      {required this.firstName,
      required this.lastName,
      required this.membershipId});
  Map<String, dynamic> toMap() => {
        "firstName": firstName.addQuote(),
        "lastName": lastName.addQuote(),
        "membershipId": membershipId.addQuote(),
      };
}

class AddonDataDomain {
  String price;
  String image;
  String description;
  String hotelServiceId;
  String hotelServiceName;
  String serviceDate;
  int quantity;
  bool isFlightRequired;
  AddonDataDomain({
    required this.description,
    required this.hotelServiceId,
    required this.hotelServiceName,
    required this.image,
    required this.isFlightRequired,
    required this.price,
    required this.quantity,
    required this.serviceDate,
  });
  Map<String, dynamic> toMap() => {
        "price": price.addQuote(),
        "image": image.addQuote(),
        "description": description.addQuote(),
        "hotelServiceId": hotelServiceId.addQuote(),
        "hotelServiceName": hotelServiceName.addQuote(),
        "serviceDate": serviceDate.addQuote(),
        "quantity": quantity,
        "isFlightRequired": isFlightRequired,
      };
}

extension StringQuote on String {
  String addQuote() {
    return '"${this}"';
  }
}
