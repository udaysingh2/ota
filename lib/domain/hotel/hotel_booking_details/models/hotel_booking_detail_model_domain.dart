import 'dart:convert';

class HotelBookingDetailModelDomain {
  HotelBookingDetailModelDomain({
    this.data,
  });

  final BookingDetailsData? data;

  factory HotelBookingDetailModelDomain.fromJson(String str) =>
      HotelBookingDetailModelDomain.fromMap(json.decode(str));

  factory HotelBookingDetailModelDomain.fromMap(Map<String, dynamic> json) =>
      HotelBookingDetailModelDomain(
        data: json["data"] == null
            ? null
            : BookingDetailsData.fromMap(json["data"]),
      );
}

class BookingDetailsData {
  BookingDetailsData({
    this.bookingStatus,
    this.bookingStatusCode,
    this.bookingId,
    this.bookingUrn,
    this.referenceId,
    this.bookingType,
    this.activityStatus,
    this.hotelBookingDetail,
    this.promotion,
    this.promoPriceDetails,
    this.promotionList,
  });

  final String? bookingStatus;
  final String? bookingStatusCode;
  final String? bookingId;
  final String? bookingUrn;
  final String? referenceId;
  final String? bookingType;
  final String? activityStatus;
  final HotelBookingDetail? hotelBookingDetail;
  final Promotion? promotion;
  final PromoPriceDetails? promoPriceDetails;
  final List<PromotionList>? promotionList;

  factory BookingDetailsData.fromJson(String str) =>
      BookingDetailsData.fromMap(json.decode(str));

  factory BookingDetailsData.fromMap(Map<String, dynamic> json) =>
      BookingDetailsData(
        bookingStatus: json["bookingStatus"] ?? "",
        bookingStatusCode: json["bookingStatusCode"] ?? "",
        bookingId: json["bookingId"] ?? "",
        bookingUrn: json["bookingUrn"] ?? "",
        referenceId: json["referenceId"] ?? "",
        bookingType: json["bookingType"] ?? "",
        activityStatus: json["activityStatus"] ?? "",
        hotelBookingDetail: json["hotelBookingDetail"] == null
            ? null
            : HotelBookingDetail.fromMap(json["hotelBookingDetail"]),
        promotion: json["promotion"] == null
            ? null
            : Promotion.fromMap(json["promotion"]),
        promoPriceDetails: json["priceDetails"] == null
            ? null
            : PromoPriceDetails.fromMap(json["priceDetails"]),
        promotionList: json["promotionList"] == null
            ? null
            : List<PromotionList>.from(
                json["promotionList"].map((x) => PromotionList.fromMap(x))),
      );
}

class PromotionList {
  PromotionList({
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

  factory PromotionList.fromMap(Map<String, dynamic> json) => PromotionList(
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
}

class PromoPriceDetails {
  PromoPriceDetails({
    this.effectiveDiscount,
    this.orderPrice,
    this.addonPrice,
    this.billingAmount,
    this.totalAmount,
  });

  final double? effectiveDiscount;
  final double? orderPrice;
  final double? addonPrice;
  final double? billingAmount;
  final double? totalAmount;

  factory PromoPriceDetails.fromMap(Map<String, dynamic> json) =>
      PromoPriceDetails(
        effectiveDiscount: json["effectiveDiscount"]?.toDouble(),
        orderPrice: json["orderPrice"]?.toDouble(),
        addonPrice: json["addonPrice"]?.toDouble(),
        billingAmount: json["billingAmount"]?.toDouble(),
        totalAmount: json["totalAmount"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "effectiveDiscount": effectiveDiscount,
        "orderPrice": orderPrice,
        "addonPrice": addonPrice,
        "billingAmount": billingAmount,
        "totalAmount": totalAmount,
      };
}

class Promotion {
  Promotion({
    this.promotionId,
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
    this.applicationKey,
  });

  final int? promotionId;
  final String? promotionName;
  final String? shortDescription;
  final double? discount;
  final double? maximumDiscount;
  final String? discountType;
  final String? discountFor;
  final String? promotionLink;
  final String? promotionType;
  final String? iconUrl;
  final String? voucherCode;
  final String? promotionCode;
  final String? startDate;
  final String? endDate;
  final String? applicationKey;

  factory Promotion.fromMap(Map<String, dynamic> json) => Promotion(
        promotionId: json["promotionId"],
        promotionName: json["promotionName"],
        shortDescription: json["shortDescription"],
        discount: json["discount"]?.toDouble(),
        maximumDiscount: json["maximumDiscount"]?.toDouble(),
        discountType: json["discountType"],
        discountFor: json["discountFor"],
        promotionLink: json["promotionLink"],
        promotionType: json["promotionType"],
        iconUrl: json["iconUrl"],
        voucherCode: json["voucherCode"],
        promotionCode: json["promotionCode"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        applicationKey: json["applicationKey"],
      );

  Map<String, dynamic> toMap() => {
        "promotionId": promotionId,
        "promotionName": promotionName,
        "shortDescription": shortDescription,
        "discount": discount,
        "maximumDiscount": maximumDiscount,
        "discountType": discountType,
        "discountFor": discountFor,
        "promotionLink": promotionLink,
        "promotionType": promotionType,
        "iconUrl": iconUrl,
        "voucherCode": voucherCode,
        "promotionCode": promotionCode,
        "startDate": startDate,
        "endDate": endDate,
        "applicationKey": applicationKey,
      };
}

class HotelBookingDetail {
  HotelBookingDetail(
      {this.totalPrice,
      this.hotelDetails,
      this.netPrice,
      this.perNightPrice,
      this.addonPrice,
      this.discount,
      this.amountAdminfee,
      this.amountCancelCharge,
      this.paymentDetails,
      this.cancellationDate,
      this.cancellationReason,
      this.totalRefundAmount,
      this.confirmationDate,
      this.paymentStatus});

  final double? totalPrice;
  final HotelDetails? hotelDetails;
  final double? netPrice;
  final double? perNightPrice;
  final double? addonPrice;
  final double? discount;
  final double? amountAdminfee;
  final double? amountCancelCharge;
  final List<PaymentDetails>? paymentDetails;
  final String? cancellationDate;
  final String? cancellationReason;
  final double? totalRefundAmount;
  final String? confirmationDate;
  final String? paymentStatus;

  factory HotelBookingDetail.fromJson(String str) =>
      HotelBookingDetail.fromMap(json.decode(str));

  factory HotelBookingDetail.fromMap(Map<String, dynamic> json) =>
      HotelBookingDetail(
        totalPrice: json["totalPrice"] == null
            ? null
            : double.tryParse("${json["totalPrice"]}"),
        hotelDetails: json["hotelDetails"] == null
            ? null
            : HotelDetails.fromMap(json["hotelDetails"]),
        netPrice: json["netPrice"] == null
            ? null
            : double.tryParse("${json["netPrice"]}"),
        perNightPrice: json["perNightPrice"] == null
            ? null
            : double.tryParse("${json["perNightPrice"]}"),
        addonPrice: json["addonPrice"] == null
            ? null
            : double.tryParse("${json["addonPrice"]}"),
        discount: json["discount"] == null
            ? null
            : double.tryParse("${json["discount"]}"),
        amountAdminfee: json["amountAdminfee"] == null
            ? null
            : double.tryParse("${json["amountAdminfee"]}"),
        amountCancelCharge: json["amountCancelCharge"] == null
            ? null
            : double.tryParse("${json["amountCancelCharge"]}"),
        paymentDetails: json["payment"] == null
            ? null
            : List<PaymentDetails>.from(
                json["payment"].map((x) => PaymentDetails.fromMap(x))),
        cancellationDate: json["cancellationDate"],
        cancellationReason: json["cancellationReason"],
        totalRefundAmount: json["totalRefundAmount"] == null
            ? null
            : double.tryParse("${json["totalRefundAmount"]}"),
        confirmationDate: json["confirmationDate"],
        paymentStatus: json["paymentStatus"],
      );
}

class HotelDetails {
  HotelDetails({
    this.cityId,
    this.hotelId,
    this.name,
    this.countryId,
    this.imageUrl,
    this.checkInDate,
    this.checkOutDate,
    this.address,
    this.phoneNumber,
    this.rating,
    this.latitude,
    this.longitude,
    this.roomInfo,
    this.freeFoodDelivery,
    this.roomDetails,
    this.facilities,
    this.guestInfo,
    this.addOnServices,
    this.cancellationPolicy,
    this.totalNights,
    this.totalRooms,
    this.promotion,
    this.hotelBenefits,
  });

  final String? cityId;
  final String? hotelId;
  final String? name;
  final String? countryId;
  final String? imageUrl;
  final String? checkInDate;
  final String? checkOutDate;
  final String? address;
  final String? phoneNumber;
  final String? rating;
  final String? latitude;
  final String? longitude;
  final RoomInfo? roomInfo;
  final bool? freeFoodDelivery;
  final List<RoomDetail>? roomDetails;
  final List<Facility>? facilities;
  final List<GuestInfo>? guestInfo;
  final List<AddOnServices>? addOnServices;
  final List<CancellationPolicy>? cancellationPolicy;
  final String? totalNights;
  final String? totalRooms;
  final List<Promotions>? promotion;
  final List<HotelBenefits>? hotelBenefits;

  factory HotelDetails.fromJson(String str) =>
      HotelDetails.fromMap(json.decode(str));

  factory HotelDetails.fromMap(Map<String, dynamic> json) => HotelDetails(
        cityId: json["cityId"],
        hotelId: json["hotelId"],
        name: json["name"],
        countryId: json["countryId"],
        imageUrl: json["imageUrl"],
        checkInDate: json["checkInDate"],
        checkOutDate: json["checkOutDate"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        rating: json["rating"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        roomInfo: json["roomInfo"] == null
            ? null
            : RoomInfo.fromMap(json["roomInfo"]),
        freeFoodDelivery: json["freeFoodDelivery"],
        roomDetails: json["roomDetails"] == null
            ? null
            : List<RoomDetail>.from(
                json["roomDetails"].map((x) => RoomDetail.fromMap(x))),
        facilities: json["facilities"] == null
            ? null
            : List<Facility>.from(
                json["facilities"].map((x) => Facility.fromMap(x))),
        guestInfo: json["guestInfo"] == null
            ? null
            : List<GuestInfo>.from(
                json["guestInfo"].map((x) => GuestInfo.fromMap(x))),
        addOnServices: json["addOnServices"] == null
            ? null
            : List<AddOnServices>.from(
                json["addOnServices"].map((x) => AddOnServices.fromMap(x))),
        cancellationPolicy: json["cancellationPolicy"] == null
            ? null
            : List<CancellationPolicy>.from(json["cancellationPolicy"]
                .map((x) => CancellationPolicy.fromMap(x))),
        totalNights: json["totalNights"],
        totalRooms: json["totalRooms"],
        promotion: json["promotion"] == null
            ? null
            : List<Promotions>.from(
                json["promotion"].map((x) => Promotions.fromMap(x))),
        hotelBenefits: json["hotelBenefits"] == null
            ? null
            : List<HotelBenefits>.from(
                json["hotelBenefits"].map((x) => HotelBenefits.fromMap(x))),
      );
}

class HotelBenefits {
  HotelBenefits({
    this.topic,
    this.shortDescription,
    this.longDescription,
    this.categoryId,
    this.categoryName,
  });
  final String? topic;
  final String? shortDescription;
  final String? longDescription;
  final String? categoryId;
  final String? categoryName;

  factory HotelBenefits.fromJson(String str) =>
      HotelBenefits.fromMap(json.decode(str));

  factory HotelBenefits.fromMap(Map<String, dynamic> json) => HotelBenefits(
        topic: json["topic"],
        shortDescription: json["shortDescription"],
        longDescription: json["longDescription"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
      );
}

class AddOnServices {
  AddOnServices({
    this.serviceName,
    this.price,
    this.noOfItem,
    this.serviceDate,
  });

  final String? serviceName;
  final String? price;
  final String? noOfItem;
  final DateTime? serviceDate;

  factory AddOnServices.fromJson(String str) =>
      AddOnServices.fromMap(json.decode(str));

  factory AddOnServices.fromMap(Map<String, dynamic> json) => AddOnServices(
        serviceName: json["serviceName"],
        price: json["price"],
        noOfItem: json["noOfItem"],
        serviceDate: json["serviceDate"] == null
            ? null
            : DateTime.tryParse(json["serviceDate"]),
      );
}

class Promotions {
  Promotions({
    this.productId,
    this.productType,
    this.promotionType,
    this.promotionCode,
    this.line1,
    this.line2,
    this.startDate,
    this.endDate,
  });

  final String? productId;
  final String? productType;
  final String? promotionType;
  final String? promotionCode;
  final String? line1;
  final String? line2;
  final String? startDate;
  final String? endDate;

  factory Promotions.fromJson(String str) =>
      Promotions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Promotions.fromMap(Map<String, dynamic> json) => Promotions(
        productId: json["productId"],
        productType: json["productType"],
        promotionType: json["promotionType"],
        promotionCode: json["promotionCode"],
        line1: json["line1"],
        line2: json["line2"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "productType": productType,
        "promotionType": promotionType,
        "promotionCode": promotionCode,
        "line1": line1,
        "line2": line2,
        "startDate": startDate,
        "endDate": endDate,
      };
}

class CancellationPolicy {
  CancellationPolicy({
    this.days,
    this.cancellationDaysDescription,
    this.cancellationChargeDescription,
    this.cancellationStatus,
  });

  final int? days;
  final String? cancellationDaysDescription;
  final String? cancellationChargeDescription;
  final String? cancellationStatus;

  factory CancellationPolicy.fromJson(String str) =>
      CancellationPolicy.fromMap(json.decode(str));

  factory CancellationPolicy.fromMap(Map<String, dynamic> json) =>
      CancellationPolicy(
        days: json["days"] == null ? null : int.tryParse("${json["days"]}"),
        cancellationDaysDescription: json["cancellationDaysDescription"],
        cancellationChargeDescription: json["cancellationChargeDescription"],
        cancellationStatus: json["cancellationStatus"],
      );
}

class Facility {
  Facility({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory Facility.fromJson(String str) => Facility.fromMap(json.decode(str));

  factory Facility.fromMap(Map<String, dynamic> json) => Facility(
        key: json["key"],
        value: json["value"],
      );
}

class GuestInfo {
  GuestInfo({
    this.firstName,
    this.lastName,
    this.title,
  });

  final String? firstName;
  final String? lastName;
  final String? title;

  factory GuestInfo.fromJson(String str) => GuestInfo.fromMap(json.decode(str));

  factory GuestInfo.fromMap(Map<String, dynamic> json) => GuestInfo(
        firstName: json["firstName"],
        lastName: json["lastName"],
        title: json["title"],
      );
}

class RoomDetail {
  RoomDetail({
    this.type,
    this.price,
    this.name,
    this.noOfRoom,
    this.noOfAdult,
    this.noOfChild,
    this.priceOfRoomWithChildMeal,
    this.noOfRoomsAndName,
    this.roomCode,
    this.roomCatName,
  });

  final String? type;
  final String? price;
  final String? name;
  final String? noOfRoom;
  final String? noOfAdult;
  final String? noOfChild;
  final double? priceOfRoomWithChildMeal;
  final String? noOfRoomsAndName;
  final String? roomCode;
  final String? roomCatName;

  factory RoomDetail.fromJson(String str) =>
      RoomDetail.fromMap(json.decode(str));

  factory RoomDetail.fromMap(Map<String, dynamic> json) => RoomDetail(
        type: json["type"],
        price: json["price"],
        name: json["name"],
        noOfRoom: json["noOfRoom"],
        noOfAdult: json["noOfAdult"],
        noOfChild: json["noOfChild"],
        priceOfRoomWithChildMeal: json["priceOfRoomWithChildMeal"] == null
            ? null
            : double.tryParse("${json["priceOfRoomWithChildMeal"]}"),
        noOfRoomsAndName: json["noOfRoomsAndName"],
        roomCode: json["roomCode"],
        roomCatName: json["roomCatName"],
      );
}

class RoomInfo {
  RoomInfo({
    this.roomOfferName,
    this.promoteFlag,
    this.dimension,
    this.doubleBedFlag,
    this.twinBedFlag,
    this.queenBedflag,
    this.smorkingFlag,
    this.nonSmorkingFlag,
    this.noWindowFlag,
    this.balconyFlag,
    this.wifiFlag,
    this.maxPaxNbr,
    this.roomFacilities,
  });

  final String? roomOfferName;
  final String? promoteFlag;
  final String? dimension;
  final String? doubleBedFlag;
  final String? twinBedFlag;
  final String? queenBedflag;
  final String? smorkingFlag;
  final String? nonSmorkingFlag;
  final String? noWindowFlag;
  final String? balconyFlag;
  final String? wifiFlag;
  final String? maxPaxNbr;
  final List<RoomFacility>? roomFacilities;

  factory RoomInfo.fromJson(String str) => RoomInfo.fromMap(json.decode(str));

  factory RoomInfo.fromMap(Map<String, dynamic> json) => RoomInfo(
        roomOfferName: json["roomOfferName"],
        promoteFlag: json["promoteFlag"],
        dimension: json["dimension"],
        doubleBedFlag: json["doubleBedFlag"],
        twinBedFlag: json["twinBedFlag"],
        queenBedflag: json["queenBedflag"],
        smorkingFlag: json["smorkingFlag"],
        nonSmorkingFlag: json["nonSmorkingFlag"],
        noWindowFlag: json["noWindowFlag"],
        balconyFlag: json["balconyFlag"],
        wifiFlag: json["wifiFlag"],
        maxPaxNbr: json["maxPaxNbr"],
        roomFacilities: json["roomFacilities"] == null
            ? null
            : List<RoomFacility>.from(
                json["roomFacilities"].map((x) => RoomFacility.fromMap(x))),
      );
}

class RoomFacility {
  RoomFacility({
    this.code,
    this.name,
  });

  final String? code;
  final String? name;

  factory RoomFacility.fromJson(String str) =>
      RoomFacility.fromMap(json.decode(str));

  factory RoomFacility.fromMap(Map<String, dynamic> json) => RoomFacility(
        code: json["code"],
        name: json["name"],
      );
}

class PaymentDetails {
  PaymentDetails({
    this.type,
    this.name,
    this.amount,
    this.cardType,
    this.cardNumber,
    this.cardNickName,
  });

  final String? type;
  final String? name;
  final String? amount;
  final String? cardType;
  final String? cardNumber;
  final String? cardNickName;

  factory PaymentDetails.fromJson(String str) =>
      PaymentDetails.fromMap(json.decode(str));

  factory PaymentDetails.fromMap(Map<String, dynamic> json) => PaymentDetails(
        type: json["type"],
        name: json["name"],
        amount: json["amount"],
        cardType: json["cardType"],
        cardNumber: json["cardNo"],
        cardNickName: json["cardNickName"],
      );
}

class Status {
  Status({
    this.description,
    this.header,
    this.code,
  });

  final String? description;
  final String? header;
  final String? code;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        description: json["description"],
        header: json["header"],
        code: json["code"],
      );
}
