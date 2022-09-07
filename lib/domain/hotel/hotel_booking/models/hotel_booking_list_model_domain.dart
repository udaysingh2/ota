import 'dart:convert';

class HotelBookingListModelDomain {
  HotelBookingListModelDomain({
    this.getBookingSummaryV2,
  });

  final GetBookingSummaryV2? getBookingSummaryV2;

  factory HotelBookingListModelDomain.fromJson(String str) =>
      HotelBookingListModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelBookingListModelDomain.fromMap(Map<String, dynamic> json) =>
      HotelBookingListModelDomain(
        getBookingSummaryV2: json["getBookingSummaryV2"] == null
            ? null
            : GetBookingSummaryV2.fromMap(json["getBookingSummaryV2"]),
      );

  Map<String, dynamic> toMap() => {
        "getBookingSummaryV2": getBookingSummaryV2?.toMap(),
      };
}

class GetBookingSummaryV2 {
  GetBookingSummaryV2({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetBookingSummaryV2.fromJson(String str) =>
      GetBookingSummaryV2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetBookingSummaryV2.fromMap(Map<String, dynamic> json) =>
      GetBookingSummaryV2(
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
    this.totalPageNumber,
    this.bookingDetails,
  });

  final int? totalPageNumber;
  final List<BookingDetail>? bookingDetails;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        totalPageNumber: json["totalPageNumber"],
        bookingDetails: json["bookingDetails"] == null
            ? null
            : List<BookingDetail>.from(
                json["bookingDetails"].map((x) => BookingDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalPageNumber": totalPageNumber,
        "bookingDetails": bookingDetails == null
            ? null
            : List<dynamic>.from(bookingDetails!.map((x) => x.toMap())),
      };
}

class BookingDetail {
  BookingDetail({
    this.serviceType,
    this.sortDateTime,
    this.sortPriority,
    this.hotel,
  });

  final String? serviceType;
  final String? sortDateTime;
  final int? sortPriority;
  final Hotel? hotel;

  factory BookingDetail.fromJson(String str) =>
      BookingDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookingDetail.fromMap(Map<String, dynamic> json) => BookingDetail(
        serviceType: json["serviceType"],
        sortDateTime: json["sortDateTime"],
        sortPriority: json["sortPriority"],
        hotel: json["hotel"] == null ? null : Hotel.fromMap(json["hotel"]),
      );

  Map<String, dynamic> toMap() => {
        "serviceType": serviceType,
        "sortDateTime": sortDateTime,
        "sortPriority": sortPriority,
        "hotel": hotel?.toMap(),
      };
}

class Hotel {
  Hotel({
    this.name,
    this.totalPrice,
    this.checkInDate,
    this.checkOutDate,
    this.bookingUrn,
    this.status,
    this.bookingId,
    this.paymentStatus,
    this.activityStatus,
  });

  final String? name;
  final double? totalPrice;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String? bookingUrn;
  final String? status;
  final String? bookingId;
  final String? paymentStatus;
  final String? activityStatus;

  factory Hotel.fromJson(String str) => Hotel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Hotel.fromMap(Map<String, dynamic> json) => Hotel(
        name: json["name"],
        totalPrice: json["totalPrice"]?.toDouble(),
        checkInDate: json["checkInDate"] == null
            ? null
            : DateTime.tryParse(json["checkInDate"]),
        checkOutDate: json["checkOutDate"] == null
            ? null
            : DateTime.tryParse(json["checkOutDate"]),
        bookingUrn: json["bookingUrn"],
        status: json["status"],
        bookingId: json["bookingId"],
        paymentStatus: json["paymentStatus"],
        activityStatus: json["activityStatus"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "totalPrice": totalPrice,
        "checkInDate": checkInDate == null
            ? null
            : "${checkInDate?.year.toString().padLeft(4, '0')}-${checkInDate?.month.toString().padLeft(2, '0')}-${checkInDate?.day.toString().padLeft(2, '0')}",
        "checkOutDate": checkOutDate == null
            ? null
            : "${checkOutDate?.year.toString().padLeft(4, '0')}-${checkOutDate?.month.toString().padLeft(2, '0')}-${checkOutDate?.day.toString().padLeft(2, '0')}",
        "bookingUrn": bookingUrn,
        "status": status,
        "bookingId": bookingId,
        "paymentStatus": paymentStatus,
        "activityStatus": activityStatus,
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
