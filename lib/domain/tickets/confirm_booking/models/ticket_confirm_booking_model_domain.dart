import 'dart:convert';

class TicketConfirmBookingModelDomain {
  TicketConfirmBookingModelDomain({
    this.getTicketBookingConfirmation,
  });

  final GetTicketBookingConfirmation? getTicketBookingConfirmation;

  factory TicketConfirmBookingModelDomain.fromJson(String str) =>
      TicketConfirmBookingModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketConfirmBookingModelDomain.fromMap(Map<String, dynamic> json) =>
      TicketConfirmBookingModelDomain(
        getTicketBookingConfirmation:
            json["getTicketBookingConfirmation"] == null
                ? null
                : GetTicketBookingConfirmation.fromMap(
                    json["getTicketBookingConfirmation"]),
      );

  Map<String, dynamic> toMap() => {
        "getTicketBookingConfirmation": getTicketBookingConfirmation?.toMap(),
      };
}

class GetTicketBookingConfirmation {
  GetTicketBookingConfirmation({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTicketBookingConfirmation.fromJson(String str) =>
      GetTicketBookingConfirmation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTicketBookingConfirmation.fromMap(Map<String, dynamic> json) =>
      GetTicketBookingConfirmation(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class Data {
  Data({
    this.bookingUrn,
    this.ticketId,
    this.cityId,
    this.countryId,
    this.bookingDate,
    this.name,
    this.image,
    this.location,
    this.category,
    this.promotionList,
    this.packageDetail,
    this.totalAmount,
    this.totalFees,
    this.totalTaxes,
    this.totalDiscount,
    this.noOfDays,
    this.customerInfo,
    this.participantInfo,
    this.startTimeAMPM,
  });

  final String? bookingUrn;
  final String? ticketId;
  final String? cityId;
  final String? countryId;
  final String? bookingDate;
  final String? name;
  final String? image;
  final String? location;
  final String? category;
  final List<TicketConfirmationPromotionList>? promotionList;
  final PackageDetail? packageDetail;
  final double? totalAmount;
  final double? totalFees;
  final double? totalTaxes;
  final double? totalDiscount;
  final String? noOfDays;
  final CustomerInfo? customerInfo;
  final List<ParticipantInfo>? participantInfo;
  final String? startTimeAMPM;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        bookingUrn: json["bookingUrn"],
        ticketId: json["ticketId"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        bookingDate: json["bookingDate"],
        name: json["name"],
        image: json["image"],
        location: json["location"],
        category: json["category"],
        promotionList: json["promotionList"] == null
            ? null
            : List<TicketConfirmationPromotionList>.from(json["promotionList"]
                .map((x) => TicketConfirmationPromotionList.fromMap(x))),
        packageDetail: json["packageDetail"] == null
            ? null
            : PackageDetail.fromMap(json["packageDetail"]),
        totalAmount: json["totalAmount"]?.toDouble(),
        totalFees: json["totalFees"]?.toDouble(),
        totalTaxes: json["totalTaxes"]?.toDouble(),
        totalDiscount: json["totalDiscount"]?.toDouble(),
        noOfDays: json["noOfDays"],
        customerInfo: json["customerInfo"] == null
            ? null
            : CustomerInfo.fromMap(json["customerInfo"]),
        participantInfo: json["participantInfo"] == null
            ? null
            : List<ParticipantInfo>.from(
                json["participantInfo"].map((x) => ParticipantInfo.fromMap(x))),
        startTimeAMPM: json["startTimeAMPM"],
      );

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn,
        "ticketId": ticketId,
        "cityId": cityId,
        "countryId": countryId,
        "bookingDate": bookingDate,
        "name": name,
        "image": image,
        "location": location,
        "category": category,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
        "packageDetail": packageDetail?.toMap(),
        "totalAmount": totalAmount,
        "totalFees": totalFees,
        "totalTaxes": totalTaxes,
        "totalDiscount": totalDiscount,
        "noOfDays": noOfDays,
        "customerInfo": customerInfo?.toMap(),
        "participantInfo": participantInfo == null
            ? null
            : List<dynamic>.from(participantInfo!.map((x) => x.toMap())),
        "startTimeAMPM": startTimeAMPM,
      };
}

class TicketConfirmationPromotionList {
  TicketConfirmationPromotionList({
    this.productType,
    this.promotionCode,
    this.title,
    this.description,
    this.web,
    this.iconImage,
    this.bannerDescDisplay,
    this.line1,
    this.line2,
    this.productId,
    this.promotionType,
  });

  final String? productType;
  final String? promotionCode;
  final String? title;
  final String? description;
  final String? web;
  final String? iconImage;
  final bool? bannerDescDisplay;
  final String? line1;
  final String? line2;
  final String? productId;
  final String? promotionType;

  factory TicketConfirmationPromotionList.fromJson(String str) =>
      TicketConfirmationPromotionList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketConfirmationPromotionList.fromMap(Map<String, dynamic> json) =>
      TicketConfirmationPromotionList(
        productType: json["productType"],
        promotionCode: json["promotionCode"],
        title: json["title"],
        description: json["description"],
        web: json["web"],
        iconImage: json["iconImage"],
        bannerDescDisplay: json["bannerDescDisplay"],
        line1: json["line1"],
        line2: json["line2"],
        productId: json["productId"],
        promotionType: json["promotionType"],
      );

  Map<String, dynamic> toMap() => {
        "productType": productType,
        "promotionCode": promotionCode,
        "title": title,
        "description": description,
        "web": web,
        "iconImage": iconImage,
        "bannerDescDisplay": bannerDescDisplay,
        "line1": line1,
        "line2": line2,
        "productId": productId,
        "promotionType": promotionType,
      };
}

class CustomerInfo {
  CustomerInfo({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;

  factory CustomerInfo.fromJson(String str) =>
      CustomerInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerInfo.fromMap(Map<String, dynamic> json) => CustomerInfo(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}

class PackageDetail {
  PackageDetail({
    this.name,
    this.inclusions,
    this.cancellationPolicy,
    this.ticketTypes,
    this.duration,
    this.durationText,
  });

  final String? name;
  final Inclusions? inclusions;
  final String? cancellationPolicy;
  final List<TicketType>? ticketTypes;
  final String? duration;
  final String? durationText;

  factory PackageDetail.fromJson(String str) =>
      PackageDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PackageDetail.fromMap(Map<String, dynamic> json) => PackageDetail(
        name: json["name"],
        inclusions: Inclusions.fromMap(json["inclusions"]),
        cancellationPolicy: json["cancellationPolicy"],
        ticketTypes: List<TicketType>.from(
            json["ticketTypes"].map((x) => TicketType.fromMap(x))),
        duration: json["duration"],
        durationText: json["durationText"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "inclusions": inclusions?.toMap(),
        "cancellationPolicy": cancellationPolicy,
        "ticketTypes": ticketTypes == null
            ? null
            : List<dynamic>.from(ticketTypes!.map((x) => x.toMap())),
        "duration": duration,
        "durationText": durationText,
      };
}

class Inclusions {
  Inclusions({
    this.highlights,
    this.all,
  });

  final List<Highlight>? highlights;
  final String? all;

  factory Inclusions.fromJson(String str) =>
      Inclusions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Inclusions.fromMap(Map<String, dynamic> json) => Inclusions(
        highlights: json["highlights"] == null
            ? null
            : List<Highlight>.from(
                json["highlights"].map((x) => Highlight.fromMap(x))),
        all: json["all"],
      );

  Map<String, dynamic> toMap() => {
        "highlights": highlights == null
            ? null
            : List<dynamic>.from(highlights!.map((x) => x.toMap())),
        "all": all,
      };
}

class Highlight {
  Highlight({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory Highlight.fromJson(String str) => Highlight.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Highlight.fromMap(Map<String, dynamic> json) => Highlight(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": value,
      };
}

class TicketType {
  TicketType({
    this.paxId,
    this.name,
    this.price,
    this.noOfTickets,
  });

  final String? paxId;
  final String? name;
  final double? price;
  final int? noOfTickets;

  factory TicketType.fromJson(String str) =>
      TicketType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketType.fromMap(Map<String, dynamic> json) => TicketType(
        paxId: json["paxId"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        noOfTickets: json["noOfTickets"],
      );

  Map<String, dynamic> toMap() => {
        "paxId": paxId,
        "name": name,
        "price": price,
        "noOfTickets": noOfTickets,
      };
}

class ParticipantInfo {
  ParticipantInfo({
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

  factory ParticipantInfo.fromJson(String str) =>
      ParticipantInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ParticipantInfo.fromMap(Map<String, dynamic> json) => ParticipantInfo(
        paxId: json["paxId"],
        name: json["name"],
        surname: json["surname"],
        weight: json["weight"],
        dateOfBirth: json["dateOfBirth"],
        passportCountry: json["passportCountry"],
        passportNumber: json["passportNumber"],
        passportCountryIssue: json["passportCountryIssue"],
        expiryDate: json["expiryDate"],
      );

  Map<String, dynamic> toMap() => {
        "paxId": paxId,
        "name": name,
        "surname": surname,
        "weight": weight,
        "dateOfBirth": dateOfBirth,
        "passportCountry": passportCountry,
        "passportNumber": passportNumber,
        "passportCountryIssue": passportCountryIssue,
        "expiryDate": expiryDate
      };
}

class Status {
  Status({
    this.code,
    this.header,
    this.description,
  });

  final String? code;
  final String? header;
  final dynamic description;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
        "description": description,
      };
}
