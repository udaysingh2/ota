class CarPaymentDomainArgumentModel {
  String? bookingUrn;
  List<AddonDataDomain>? addOnServices;
  String? additionalNeedsText;
  CustomerInfoDataDomain? customerInfo;
  DriverInfoDataDomain? driverInfo;
  GuestInfoDataDomain? guestInfo;
  String? rateKey;
  String? refCode;
  double? totalPrice;
  CarPaymentDomainArgumentModel(
      {this.additionalNeedsText,
      this.bookingUrn,
      this.totalPrice,
      this.addOnServices,
      this.customerInfo,
      this.guestInfo,
      this.rateKey,
      this.refCode,
      this.driverInfo});

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn?.addQuote(),
        if (addOnServices != null)
          "addOnServices":
              addOnServices!.map((result) => result.toMap()).toList(),
        "customerInfo": customerInfo?.toMap(),
        "guestInfo": guestInfo?.toMap(),
        "additionalNeedsText": additionalNeedsText?.addQuote(),
        "totalPrice": totalPrice,
        "rateKey": rateKey?.addQuote(),
        "refCode": refCode?.addQuote(),
        "driverInfo": driverInfo?.toMap(),
      };
}

class AddonDataDomain {
  String chargeType;
  String serviceId;
  bool? isCompulsory;
  String name;
  String price;
  int quantity;
  AddonDataDomain({
    this.isCompulsory,
    required this.chargeType,
    required this.name,
    required this.serviceId,
    required this.price,
    required this.quantity,
  });
  Map<String, dynamic> toMap() => {
        "price": price.addQuote(),
        "chargeType": chargeType.addQuote(),
        "serviceId": serviceId.addQuote(),
        "quantity": quantity,
        "isCompulsory": isCompulsory,
        "name": name.addQuote(),
      };
}

class DriverInfoDataDomain {
  String age;
  String dateOfBirth;
  String driverLicenseNumber;
  String email;
  String firstName;
  String flightNumber;
  String lastName;
  String middleName;
  String nationalityId;
  String prefixId;
  String telephone;

  DriverInfoDataDomain({
    required this.age,
    required this.dateOfBirth,
    required this.driverLicenseNumber,
    required this.email,
    required this.firstName,
    required this.flightNumber,
    required this.lastName,
    required this.middleName,
    required this.nationalityId,
    required this.prefixId,
    required this.telephone,
  });
  Map<String, dynamic> toMap() => {
        "age": age.addQuote(),
        "dateOfBirth": dateOfBirth.addQuote(),
        "driverLicenseNumber": driverLicenseNumber.addQuote(),
        "email": email.addQuote(),
        "firstName": firstName.addQuote(),
        "flightNumber": flightNumber.addQuote(),
        "lastName": lastName.addQuote(),
        "middleName": middleName.addQuote(),
        "nationalityId": nationalityId.addQuote(),
        "prefixId": prefixId.addQuote(),
        "telephone": telephone.addQuote(),
      };
}

class CustomerInfoDataDomain {
  String? emailId;
  String firstName;
  String lastName;
  String? phoneNumber;
  CustomerInfoDataDomain(
      {this.emailId,
      required this.lastName,
      required this.firstName,
      this.phoneNumber});
  Map<String, dynamic> toMap() => {
        "firstName": firstName.addQuote(),
        "lastName": lastName.addQuote(),
        "emailId": emailId,
        "phoneNumber": phoneNumber,
      };
}

class GuestInfoDataDomain {
  String firstName;
  String lastName;
  String phoneNumber;
  GuestInfoDataDomain(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber});
  Map<String, dynamic> toMap() => {
        "firstName": firstName.addQuote(),
        "lastName": lastName.addQuote(),
        "phoneNumber": phoneNumber.addQuote(),
      };
}

extension StringQuote on String {
  String addQuote() {
    return '"${this}"';
  }
}
