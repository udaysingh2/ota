import 'dart:convert';

class CarBookingDetailDomainModel {
  CarBookingDetailDomainModel({
    this.status,
    this.carBookingDetailData,
  });

  final Status? status;
  final CarBookingDetailData? carBookingDetailData;

  factory CarBookingDetailDomainModel.fromMap(Map<String, dynamic>? json) =>
      CarBookingDetailDomainModel(
        status:
            json?["status"] == null ? null : Status.fromMap(json?["status"]),
        carBookingDetailData: json?["data"] == null
            ? null
            : CarBookingDetailData.fromMap(json?["data"]),
      );

  factory CarBookingDetailDomainModel.fromString(String str) =>
      CarBookingDetailDomainModel.fromMap(json.decode(str));
}

class CarBookingDetailData {
  CarBookingDetailData({
    this.displayStatus,
    this.bookingStatus,
    this.bookingUrn,
    this.serviceNumber,
    this.activityStatus,
    this.bookingId,
    this.bookingType,
    this.carBookingDetails,
    this.promotionList,
    this.promotion,
    this.promoPriceDetails,
  });

  final String? displayStatus;
  final String? bookingUrn;
  final String? bookingId;
  final String? bookingStatus;
  final String? serviceNumber;
  final String? activityStatus;
  final String? bookingType;
  final CarBookingDetails? carBookingDetails;
  final List<PromotionList>? promotionList;
  final Promotion? promotion;
  final PromoPriceDetails? promoPriceDetails;

  factory CarBookingDetailData.fromMap(Map<String, dynamic> json) =>
      CarBookingDetailData(
        displayStatus: json["displayStatus"],
        bookingStatus: json["bookingStatus"],
        bookingUrn: json["bookingUrn"],
        serviceNumber: json["serviceNumber"],
        activityStatus: json["activityStatus"],
        bookingId: json["bookingId"],
        bookingType: json["bookingType"],
        carBookingDetails: json["carBookingDetails"] == null
            ? null
            : CarBookingDetails.fromMap(json["carBookingDetails"]),
        promotionList: json["promotionList"] == null
            ? null
            : List<PromotionList>.from(
                json["promotionList"].map((x) => PromotionList.fromMap(x))),
        promotion: json["promotion"] == null
            ? null
            : Promotion.fromMap(json["promotion"]),
        promoPriceDetails: json["promoPriceDetails"] == null
            ? null
            : PromoPriceDetails.fromMap(json["promoPriceDetails"]),
      );
}

class CarBookingDetails {
  CarBookingDetails(
      {this.car,
      this.pickupCounter,
      this.returnCounter,
      this.paymentDetails,
      this.supplier,
      this.driverName,
      this.flightNumber,
      this.includesInfo,
      this.carRentalConditionsInfo,
      this.pickupConditionsInfo,
      this.extraCharges,
      this.cancellationPolicy,
      this.paymentStatus,
      this.netPrice,
      this.totalPrice,
      this.totalPayablePrice,
      this.extrasOnlinePrice,
      this.extrasCounterPrice,
      this.discount,
      this.confirmationDate,
      this.cancellationDate,
      this.cancellationCharge,
      this.processingFee,
      this.cancellationReason,
      this.totalRefundAmount,
      this.rentalDays,
      this.pickUpDate,
      this.dropOffDate,
      this.allowLateReturn,
      this.returnExtraCharge});

  final Car? car;
  final Counter? pickupCounter;
  final Counter? returnCounter;
  final List<PaymentDetails>? paymentDetails;
  final Supplier? supplier;
  final List<ExtraCharges>? extraCharges;
  final List<CancellationPolicy>? cancellationPolicy;
  final String? driverName;
  final String? flightNumber;
  final String? includesInfo;
  final String? pickupConditionsInfo;
  final String? paymentStatus;
  final String? cancellationReason;
  final double? cancellationCharge;
  final double? processingFee;
  final double? totalRefundAmount;
  final double? netPrice;
  final double? totalPrice;
  final double? totalPayablePrice;
  final double? extrasOnlinePrice;
  final double? extrasCounterPrice;
  final double? discount;
  final int? rentalDays;
  final int? allowLateReturn;
  final DateTime? confirmationDate;
  final DateTime? cancellationDate;
  final DateTime? pickUpDate;
  final DateTime? dropOffDate;
  final String? carRentalConditionsInfo;
  final double? returnExtraCharge;

  factory CarBookingDetails.fromMap(Map<String, dynamic> json) =>
      CarBookingDetails(
        car: json["car"] == null ? null : Car.fromMap(json["car"]),
        pickupCounter: json["pickupCounter"] == null
            ? null
            : Counter.fromMap(json["pickupCounter"]),
        returnCounter: json["returnCounter"] == null
            ? null
            : Counter.fromMap(json["returnCounter"]),
        paymentDetails: json["payment"] == null
            ? null
            : List<PaymentDetails>.from(
                json["payment"].map((x) => PaymentDetails.fromMap(x))),
        supplier: json["supplier"] == null
            ? null
            : Supplier.fromMap(json["supplier"]),
        extraCharges: json["extraCharges"] == null
            ? null
            : List<ExtraCharges>.from(
                json["extraCharges"].map((x) => ExtraCharges.fromMap(x))),
        cancellationPolicy: json["cancellationPolicy"] == null
            ? null
            : List<CancellationPolicy>.from(json["cancellationPolicy"]
                .map((x) => CancellationPolicy.fromMap(x))),
        confirmationDate: json["confirmationDate"] == null
            ? null
            : DateTime.parse(json["confirmationDate"]),
        cancellationDate: json["cancellationDate"] == null
            ? null
            : DateTime.parse(json["cancellationDate"]),
        pickUpDate: json["pickupDateTime"] == null
            ? null
            : DateTime.parse(json["pickupDateTime"]),
        dropOffDate: json["returnDateTime"] == null
            ? null
            : DateTime.parse(json["returnDateTime"]),
        driverName: json["driverName"],
        flightNumber: json["flightNumber"],
        includesInfo: json["includesInfo"],
        carRentalConditionsInfo: json["carRentalConditionsInfo"] == null
            ? null
            : "${json["carRentalConditionsInfo"]}",
        pickupConditionsInfo: json["pickupConditionsInfo"] == null
            ? null
            : "${json["pickupConditionsInfo"]}",
        paymentStatus: json["paymentStatus"],
        cancellationReason: json["cancellationReason"],
        netPrice: json["netPrice"] == null
            ? null
            : double.tryParse("${json["netPrice"]}"),
        totalPrice: json["totalPrice"] == null
            ? null
            : double.tryParse("${json["totalPrice"]}"),
        totalPayablePrice: json["totalPayablePrice"] == null
            ? null
            : double.tryParse("${json["totalPayablePrice"]}"),
        extrasOnlinePrice: json["extrasOnlinePrice"] == null
            ? null
            : double.tryParse("${json["extrasOnlinePrice"]}"),
        extrasCounterPrice: json["extrasCounterPrice"] == null
            ? null
            : double.tryParse("${json["extrasCounterPrice"]}"),
        discount: json["totalDiscount"] == null
            ? null
            : double.tryParse("${json["totalDiscount"]}"),
        cancellationCharge: json["cancellationCharge"] == null
            ? null
            : double.tryParse("${json["cancellationCharge"]}"),
        processingFee: json["processingCharge"] == null
            ? null
            : double.tryParse("${json["processingCharge"]}"),
        totalRefundAmount: json["totalRefundAmount"] == null
            ? null
            : double.tryParse("${json["totalRefundAmount"]}"),
        rentalDays: json["rentalDays"] == null
            ? null
            : int.tryParse("${json["rentalDays"]}"),
        allowLateReturn: json["allowLateReturn"] == null
            ? null
            : int.tryParse("${json["allowLateReturn"]}"),
        returnExtraCharge: json["returnExtraCharge"] == null
            ? null
            : double.tryParse("${json["returnExtraCharge"]}"),
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

class CancellationPolicy {
  CancellationPolicy({
    this.cancelDays,
    this.message,
  });

  final int? cancelDays;
  final String? message;

  factory CancellationPolicy.fromMap(Map<String, dynamic> json) =>
      CancellationPolicy(
        cancelDays: json["cancelDays"] == null
            ? null
            : int.tryParse("${json["cancelDays"]}"),
        message: json["message"],
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

class Car {
  Car({
    this.carId,
    this.name,
    this.brand,
    this.crafttype,
    this.seatNbr,
    this.doorNbr,
    this.bagLargeNbr,
    this.bagSmallNbr,
    this.engine,
    this.gear,
    this.facilities,
    this.year,
    this.includesInfo,
    this.images,
    this.fuelType,
  });

  final String? carId;
  final String? name;
  final String? brand;
  final String? crafttype;
  final String? seatNbr;
  final String? doorNbr;
  final String? bagLargeNbr;
  final String? bagSmallNbr;
  final String? engine;
  final String? gear;
  final String? year;
  final String? includesInfo;
  final String? fuelType;
  final List<String>? facilities;
  final Images? images;

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        carId: json["carId"] == null ? null : "${json["carId"]}",
        name: json["name"] == null ? null : "${json["name"]}",
        brand: json["brand"] == null ? null : "${json["brand"]}",
        crafttype: json["craftType"] == null ? null : "${json["craftType"]}",
        seatNbr: json["seatNbr"] == null ? null : "${json["seatNbr"]}",
        doorNbr: json["doorNbr"] == null ? null : "${json["doorNbr"]}",
        bagLargeNbr:
            json["bagLargeNbr"] == null ? null : "${json["bagLargeNbr"]}",
        bagSmallNbr:
            json["bagSmallNbr"] == null ? null : "${json["bagSmallNbr"]}",
        engine: json["engine"] == null ? null : "${json["engine"]}",
        gear: json["gear"] == null ? null : "${json["gear"]}",
        year: json["year"] == null ? null : "${json["year"]}",
        fuelType: json["fuelType"] == null ? null : "${json["fuelType"]}",
        includesInfo:
            json["includesInfo"] == null ? null : "${json["includesInfo"]}",
        facilities: json["facilities"] == null
            ? null
            : List<String>.from(json["facilities"].map((x) => x)),
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
      );
}

class Images {
  Images({
    this.thumb,
    this.full,
  });

  String? thumb;
  String? full;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        thumb: json["thumb"],
        full: json["full"],
      );
}

class ExtraCharges {
  ExtraCharges({
    this.serviceId,
    this.chargeType,
    this.description,
    this.isCompulsory,
    this.name,
    this.price,
    this.quantity,
  });

  final int? serviceId;
  final int? chargeType;
  final double? price;
  final int? quantity;
  final String? description;
  final String? name;
  final bool? isCompulsory;

  factory ExtraCharges.fromMap(Map<String, dynamic> json) => ExtraCharges(
        serviceId: json["serviceId"] == null
            ? null
            : int.tryParse("${json["serviceId"]}"),
        chargeType: json["chargeType"] == null
            ? null
            : int.tryParse("${json["chargeType"]}"),
        price:
            json["price"] == null ? null : double.tryParse("${json["price"]}"),
        quantity: json["quantity"] == null
            ? null
            : int.tryParse("${json["quantity"]}"),
        description: json["description"],
        isCompulsory: json["isCompulsory"],
        name: json["name"],
      );
}

class PaymentDetails {
  PaymentDetails({
    this.type,
    this.name,
    this.amount,
    this.cardType,
    this.cardNo,
    this.cardNickName,
  });

  final String? type;
  final String? name;
  final String? amount;
  final String? cardType;
  final String? cardNo;
  final String? cardNickName;

  factory PaymentDetails.fromMap(Map<String, dynamic> json) => PaymentDetails(
        type: json["type"],
        name: json["name"],
        amount: json["amount"],
        cardType: json["cardType"],
        cardNo: json["cardNo"],
        cardNickName: json["cardNickName"],
      );
}

class Counter {
  Counter({
    this.locationId,
    this.name,
    this.address,
    this.locationName,
    this.latitude,
    this.longitude,
    this.opentime,
    this.closetime,
    this.description,
    this.id,
  });

  final String? locationId;
  final String? name;
  final String? address;
  final String? locationName;
  final String? latitude;
  final String? longitude;
  final String? opentime;
  final String? closetime;
  final String? description;
  final String? id;

  factory Counter.fromMap(Map<String, dynamic> json) => Counter(
        name: json["name"],
        address: json["address"],
        locationName: json["locationName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        opentime: json["opentime"],
        closetime: json["closetime"],
        description: json["description"],
        locationId: json["locationId"],
        id: json["counterId"] == null ? null : "${json["counterId"]}",
      );
}

class Supplier {
  Supplier({
    this.id,
    this.name,
    this.logo,
  });

  final String? id;
  final String? name;
  final Logo? logo;

  factory Supplier.fromMap(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        name: json["name"],
        logo: json["logo"] == null ? null : Logo.fromMap(json["logo"]),
      );
}

class Logo {
  Logo({
    this.url,
  });

  final String? url;

  factory Logo.fromMap(Map<String, dynamic> json) => Logo(
        url: json["url"],
      );
}

class Status {
  Status({
    this.code,
    this.header,
    this.description,
  });

  final int? code;
  final String? header;
  final String? description;

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"] == null ? null : int.tryParse("${json["code"]}"),
        header: json["header"],
        description: json["description"],
      );
}
