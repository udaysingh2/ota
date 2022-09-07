import 'dart:convert';

import '../../../../core/query_names.dart';

class TicketBookingDetailModelDomain {
  TicketBookingDetailModelDomain({
    this.otaBookingDetails,
  });

  final OtaBookingDetails? otaBookingDetails;

  factory TicketBookingDetailModelDomain.fromJson(String str) =>
      TicketBookingDetailModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketBookingDetailModelDomain.fromMap(Map<String, dynamic> json) =>
      TicketBookingDetailModelDomain(
        otaBookingDetails:
            json[QueryNames.shared.getTicketBookingDetail] == null
                ? null
                : OtaBookingDetails.fromMap(
                    json[QueryNames.shared.getTicketBookingDetail]),
      );

  Map<String, dynamic> toMap() => {
        QueryNames.shared.getTicketBookingDetail: otaBookingDetails?.toMap(),
      };
}

class OtaBookingDetails {
  OtaBookingDetails({
    this.status,
    this.data,
  });

  final Status? status;
  final Data? data;

  factory OtaBookingDetails.fromJson(String str) =>
      OtaBookingDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaBookingDetails.fromMap(Map<String, dynamic> json) =>
      OtaBookingDetails(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status?.toMap(),
        "data": data?.toMap(),
      };
}

class Data {
  Data({
    this.bookingStatus,
    this.activityStatus,
    this.bookingUrn,
    this.bookingId,
    this.orderId,
    this.bookingType,
    this.promotionList,
    this.ticketBookingDetail,
  });

  final String? bookingStatus;
  final String? activityStatus;
  final String? bookingUrn;
  final String? bookingId;
  final String? orderId;
  final String? bookingType;
  final List<TicketBookingDetailPromotionList>? promotionList;
  final TicketBookingDetail? ticketBookingDetail;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        bookingStatus: json["bookingStatus"],
        activityStatus: json["activityStatus"],
        bookingUrn: json["bookingUrn"],
        bookingId: json["bookingId"],
        orderId: json["orderId"],
        bookingType: json["bookingType"],
        promotionList: json["promotionList"] == null
            ? null
            : List<TicketBookingDetailPromotionList>.from(json["promotionList"]
                .map((x) => TicketBookingDetailPromotionList.fromMap(x))),
        ticketBookingDetail: json["ticketBookingDetail"] == null
            ? null
            : TicketBookingDetail.fromMap(json["ticketBookingDetail"]),
      );

  Map<String, dynamic> toMap() => {
        "bookingStatus": bookingStatus,
        "activityStatus": activityStatus,
        "bookingUrn": bookingUrn,
        "bookingId": bookingId,
        "orderId": orderId,
        "bookingType": bookingType,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
        "ticketBookingDetail": ticketBookingDetail?.toMap(),
      };
}

class TicketBookingDetailPromotionList {
  TicketBookingDetailPromotionList({
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

  factory TicketBookingDetailPromotionList.fromJson(String str) =>
      TicketBookingDetailPromotionList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketBookingDetailPromotionList.fromMap(Map<String, dynamic> json) =>
      TicketBookingDetailPromotionList(
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

class TicketBookingDetail {
  TicketBookingDetail(
      {this.name,
      this.imageUrl,
      this.category,
      this.location,
      this.packageDetail,
      this.ticketTypes,
      this.information,
      this.bookingDate,
      this.cancellationDate,
      this.cancellationCharge,
      this.cancellationReason,
      this.totalRefundAmount,
      this.noOfDays,
      this.participantInfo,
      this.providerName,
      this.supplierContact,
      this.paymentStatus,
      this.netPrice,
      this.totalPrice,
      this.discount,
      this.paymentDetails,
      this.ticketId,
      this.cityId,
      this.countryId,
      this.confirmationDate,
      this.promotion,
      this.priceDetails});

  final String? name;
  final String? imageUrl;
  final String? category;
  final String? location;
  final PackageDetail? packageDetail;
  final List<TicketType>? ticketTypes;
  final Information? information;
  final String? bookingDate;
  final String? cancellationDate;
  final double? cancellationCharge;
  final String? cancellationReason;
  final double? totalRefundAmount;
  final String? noOfDays;
  final List<ParticipantInfo>? participantInfo;
  final String? providerName;
  final String? supplierContact;
  final String? paymentStatus;
  final double? netPrice;
  final double? totalPrice;
  final double? discount;
  final List<PaymentDetails>? paymentDetails;
  final String? ticketId;
  final String? cityId;
  final String? countryId;
  final String? confirmationDate;
  Promotion? promotion;
  PriceDetails? priceDetails;

  factory TicketBookingDetail.fromJson(String str) =>
      TicketBookingDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketBookingDetail.fromMap(Map<String, dynamic> json) =>
      TicketBookingDetail(
        name: json["name"],
        imageUrl: json["imageUrl"],
        category: json["category"],
        location: json["location"],
        packageDetail: json["packageDetail"] == null
            ? null
            : PackageDetail.fromMap(json["packageDetail"]),
        ticketTypes: json["ticketTypes"] == null
            ? null
            : List<TicketType>.from(
                json["ticketTypes"].map((x) => TicketType.fromMap(x))),
        information: json["information"] == null
            ? null
            : Information.fromMap(json["information"]),
        bookingDate: json["bookingDate"],
        cancellationDate: json["cancellationDate"],
        cancellationCharge: json["cancellationCharge"]?.toDouble(),
        cancellationReason: json["cancellationReason"],
        totalRefundAmount: json["totalRefundAmount"]?.toDouble(),
        noOfDays: json["noOfDays"],
        participantInfo: json["participantInfo"] == null
            ? null
            : List<ParticipantInfo>.from(
                json["participantInfo"].map((x) => ParticipantInfo.fromMap(x))),
        providerName: json["providerName"],
        supplierContact: json["supplierContact"],
        paymentStatus: json["paymentStatus"],
        netPrice: json["netPrice"]?.toDouble(),
        totalPrice: json["totalPrice"]?.toDouble(),
        discount: json["discount"]?.toDouble(),
        paymentDetails: json["payment"] == null
            ? null
            : List<PaymentDetails>.from(
                json["payment"].map((x) => PaymentDetails.fromMap(x))),
        ticketId: json["ticketId"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        confirmationDate: json["confirmationDate"],
        promotion: json["promotion"] == null
            ? null
            : Promotion.fromJson(json["promotion"]),
        priceDetails: json["priceDetails"] == null
            ? null
            : PriceDetails.fromJson(json["priceDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "imageUrl": imageUrl,
        "category": category,
        "location": location,
        "packageDetail": packageDetail?.toMap(),
        "ticketTypes": ticketTypes == null
            ? null
            : List<dynamic>.from(ticketTypes!.map((x) => x.toMap())),
        "information": information?.toMap(),
        "bookingDate": bookingDate,
        "cancellationDate": cancellationDate,
        "cancellationCharge": cancellationCharge,
        "cancellationReason": cancellationReason,
        "totalRefundAmount": totalRefundAmount,
        "noOfDays": noOfDays,
        "participantInfo": participantInfo == null
            ? null
            : List<dynamic>.from(participantInfo!.map((x) => x.toMap())),
        "providerName": providerName,
        "supplierContact": supplierContact,
        "paymentStatus": paymentStatus,
        "netPrice": netPrice,
        "totalPrice": totalPrice,
        "discount": discount,
        "paymentDetails": paymentDetails == null
            ? null
            : List<dynamic>.from(paymentDetails!.map((x) => x.toMap())),
        "ticketId": ticketId,
        "cityId": cityId,
        "countryId": countryId,
        "confirmationDate": confirmationDate,
        "priceDetails": priceDetails?.toJson(),
        "promotion": promotion?.toJson()
      };
}

class Promotion {
  int? promotionId;
  String? promotionName;
  String? shortDescription;
  double? discount;
  double? maximumDiscount;
  String? discountType;
  String? discountFor;
  String? promotionLink;
  String? promotionType;
  String? iconUrl;
  String? voucherCode;
  String? promotionCode;
  String? startDate;
  String? endDate;
  String? applicationKey;

  Promotion(
      {this.promotionId,
      this.promotionName,
      this.shortDescription,
      this.discount,
      this.maximumDiscount,
      this.discountType,
      this.discountFor,
      this.promotionLink,
      this.promotionType,
      this.iconUrl,
      this.voucherCode,
      this.promotionCode,
      this.startDate,
      this.endDate,
      this.applicationKey});

  Promotion.fromJson(Map<String, dynamic> json) {
    promotionId = json['promotionId'];
    promotionName = json['promotionName'];
    shortDescription = json['shortDescription'];
    discount = json['discount']?.toDouble();
    maximumDiscount = json['maximumDiscount']?.toDouble();
    discountType = json['discountType'];
    discountFor = json['discountFor'];
    promotionLink = json['promotionLink'];
    promotionType = json['promotionType'];
    iconUrl = json['iconUrl'];
    voucherCode = json['voucherCode'];
    promotionCode = json['promotionCode'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    applicationKey = json['applicationKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promotionId'] = promotionId;
    data['promotionName'] = promotionName;
    data['shortDescription'] = shortDescription;
    data['discount'] = discount;
    data['maximumDiscount'] = maximumDiscount;
    data['discountType'] = discountType;
    data['discountFor'] = discountFor;
    data['promotionLink'] = promotionLink;
    data['promotionType'] = promotionType;
    data['iconUrl'] = iconUrl;
    data['voucherCode'] = voucherCode;
    data['promotionCode'] = promotionCode;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['applicationKey'] = applicationKey;
    return data;
  }
}

class PriceDetails {
  double? effectiveDiscount;
  double? orderPrice;
  double? addonPrice;
  double? billingAmount;
  double? totalAmount;

  PriceDetails(
      {this.effectiveDiscount,
      this.orderPrice,
      this.addonPrice,
      this.billingAmount,
      this.totalAmount});

  PriceDetails.fromJson(Map<String, dynamic> json) {
    effectiveDiscount = json['effectiveDiscount']?.toDouble();
    orderPrice = json['orderPrice']?.toDouble();
    addonPrice = json['addonPrice']?.toDouble();
    billingAmount = json['billingAmount']?.toDouble();
    totalAmount = json['totalAmount']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['effectiveDiscount'] = effectiveDiscount;
    data['orderPrice'] = orderPrice;
    data['addonPrice'] = addonPrice;
    data['billingAmount'] = billingAmount;
    data['totalAmount'] = totalAmount;
    return data;
  }
}

class Information {
  final String? description;
  final String? conditions;
  final String? howToUse;
  final String? openTime;
  final String? closeTime;

  Information({
    this.description,
    this.conditions,
    this.howToUse,
    this.openTime,
    this.closeTime,
  });

  factory Information.fromJson(String str) =>
      Information.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Information.fromMap(Map<String, dynamic> json) => Information(
        description: json["description"],
        conditions: json["conditions"],
        howToUse: json["howToUse"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "conditions": conditions,
        "howToUse": howToUse,
        "openTime": openTime,
        "closeTime": closeTime,
      };
}

class PackageDetail {
  PackageDetail({
    this.packageName,
    this.inclusions,
    this.cancellationPolicy,
    this.durationText,
    this.exclusions,
    this.conditions,
    this.shuttle,
    this.meetingPoint,
    this.meetingPointLatitude,
    this.meetingPointLongitude,
    this.schedule,
  });

  factory PackageDetail.fromJson(String str) =>
      PackageDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  final String? packageName;
  final Inclusions? inclusions;
  final String? cancellationPolicy;
  final String? durationText;
  final String? exclusions;
  final String? conditions;
  final String? shuttle;
  final String? meetingPoint;
  final String? meetingPointLatitude;
  final String? meetingPointLongitude;
  final String? schedule;

  factory PackageDetail.fromMap(Map<String, dynamic> json) => PackageDetail(
        packageName: json["packageName"],
        inclusions: json["inclusions"] == null
            ? null
            : Inclusions.fromMap(json["inclusions"]),
        cancellationPolicy: json["cancellationPolicy"],
        durationText: json["durationText"],
        exclusions: json["exclusions"],
        conditions: json["conditions"],
        shuttle: json["shuttle"],
        meetingPoint: json["meetingPoint"],
        meetingPointLatitude: json["meetingPointLatitude"],
        meetingPointLongitude: json["meetingPointLongitude"],
        schedule: json["schedule"],
      );

  Map<String, dynamic> toMap() => {
        "packageName": packageName,
        "inclusions": inclusions?.toMap(),
        "cancellationPolicy": cancellationPolicy,
        "durationText": durationText,
        "exclusions": exclusions,
        "conditions": conditions,
        "shuttle": shuttle,
        "meetingPoint": meetingPoint,
        "meetingPointLatitude": meetingPointLatitude,
        "meetingPointLongitude": meetingPointLongitude,
        "schedule": schedule,
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

class ParticipantInfo {
  ParticipantInfo({
    this.name,
    this.surname,
    this.weight,
    this.dateOfBirth,
    this.passportCountry,
    this.passportNumber,
    this.passportCountryIssue,
    this.expiryDate,
  });

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

class PaymentDetails {
  PaymentDetails(
      {this.type,
      this.cardNo,
      this.cardNickName,
      this.name,
      this.amount,
      this.cardType});

  final String? type;
  final String? cardNo;
  final String? cardNickName;
  final String? amount;
  final String? name;
  final String? cardType;

  factory PaymentDetails.fromJson(String str) =>
      PaymentDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentDetails.fromMap(Map<String, dynamic> json) => PaymentDetails(
        cardType: json["cardType"],
        cardNo: json["cardNo"],
        cardNickName: json["cardNickName"],
        type: json["type"],
        name: json["name"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "cardType": cardType,
        "cardNo": cardNo,
        "cardNickName": cardNickName,
        "type": type,
        "name": name,
        "amount": amount
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

class Status {
  Status({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
      };
}
