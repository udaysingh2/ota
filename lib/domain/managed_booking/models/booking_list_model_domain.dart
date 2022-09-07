import 'dart:convert';

class BookingListModelDomain {
  BookingListModelDomain({
    this.getBookingSummaryV2,
  });

  final GetBookingSummaryV2? getBookingSummaryV2;

  factory BookingListModelDomain.fromJson(String str) =>
      BookingListModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookingListModelDomain.fromMap(Map<String, dynamic> json) =>
      BookingListModelDomain(
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
    this.tour,
    this.car,
    this.flight,
  });

  final String? serviceType;
  final String? sortDateTime;
  final int? sortPriority;
  final Hotel? hotel;
  final Tour? tour;
  final Car? car;
  final Flight? flight;

  factory BookingDetail.fromJson(String str) =>
      BookingDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookingDetail.fromMap(Map<String, dynamic> json) => BookingDetail(
        serviceType: json["serviceType"],
        sortDateTime: json["sortDateTime"],
        sortPriority: json["sortPriority"],
        hotel: json["hotel"] == null ? null : Hotel.fromMap(json["hotel"]),
        tour: json["tour"] == null ? null : Tour.fromMap(json["tour"]),
        car: json["car"] == null ? null : Car.fromMap(json["car"]),
        flight: json["flight"] == null ? null : Flight.fromMap(json["flight"]),
      );

  Map<String, dynamic> toMap() => {
        "serviceType": serviceType,
        "sortDateTime": sortDateTime,
        "sortPriority": sortPriority,
        "hotel": hotel?.toMap(),
        "tour": tour?.toMap(),
        "car": car?.toMap(),
        "flight": flight?.toMap(),
      };
}

class Car {
  Car(
      {this.name,
      this.totalPrice,
      this.supplierName,
      this.bookingUrn,
      this.status,
      this.bookingSummaryStatus,
      this.pickupDateTime,
      this.returnDateTime,
      this.bookingId,
      this.returnExtraCharge});

  final String? name;
  final double? totalPrice;
  final String? supplierName;
  final String? bookingUrn;
  final String? status;
  final String? bookingSummaryStatus;
  final DateTime? pickupDateTime;
  final DateTime? returnDateTime;
  final String? bookingId;
  final double? returnExtraCharge;

  factory Car.fromJson(String str) => Car.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Car.fromMap(Map<String, dynamic> json) => Car(
      name: json["name"],
      totalPrice: json["totalPrice"]?.toDouble(),
      supplierName: json["supplierName"],
      bookingUrn: json["bookingUrn"],
      status: json["status"],
      bookingSummaryStatus: json["bookingSummaryStatus"],
      pickupDateTime: json["pickupDateTime"] == null
          ? null
          : DateTime.parse(json["pickupDateTime"]),
      returnDateTime: json["returnDateTime"] == null
          ? null
          : DateTime.parse(json["returnDateTime"]),
      bookingId: json["bookingId"],
      returnExtraCharge: json["returnExtraCharge"]?.toDouble());

  Map<String, dynamic> toMap() => {
        "name": name,
        "totalPrice": totalPrice,
        "supplierName": supplierName,
        "bookingUrn": bookingUrn,
        "status": status,
        "bookingSummaryStatus": bookingSummaryStatus,
        "pickupDateTime": pickupDateTime,
        "returnDateTime": returnDateTime,
        "bookingId": bookingId,
        "returnExtraCharge": returnExtraCharge
      };
}

class Flight {
  Flight({
    this.reservationId,
    this.bookingUrn,
    this.bookingStatus,
    this.activityStatus,
    this.totalAmount,
    this.journeyType,
    this.departureDetails,
    this.returnDetails,
  });

  final String? reservationId;
  final String? bookingUrn;
  final String? bookingStatus;
  final String? activityStatus;
  final double? totalAmount;
  final int? journeyType;
  final Details? departureDetails;
  final Details? returnDetails;

  factory Flight.fromJson(String str) => Flight.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Flight.fromMap(Map<String, dynamic> json) => Flight(
        reservationId: json["reservationId"],
        bookingUrn: json["bookingUrn"],
        bookingStatus: json["bookingStatus"],
        activityStatus: json["activityStatus"],
        totalAmount: json["totalAmount"]?.toDouble(),
        journeyType: json["journeyType"],
        departureDetails: json["departureDetails"] == null
            ? null
            : Details.fromMap(json["departureDetails"]),
        returnDetails: json["returnDetails"] == null
            ? null
            : Details.fromMap(json["returnDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "reservationId": reservationId,
        "bookingUrn": bookingUrn,
        "bookingStatus": bookingStatus,
        "activityStatus": activityStatus,
        "totalAmount": totalAmount,
        "journeyType": journeyType,
        "departureDetails": departureDetails?.toMap(),
        "returnDetails": returnDetails?.toMap(),
      };
}

class Details {
  Details({
    this.arrCode,
    this.depCode,
    this.depDate,
    this.arrDate,
    this.numOfStops,
    this.airwaysCode,
    this.routeInfo,
  });

  final String? arrCode;
  final String? depCode;
  final String? depDate;
  final String? arrDate;
  final int? numOfStops;
  final String? airwaysCode;
  final List<RouteInfo>? routeInfo;

  factory Details.fromJson(String str) => Details.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Details.fromMap(Map<String, dynamic> json) => Details(
        arrCode: json["arrCode"],
        depCode: json["depCode"],
        depDate: json["depDate"],
        arrDate: json["arrDate"],
        numOfStops: json["numOfStops"],
        airwaysCode: json["airwaysCode"],
        routeInfo: json["routeInfo"] == null
            ? null
            : List<RouteInfo>.from(
                json["routeInfo"].map((x) => RouteInfo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "arrCode": arrCode,
        "depCode": depCode,
        "depDate": depDate,
        "arrDate": arrDate,
        "numOfStops": numOfStops,
        "airwaysCode": airwaysCode,
        "routeInfo": routeInfo == null
            ? null
            : List<dynamic>.from(routeInfo!.map((x) => x.toMap())),
      };
}

class RouteInfo {
  RouteInfo({
    this.airwaysName,
    this.flightLogo,
    this.depDate,
    this.arrDate,
  });

  final String? airwaysName;
  final String? flightLogo;
  final String? depDate;
  final String? arrDate;

  factory RouteInfo.fromJson(String str) => RouteInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RouteInfo.fromMap(Map<String, dynamic> json) => RouteInfo(
        airwaysName: json["airwaysName"],
        flightLogo: json["flightLogo"],
        depDate: json["depDate"],
        arrDate: json["arrDate"],
      );

  Map<String, dynamic> toMap() => {
        "airwaysName": airwaysName,
        "flightLogo": flightLogo,
        "depDate": depDate,
        "arrDate": arrDate,
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
  final String? checkInDate;
  final String? checkOutDate;
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
        checkInDate: json["checkInDate"],
        checkOutDate: json["checkOutDate"],
        bookingUrn: json["bookingUrn"],
        status: json["status"],
        bookingId: json["bookingId"],
        paymentStatus: json["paymentStatus"],
        activityStatus: json["activityStatus"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "totalPrice": totalPrice,
        "checkInDate": checkInDate,
        "checkOutDate": checkOutDate,
        "bookingUrn": bookingUrn,
        "status": status,
        "bookingId": bookingId,
        "paymentStatus": paymentStatus,
        "activityStatus": activityStatus,
      };
}

class Tour {
  Tour({
    this.subServiceType,
    this.name,
    this.totalPrice,
    this.startTimeAmpm,
    this.bookingUrn,
    this.status,
    this.bookingDate,
    this.bookingId,
    this.paymentStatus,
    this.activityStatus,
  });

  final String? subServiceType;
  final String? name;
  final double? totalPrice;
  final String? startTimeAmpm;
  final String? bookingUrn;
  final String? status;
  final String? bookingDate;
  final String? bookingId;
  final String? paymentStatus;
  final String? activityStatus;

  factory Tour.fromJson(String str) => Tour.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tour.fromMap(Map<String, dynamic> json) => Tour(
        subServiceType: json["subServiceType"],
        name: json["name"],
        totalPrice: json["totalPrice"]?.toDouble(),
        startTimeAmpm: json["startTimeAMPM"],
        bookingUrn: json["bookingUrn"],
        status: json["status"],
        bookingDate: json["bookingDate"],
        bookingId: json["bookingId"],
        paymentStatus: json["paymentStatus"],
        activityStatus: json["activityStatus"],
      );

  Map<String, dynamic> toMap() => {
        "subServiceType": subServiceType,
        "name": name,
        "totalPrice": totalPrice,
        "startTimeAMPM": startTimeAmpm,
        "bookingUrn": bookingUrn,
        "status": status,
        "bookingDate": bookingDate,
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
