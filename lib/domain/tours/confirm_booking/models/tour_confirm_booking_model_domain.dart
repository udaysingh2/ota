import 'dart:convert';

class TourConfirmBookingModelDomain {
  TourConfirmBookingModelDomain({
    this.getTourBookingConfirmation,
  });

  final GetTourBookingConfirmation? getTourBookingConfirmation;

  factory TourConfirmBookingModelDomain.fromJson(String str) =>
      TourConfirmBookingModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourConfirmBookingModelDomain.fromMap(Map<String, dynamic> json) =>
      TourConfirmBookingModelDomain(
        getTourBookingConfirmation: json["getTourBookingConfirmation"] == null
            ? null
            : GetTourBookingConfirmation.fromMap(
                json["getTourBookingConfirmation"]),
      );

  Map<String, dynamic> toMap() => {
        "getTourBookingConfirmation": getTourBookingConfirmation == null
            ? null
            : getTourBookingConfirmation!.toMap(),
      };
}

class GetTourBookingConfirmation {
  GetTourBookingConfirmation({
    this.status,
    this.data,
  });

  final Status? status;
  final TourConfirmBookingData? data;

  factory GetTourBookingConfirmation.fromJson(String str) =>
      GetTourBookingConfirmation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTourBookingConfirmation.fromMap(Map<String, dynamic> json) =>
      GetTourBookingConfirmation(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null
            ? null
            : TourConfirmBookingData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
        "data": data == null ? null : data!.toMap(),
      };
}

class TourConfirmBookingData {
  TourConfirmBookingData({
    this.bookingUrn,
    this.tourId,
    this.cityId,
    this.countryId,
    this.bookingDate,
    this.name,
    this.image,
    this.location,
    this.category,
    this.noOfDays,
    this.startTimeAmPm,
    this.promotionList,
    this.packageDetail,
    this.totalAmount,
    this.totalFees,
    this.totalTaxes,
    this.totalDiscount,
    this.participantInfo,
    this.customerInfo,
  });

  final String? bookingUrn;
  final String? tourId;
  final String? cityId;
  final String? countryId;
  final DateTime? bookingDate;
  final String? name;
  final String? image;
  final String? location;
  final String? category;
  final String? noOfDays;
  final String? startTimeAmPm;
  final List<TourConfirmationPromotionList>? promotionList;
  final PackageDetail? packageDetail;
  final double? totalAmount;
  final double? totalFees;
  final double? totalTaxes;
  final double? totalDiscount;
  final List<ParticipantInfo>? participantInfo;
  final CustomerInfo? customerInfo;

  factory TourConfirmBookingData.fromJson(String str) =>
      TourConfirmBookingData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourConfirmBookingData.fromMap(Map<String, dynamic> json) =>
      TourConfirmBookingData(
        bookingUrn: json["bookingUrn"],
        tourId: json["tourId"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        bookingDate: json["bookingDate"] == null
            ? null
            : DateTime.parse(json["bookingDate"]),
        name: json["name"],
        image: json["image"],
        location: json["location"],
        category: json["category"],
        noOfDays: json["noOfDays"],
        startTimeAmPm: json["startTimeAMPM"],
        promotionList: json["promotionList"] == null
            ? null
            : List<TourConfirmationPromotionList>.from(json["promotionList"]
                .map((x) => TourConfirmationPromotionList.fromMap(x))),
        packageDetail: json["packageDetail"] == null
            ? null
            : PackageDetail.fromMap(json["packageDetail"]),
        totalAmount: json["totalAmount"]?.toDouble(),
        totalFees: json["totalFees"]?.toDouble(),
        totalTaxes: json["totalTaxes"]?.toDouble(),
        totalDiscount: json["totalDiscount"]?.toDouble(),
        participantInfo: json["participantInfo"] == null
            ? null
            : List<ParticipantInfo>.from(
                json["participantInfo"].map((x) => ParticipantInfo.fromMap(x))),
        customerInfo: json["customerInfo"] == null
            ? null
            : CustomerInfo.fromMap(json["customerInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn,
        "tourId": tourId,
        "cityId": cityId,
        "countryId": countryId,
        "bookingDate": bookingDate == null
            ? null
            : "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "name": name,
        "image": image,
        "location": location,
        "category": category,
        "noOfDays": noOfDays,
        "startTimeAMPM": startTimeAmPm,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
        "packageDetail": packageDetail == null ? null : packageDetail!.toMap(),
        "totalAmount": totalAmount,
        "totalFees": totalFees,
        "totalTaxes": totalTaxes,
        "totalDiscount": totalDiscount,
        "participantInfo": participantInfo == null
            ? null
            : List<dynamic>.from(participantInfo!.map((x) => x.toMap())),
        "customerInfo": customerInfo == null ? null : customerInfo!.toMap(),
      };
}

class TourConfirmationPromotionList {
  TourConfirmationPromotionList({
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

  factory TourConfirmationPromotionList.fromJson(String str) =>
      TourConfirmationPromotionList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourConfirmationPromotionList.fromMap(Map<String, dynamic> json) =>
      TourConfirmationPromotionList(
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
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;

  factory CustomerInfo.fromJson(String str) =>
      CustomerInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerInfo.fromMap(Map<String, dynamic> json) => CustomerInfo(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
      };
}

class PackageDetail {
  PackageDetail({
    this.name,
    this.inclusions,
    this.cancellationPolicy,
    this.durationText,
    this.duration,
  });

  final String? name;
  final Inclusions? inclusions;
  final String? cancellationPolicy;
  final String? durationText;
  final String? duration;

  factory PackageDetail.fromJson(String str) =>
      PackageDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PackageDetail.fromMap(Map<String, dynamic> json) => PackageDetail(
        name: json["name"],
        inclusions: json["inclusions"] == null
            ? null
            : Inclusions.fromMap(json["inclusions"]),
        cancellationPolicy: json["cancellationPolicy"],
        durationText: json["durationText"],
        duration: json["duration"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "inclusions": inclusions == null ? null : inclusions!.toMap(),
        "cancellationPolicy": cancellationPolicy,
        "durationText": durationText,
        "duration": duration,
      };
}

class Inclusions {
  Inclusions({
    this.highlights,
  });

  final List<Highlight>? highlights;

  factory Inclusions.fromJson(String str) =>
      Inclusions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Inclusions.fromMap(Map<String, dynamic> json) => Inclusions(
        highlights: json["highlights"] == null
            ? null
            : List<Highlight>.from(
                json["highlights"].map((x) => Highlight.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "highlights": highlights == null
            ? null
            : List<dynamic>.from(highlights!.map((x) => x.toMap())),
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
  final double? weight;
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
        weight: json["weight"]?.toDouble(),
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
        "expiryDate": expiryDate,
      };
}

class Status {
  Status({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
      };
}
