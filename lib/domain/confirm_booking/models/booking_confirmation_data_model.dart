import 'dart:convert';

class BookingConfirmationData {
  BookingConfirmationData({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory BookingConfirmationData.fromJson(String str) =>
      BookingConfirmationData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookingConfirmationData.fromMap(Map<String, dynamic> json) =>
      BookingConfirmationData(
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
    this.totalAmount,
    this.totalFees,
    this.totalTaxes,
    this.totalDiscount,
    this.status,
    this.hotelBookingDetails,
    this.currency,
    this.locale,
    this.guestInfo,
    this.customerInfo,
    this.bookingForSomeoneElse,
    this.promotionList,
  });

  final String? bookingUrn;
  final double? totalAmount;
  final double? totalFees;
  final double? totalTaxes;
  final double? totalDiscount;
  final String? status;
  final HotelBookingDetails? hotelBookingDetails;
  final String? currency;
  final String? locale;
  final List<GuestInfo>? guestInfo;
  final CustomerInfo? customerInfo;
  final bool? bookingForSomeoneElse;
  final List<PromotionList>? promotionList;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        bookingUrn: json["bookingUrn"],
        totalAmount: json["totalAmount"]?.toDouble(),
        totalFees: json["totalFees"]?.toDouble(),
        totalTaxes: json["totalTaxes"]?.toDouble(),
        totalDiscount: json["totalDiscount"]?.toDouble(),
        status: json["status"],
        hotelBookingDetails: json["hotelBookingDetails"] == null
            ? null
            : HotelBookingDetails.fromMap(json["hotelBookingDetails"]),
        currency: json["currency"],
        locale: json["locale"],
        guestInfo: json["guestInfo"] == null
            ? null
            : List<GuestInfo>.from(
                json["guestInfo"].map((x) => GuestInfo.fromMap(x))),
        customerInfo: json["customerInfo"] == null
            ? null
            : CustomerInfo.fromMap(json["customerInfo"]),
        bookingForSomeoneElse: json["bookingForSomeoneElse"],
        promotionList: json["promotionList"] == null
            ? null
            : List<PromotionList>.from(
                json["promotionList"].map((x) => PromotionList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn,
        "totalAmount": totalAmount,
        "totalFees": totalFees,
        "totalTaxes": totalTaxes,
        "totalDiscount": totalDiscount,
        "status": status,
        "hotelBookingDetails": hotelBookingDetails?.toMap(),
        "currency": currency,
        "locale": locale,
        "guestInfo": guestInfo == null
            ? null
            : List<dynamic>.from(guestInfo!.map((x) => x.toMap())),
        "customerInfo": customerInfo?.toMap(),
        "bookingForSomeoneElse": bookingForSomeoneElse,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap()))
      };
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
    this.customerId,
    this.membershipId,
  });

  final String? firstName;
  final String? lastName;
  final String? customerId;
  final String? membershipId;

  factory CustomerInfo.fromJson(String str) =>
      CustomerInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerInfo.fromMap(Map<String, dynamic> json) => CustomerInfo(
        firstName: json["firstName"],
        lastName: json["lastName"],
        customerId: json["customerId"],
        membershipId: json["membershipId"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "customerId": customerId,
        "membershipId": membershipId,
      };
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

  String toJson() => json.encode(toMap());

  factory GuestInfo.fromMap(Map<String, dynamic> json) => GuestInfo(
        firstName: json["firstName"],
        lastName: json["lastName"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "title": title,
      };
}

class HotelBookingDetails {
  HotelBookingDetails({
    this.hotelId,
    this.cityId,
    this.countryId,
    this.checkInDate,
    this.checkOutDate,
    this.roomCode,
    this.roomCategory,
    this.requestedRoomDetails,
    this.roomDetails,
    this.addOnServices,
    this.additionalNeedsTxt,
    this.fees,
    this.taxes,
    this.discount,
    this.freeFoodDelivery,
  });

  final String? hotelId;
  final String? cityId;
  final String? countryId;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String? roomCode;
  final String? roomCategory;
  final List<RequestedRoomDetail>? requestedRoomDetails;
  final RoomDetails? roomDetails;
  final List<AddOnService>? addOnServices;
  final String? additionalNeedsTxt;
  final double? fees;
  final double? taxes;
  final double? discount;
  final bool? freeFoodDelivery;

  factory HotelBookingDetails.fromJson(String str) =>
      HotelBookingDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelBookingDetails.fromMap(Map<String, dynamic> json) =>
      HotelBookingDetails(
        hotelId: json["hotelId"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        checkInDate: json["checkInDate"] == null
            ? null
            : DateTime.tryParse(json["checkInDate"]),
        checkOutDate: json["checkOutDate"] == null
            ? null
            : DateTime.tryParse(json["checkOutDate"]),
        roomCode: json["roomCode"],
        roomCategory: json["roomCategory"],
        requestedRoomDetails: json["requestedRoomDetails"] == null
            ? null
            : List<RequestedRoomDetail>.from(json["requestedRoomDetails"]
                .map((x) => RequestedRoomDetail.fromMap(x))),
        roomDetails: json["roomDetails"] == null
            ? null
            : RoomDetails.fromMap(json["roomDetails"]),
        addOnServices: json["addOnServices"] == null
            ? null
            : List<AddOnService>.from(
                json["addOnServices"].map((x) => AddOnService.fromMap(x))),
        additionalNeedsTxt: json["additionalNeedsTxt"],
        fees: json["fees"]?.toDouble(),
        taxes: json["taxes"]?.toDouble(),
        discount: json["discount"]?.toDouble(),
        freeFoodDelivery: json["freeFoodDelivery"],
      );

  Map<String, dynamic> toMap() => {
        "hotelId": hotelId,
        "cityId": cityId,
        "countryId": countryId,
        "checkInDate": checkInDate == null
            ? null
            : "${checkInDate?.year.toString().padLeft(4, '0')}-${checkInDate?.month.toString().padLeft(2, '0')}-${checkInDate?.day.toString().padLeft(2, '0')}",
        "checkOutDate": checkOutDate == null
            ? null
            : "${checkOutDate?.year.toString().padLeft(4, '0')}-${checkOutDate?.month.toString().padLeft(2, '0')}-${checkOutDate?.day.toString().padLeft(2, '0')}",
        "roomCode": roomCode,
        "roomCategory": roomCategory,
        "requestedRoomDetails": requestedRoomDetails == null
            ? null
            : List<dynamic>.from(requestedRoomDetails!.map((x) => x.toMap())),
        "roomDetails": roomDetails?.toMap(),
        "addOnServices": addOnServices == null
            ? null
            : List<dynamic>.from(addOnServices!.map((x) => x.toMap())),
        "additionalNeedsTxt": additionalNeedsTxt,
        "fees": fees,
        "taxes": taxes,
        "discount": discount,
        "freeFoodDelivery": freeFoodDelivery,
      };
}

class AddOnService {
  AddOnService({
    this.price,
    this.image,
    this.description,
    this.hotelServiceId,
    this.hotelServiceName,
    this.serviceDate,
    this.quantity,
    this.isFlightRequired,
  });

  final String? price;
  final String? image;
  final String? description;
  final String? hotelServiceId;
  final String? hotelServiceName;
  final DateTime? serviceDate;
  final int? quantity;
  final bool? isFlightRequired;

  factory AddOnService.fromJson(String str) =>
      AddOnService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddOnService.fromMap(Map<String, dynamic> json) => AddOnService(
        price: json["price"],
        image: json["image"],
        description: json["description"],
        hotelServiceId: json["hotelServiceId"],
        hotelServiceName: json["hotelServiceName"],
        serviceDate: json["serviceDate"] == null
            ? null
            : DateTime.tryParse(json["serviceDate"]),
        quantity: json["quantity"],
        isFlightRequired: json["isFlightRequired"],
      );

  Map<String, dynamic> toMap() => {
        "price": price,
        "image": image,
        "description": description,
        "hotelServiceId": hotelServiceId,
        "hotelServiceName": hotelServiceName,
        "serviceDate": serviceDate == null
            ? null
            : "${serviceDate?.year.toString().padLeft(4, '0')}-${serviceDate?.month.toString().padLeft(2, '0')}-${serviceDate?.day.toString().padLeft(2, '0')}",
        "quantity": quantity,
        "isFlightRequired": isFlightRequired,
      };
}

class RequestedRoomDetail {
  RequestedRoomDetail({
    this.roomType,
    this.adults,
    this.children,
    this.childAge1,
    this.childAge2,
  });

  final dynamic roomType;
  final int? adults;
  final int? children;
  final int? childAge1;
  final int? childAge2;

  factory RequestedRoomDetail.fromJson(String str) =>
      RequestedRoomDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RequestedRoomDetail.fromMap(Map<String, dynamic> json) =>
      RequestedRoomDetail(
        roomType: json["roomType"],
        adults: json["adults"],
        children: json["children"],
        childAge1: json["childAge1"],
        childAge2: json["childAge2"],
      );

  Map<String, dynamic> toMap() => {
        "roomType": roomType,
        "adults": adults,
        "children": children,
        "childAge1": childAge1,
        "childAge2": childAge2,
      };
}

class RoomDetails {
  RoomDetails({
    this.mealType,
    this.roomImage,
    this.roomCategories,
    this.facilities,
    this.cancellationPolicy,
    this.roomFacilities,
    this.totalPrice,
    this.perNightPrice,
    this.numberOfNights,
    this.rateKey,
    this.supplier,
    this.hotelName,
    this.hotelImage,
    this.discountPercent,
    this.nightPriceBeforeDiscount,
    this.specialPromotions,
  });

  final String? mealType;
  final dynamic roomImage;
  final List<RoomCategory>? roomCategories;
  final List<Facility>? facilities;
  final List<CancellationPolicy>? cancellationPolicy;
  final List<String>? roomFacilities;
  final double? totalPrice;
  final double? perNightPrice;
  final String? numberOfNights;
  final String? rateKey;
  final String? supplier;
  final String? hotelName;
  final String? hotelImage;
  final double? discountPercent;
  final double? nightPriceBeforeDiscount;
  final List<HotelBenefit>? specialPromotions;

  factory RoomDetails.fromJson(String str) =>
      RoomDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomDetails.fromMap(Map<String, dynamic> json) => RoomDetails(
        mealType: json["mealType"],
        roomImage: json["roomImage"],
        roomCategories: json["roomCategories"] == null
            ? null
            : List<RoomCategory>.from(
                json["roomCategories"].map((x) => RoomCategory.fromMap(x))),
        facilities: json["facilities"] == null
            ? null
            : List<Facility>.from(
                json["facilities"].map((x) => Facility.fromMap(x))),
        cancellationPolicy: json["cancellationPolicy"] == null
            ? null
            : List<CancellationPolicy>.from(json["cancellationPolicy"]
                .map((x) => CancellationPolicy.fromMap(x))),
        roomFacilities: json["roomFacilities"] == null
            ? null
            : List<String>.from(json["roomFacilities"].map((x) => x)),
        totalPrice: json["totalPrice"]?.toDouble(),
        perNightPrice: json["perNightPrice"]?.toDouble(),
        numberOfNights: json["numberOfNights"],
        rateKey: json["rateKey"],
        supplier: json["supplier"],
        hotelName: json["hotelName"],
        hotelImage: json["hotelImage"],
        discountPercent: json["discountPercent"]?.toDouble(),
        nightPriceBeforeDiscount: json["nightPriceBeforeDiscount"]?.toDouble(),
        specialPromotions: json["hotelBenefits"] == null
            ? null
            : List<HotelBenefit>.from(
                json["hotelBenefits"].map((x) => HotelBenefit.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "mealType": mealType,
        "roomImage": roomImage,
        "roomCategories": roomCategories == null
            ? null
            : List<dynamic>.from(roomCategories!.map((x) => x.toMap())),
        "facilities": facilities == null
            ? null
            : List<dynamic>.from(facilities!.map((x) => x.toMap())),
        "cancellationPolicy": cancellationPolicy == null
            ? null
            : List<dynamic>.from(cancellationPolicy!.map((x) => x.toMap())),
        "roomFacilities": roomFacilities == null
            ? null
            : List<dynamic>.from(roomFacilities!.map((x) => x)),
        "totalPrice": totalPrice,
        "perNightPrice": perNightPrice,
        "numberOfNights": numberOfNights,
        "rateKey": rateKey,
        "supplier": supplier,
        "hotelName": hotelName,
        "hotelImage": hotelImage,
        "discountPercent": discountPercent,
        "nightPriceBeforeDiscount": nightPriceBeforeDiscount,
        "hotelBenefits": specialPromotions == null
            ? null
            : List<dynamic>.from(specialPromotions!.map((x) => x.toMap()))
      };
}

class CancellationPolicy {
  CancellationPolicy({
    this.days,
    this.cancellationDaysDescription,
    this.cancellationChargeDescription,
    this.cancellationStatus,
  });

  final dynamic days;
  final dynamic cancellationDaysDescription;
  final dynamic cancellationChargeDescription;
  final String? cancellationStatus;

  factory CancellationPolicy.fromJson(String str) =>
      CancellationPolicy.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CancellationPolicy.fromMap(Map<String, dynamic> json) =>
      CancellationPolicy(
        days: json["days"],
        cancellationDaysDescription: json["cancellationDaysDescription"],
        cancellationChargeDescription: json["cancellationChargeDescription"],
        cancellationStatus: json["cancellationStatus"],
      );

  Map<String, dynamic> toMap() => {
        "days": days,
        "cancellationDaysDescription": cancellationDaysDescription,
        "cancellationChargeDescription": cancellationChargeDescription,
        "cancellationStatus": cancellationStatus,
      };
}

class HotelBenefit {
  HotelBenefit({
    this.longDescription,
    this.shortDescription,
  });

  final String? longDescription;
  final String? shortDescription;

  factory HotelBenefit.fromJson(String str) =>
      HotelBenefit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelBenefit.fromMap(Map<String, dynamic> json) => HotelBenefit(
        longDescription: json["longDescription"],
        shortDescription: json["shortDescription"],
      );

  Map<String, dynamic> toMap() => {
        "longDescription": longDescription,
        "shortDescription": shortDescription,
      };
}

class Facility {
  Facility({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory Facility.fromJson(String str) => Facility.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Facility.fromMap(Map<String, dynamic> json) => Facility(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": value,
      };
}

class RoomCategory {
  RoomCategory({
    this.noOfRoomsAndName,
    this.roomName,
    this.roomType,
    this.noOfRooms,
  });

  final String? noOfRoomsAndName;
  final String? roomName;
  final String? roomType;
  final int? noOfRooms;

  factory RoomCategory.fromJson(String str) =>
      RoomCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomCategory.fromMap(Map<String, dynamic> json) => RoomCategory(
        noOfRoomsAndName: json["noOfRoomsAndName"],
        roomName: json["roomName"],
        roomType: json["roomType"],
        noOfRooms: json["noOfRooms"],
      );

  Map<String, dynamic> toMap() => {
        "noOfRoomsAndName": noOfRoomsAndName,
        "roomName": roomName,
        "roomType": roomType,
        "noOfRooms": noOfRooms,
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
  final String? description;

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
