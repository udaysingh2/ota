import 'dart:convert';

class CarPaymentDomainModel {
  CarPaymentDomainModel({
    this.data,
  });

  final CarPaymentDomainModelData? data;

  factory CarPaymentDomainModel.fromJson(String str) =>
      CarPaymentDomainModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarPaymentDomainModel.fromMap(Map<String, dynamic> json) =>
      CarPaymentDomainModel(
        data: json["data"] == null
            ? null
            : CarPaymentDomainModelData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}

class CarPaymentDomainModelData {
  CarPaymentDomainModelData({
    this.saveCarBookingConfirmationDetails,
  });

  final SaveCarBookingConfirmationDetails? saveCarBookingConfirmationDetails;

  factory CarPaymentDomainModelData.fromJson(String str) =>
      CarPaymentDomainModelData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarPaymentDomainModelData.fromMap(Map<String, dynamic> json) =>
      CarPaymentDomainModelData(
        saveCarBookingConfirmationDetails:
            json["saveCarBookingConfirmationDetails"] == null
                ? null
                : SaveCarBookingConfirmationDetails.fromMap(
                    json["saveCarBookingConfirmationDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "saveCarBookingConfirmationDetails":
            saveCarBookingConfirmationDetails == null
                ? null
                : saveCarBookingConfirmationDetails!.toMap(),
      };
}

class SaveCarBookingConfirmationDetails {
  SaveCarBookingConfirmationDetails({
    this.status,
    this.data,
  });

  final Status? status;
  final SaveCarBookingConfirmationDetailsData? data;

  factory SaveCarBookingConfirmationDetails.fromJson(String str) =>
      SaveCarBookingConfirmationDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SaveCarBookingConfirmationDetails.fromMap(
          Map<String, dynamic> json) =>
      SaveCarBookingConfirmationDetails(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null
            ? null
            : SaveCarBookingConfirmationDetailsData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
        "data": data == null ? null : data!.toMap(),
      };
}

class SaveCarBookingConfirmationDetailsData {
  SaveCarBookingConfirmationDetailsData(
      {this.bookingUrn,
      this.pricePerDay,
      this.carRentalTotalPrice,
      this.extrasOnlinePrice,
      this.extrasOfflinePrice,
      this.addOnServices,
      this.cancellationPolicy,
      this.currency,
      this.isNonRefund,
      this.returnExtraCharge});

  final String? bookingUrn;
  final String? pricePerDay;
  final double? carRentalTotalPrice;
  final double? extrasOnlinePrice;
  final double? extrasOfflinePrice;
  final List<AddOnService>? addOnServices;
  final List<CancellationPolicy>? cancellationPolicy;
  final String? currency;
  final String? isNonRefund;
  final double? returnExtraCharge;

  factory SaveCarBookingConfirmationDetailsData.fromJson(String str) =>
      SaveCarBookingConfirmationDetailsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SaveCarBookingConfirmationDetailsData.fromMap(
          Map<String, dynamic> json) =>
      SaveCarBookingConfirmationDetailsData(
        bookingUrn: json["bookingUrn"],
        pricePerDay: json["pricePerDay"],
        carRentalTotalPrice: json["carRentalTotalPrice"].toDouble(),
        extrasOnlinePrice: json["extrasOnlinePrice"].toDouble(),
        extrasOfflinePrice: json["extrasOfflinePrice"].toDouble(),
        addOnServices: json["addOnServices"] == null
            ? null
            : List<AddOnService>.from(
                json["addOnServices"].map((x) => AddOnService.fromMap(x))),
        cancellationPolicy: json["cancellationPolicy"] == null
            ? null
            : List<CancellationPolicy>.from(json["cancellationPolicy"]
                .map((x) => CancellationPolicy.fromMap(x))),
        currency: json["currency"],
        isNonRefund: json["isNonRefund"],
        returnExtraCharge: json['returnExtraCharge'] == null
            ? null
            : json["returnExtraCharge"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn,
        "pricePerDay": pricePerDay,
        "carRentalTotalPrice": carRentalTotalPrice,
        "extrasOnlinePrice": extrasOnlinePrice,
        "extrasOfflinePrice": extrasOfflinePrice,
        "addOnServices": addOnServices == null
            ? null
            : List<dynamic>.from(addOnServices!.map((x) => x.toMap())),
        "cancellationPolicy": cancellationPolicy == null
            ? null
            : List<dynamic>.from(cancellationPolicy!.map((x) => x.toMap())),
        "currency": currency,
        "isNonRefund": isNonRefund,
        "returnExtraCharge": returnExtraCharge
      };
}

class AddOnService {
  AddOnService({
    this.serviceId,
    this.name,
    this.price,
    this.isCompulsory,
    this.chargeType,
    this.quantity,
    this.description,
  });

  final String? serviceId;
  final String? name;
  final String? price;
  final bool? isCompulsory;
  final String? chargeType;
  final int? quantity;
  final String? description;

  factory AddOnService.fromJson(String str) =>
      AddOnService.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddOnService.fromMap(Map<String, dynamic> json) => AddOnService(
        serviceId: json["serviceId"],
        name: json["name"],
        price: json["price"],
        isCompulsory: json["isCompulsory"],
        chargeType: json["chargeType"],
        quantity: json["quantity"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "serviceId": serviceId,
        "name": name,
        "price": price,
        "isCompulsory": isCompulsory,
        "chargeType": chargeType,
        "quantity": quantity,
        "description": description,
      };
}

class CancellationPolicy {
  CancellationPolicy({
    this.cancelDays,
    this.message,
  });

  final int? cancelDays;
  final String? message;

  factory CancellationPolicy.fromJson(String str) =>
      CancellationPolicy.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CancellationPolicy.fromMap(Map<String, dynamic> json) =>
      CancellationPolicy(
        cancelDays: json["cancelDays"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "cancelDays": cancelDays,
        "message": message,
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
