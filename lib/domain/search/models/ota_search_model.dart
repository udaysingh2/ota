// To parse this JSON data, do
//
//     final otaSearch = otaSearchFromMap(jsonString);

import 'dart:convert';

class OtaSearch {
  OtaSearch({
    this.data,
  });

  final OtaSearchData? data;

  factory OtaSearch.fromJson(String str) => OtaSearch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaSearch.fromMap(Map<String, dynamic> json) => OtaSearch(
        data: json["data"] == null ? null : OtaSearchData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class OtaSearchData {
  OtaSearchData({
    this.getOtaSearchResult,
  });

  final GetOtaSearchResult? getOtaSearchResult;

  factory OtaSearchData.fromJson(String str) =>
      OtaSearchData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaSearchData.fromMap(Map<String, dynamic> json) => OtaSearchData(
        getOtaSearchResult: json["getOtaSearchResult"] == null
            ? null
            : GetOtaSearchResult.fromMap(json["getOtaSearchResult"]),
      );

  Map<String, dynamic> toMap() => {
        "getOtaSearchResult": getOtaSearchResult?.toMap(),
      };
}

class GetOtaSearchResult {
  GetOtaSearchResult({
    this.status,
    this.data,
  });

  final Status? status;
  final GetOtaSearchResultData? data;

  factory GetOtaSearchResult.fromJson(String str) =>
      GetOtaSearchResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetOtaSearchResult.fromMap(Map<String, dynamic> json) =>
      GetOtaSearchResult(
        data: json["data"] == null
            ? null
            : GetOtaSearchResultData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class GetOtaSearchResultData {
  GetOtaSearchResultData({
    this.lastPageFlag,
    this.hotel,
    this.flight,
    this.car,
    this.tourActivity,
    this.ticketActivity,
  });

  final bool? lastPageFlag;
  final Hotel? hotel;
  final Flight? flight;
  final CarRental? car;
  final TourActivity? tourActivity;
  final TicketActivity? ticketActivity;

  factory GetOtaSearchResultData.fromJson(String str) =>
      GetOtaSearchResultData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetOtaSearchResultData.fromMap(Map<String, dynamic> json) =>
      GetOtaSearchResultData(
        lastPageFlag: json["lastPageFlag"] != null
            ? json["lastPageFlag"].toString().toLowerCase() == 'true'
            : true,
        hotel: json["hotel"] == null ? null : Hotel.fromMap(json["hotel"]),
        flight: json["flight"] == null ? null : Flight.fromMap(json["flight"]),
        car: json["carRental"] == null
            ? null
            : CarRental.fromMap(json["carRental"]),
        tourActivity: json["tourActivity"] == null
            ? null
            : TourActivity.fromMap(json["tourActivity"]),
        ticketActivity: json["ticketActivity"] == null
            ? null
            : TicketActivity.fromMap(json["ticketActivity"]),
      );

  Map<String, dynamic> toMap() => {
        "lastPageFlag": lastPageFlag,
        "hotel": hotel?.toMap(),
        "flight": flight?.toMap(),
        "carRental": car?.toMap(),
        "tourActivity": tourActivity?.toMap(),
        "ticketActivity": ticketActivity?.toMap(),
      };
}

class Flight {
  Flight();

  factory Flight.fromJson(String str) => Flight.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Flight.fromMap(Map<String, dynamic> json) => Flight();

  Map<String, dynamic> toMap() => {};
}

CarRental carRentalFromMap(String str) => CarRental.fromMap(json.decode(str));

String carRentalToMap(CarRental data) => json.encode(data.toMap());

class CarRental {
  CarRental({
    this.carModelList,
    this.pickupLocationId,
    this.returnLocationId,
  });

  final List<CarModelList>? carModelList;
  final String? pickupLocationId;
  final String? returnLocationId;

  factory CarRental.fromMap(Map<String, dynamic> json) => CarRental(
        carModelList: json["carModelList"] == null
            ? null
            : List<CarModelList>.from(
                json["carModelList"].map((x) => CarModelList.fromMap(x))),
        pickupLocationId: json["pickupLocationId"],
        returnLocationId: json["returnLocationId"],
      );

  Map<String, dynamic> toMap() => {
        "carModelList": List<dynamic>.from(carModelList!.map((x) => x.toMap())),
        "pickupLocationId": pickupLocationId,
        "returnLocationId": returnLocationId,
      };
}

class CarModelList {
  CarModelList(
      {this.carId,
      this.brandId,
      this.brandName,
      this.suppliers,
      this.overlayPromotion,
      this.modelName,
      this.images,
      this.carInfo,
      this.capsulePromotion});

  final int? carId;
  final int? brandId;
  final String? brandName;
  final List<Supplier>? suppliers;
  final OverlayPromotion? overlayPromotion;
  final String? modelName;
  final Images? images;
  final CarInfo? carInfo;
  List<CapsulePromotion>? capsulePromotion;

  factory CarModelList.fromMap(Map<String, dynamic> json) => CarModelList(
        carId: json["carId"],
        brandId: json["brandId"],
        brandName: json["brandName"],
        suppliers: json["suppliers"] == null
            ? null
            : List<Supplier>.from(
                json["suppliers"].map((x) => Supplier.fromMap(x))),
        overlayPromotion: json["overlayPromotion"] == null
            ? null
            : OverlayPromotion.fromMap(json["overlayPromotion"]),
        modelName: json["modelName"],
        images: Images.fromMap(json["images"]),
        carInfo: CarInfo.fromMap(json["carInfo"]),
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CapsulePromotion.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "carId": carId,
        "brandId": brandId,
        "brandName": brandName,
        "suppliers": List<dynamic>.from(suppliers!.map((x) => x.toMap())),
        "overlayPromotion": overlayPromotion?.toMap(),
        "modelName": modelName,
        "images": images?.toMap(),
        "carInfo": carInfo?.toMap(),
      };
}

class CarInfo {
  CarInfo({
    this.carTypeName,
    this.carTypeId,
  });

  final String? carTypeName;
  final int? carTypeId;

  factory CarInfo.fromMap(Map<String, dynamic> json) => CarInfo(
        carTypeName: json["carTypeName"],
        carTypeId: json["carTypeId"],
      );

  Map<String, dynamic> toMap() => {
        "carTypeName": carTypeName,
        "carTypeId": carTypeId,
      };
}

class OverlayPromotion {
  OverlayPromotion({
    this.adminPromotionLine1,
    this.adminPromotionLine2,
  });
  final String? adminPromotionLine1;
  final String? adminPromotionLine2;

  factory OverlayPromotion.fromJson(String str) =>
      OverlayPromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OverlayPromotion.fromMap(Map<String, dynamic> json) =>
      OverlayPromotion(
        adminPromotionLine1: json["adminPromotionLine1"],
        adminPromotionLine2: json["adminPromotionLine2"],
      );

  Map<String, dynamic> toMap() => {
        "adminPromotionLine1": adminPromotionLine1,
        "adminPromotionLine2": adminPromotionLine2,
      };
}

class Images {
  Images({
    this.full,
    this.thumb,
  });

  final String? full;
  final String? thumb;

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        full: json["full"],
        thumb: json["thumb"],
      );

  Map<String, dynamic> toMap() => {
        "full": full,
        "thumb": thumb,
      };
}

class Supplier {
  Supplier({
    this.pickupCounter,
    this.returnCounter,
  });

  final Counter? pickupCounter;
  final Counter? returnCounter;

  factory Supplier.fromMap(Map<String, dynamic> json) => Supplier(
        pickupCounter: Counter.fromMap(json["pickupCounter"]),
        returnCounter: Counter.fromMap(json["returnCounter"]),
      );

  Map<String, dynamic> toMap() => {
        "pickupCounter": pickupCounter?.toMap(),
        "returnCounter": returnCounter?.toMap(),
      };
}

class Counter {
  Counter({
    this.locationId,
    this.address,
    this.name,
    this.description,
  });

  final String? locationId;
  final String? address;
  final String? name;
  final String? description;

  factory Counter.fromMap(Map<String, dynamic> json) => Counter(
        locationId: json["locationId"],
        address: json["address"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "locationId": locationId,
        "address": address,
        "name": name,
        "description": description,
      };
}

class Hotel {
  Hotel({
    this.hotelList,
    this.filter,
  });

  final List<HotelList>? hotelList;
  final Filter? filter;

  factory Hotel.fromJson(String str) => Hotel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Hotel.fromMap(Map<String, dynamic> json) => Hotel(
        hotelList: json["hotelList"] == null
            ? null
            : List<HotelList>.from(
                json["hotelList"].map((x) => HotelList.fromMap(x))),
        filter: json["filter"] == null ? null : Filter.fromMap(json["filter"]),
      );

  Map<String, dynamic> toMap() => {
        "hotelList": hotelList == null
            ? null
            : List<dynamic>.from(hotelList!.map((x) => x.toMap())),
        "filter": filter?.toMap(),
      };
}

class Filter {
  Filter({
    this.minPrice,
    this.maxPrice,
    this.rating,
    this.promotion,
    this.reviewScore,
    this.adminPromotion,
    this.capsulePromotion,
    this.infotechPromotion,
    this.availableHotel,
    this.sha,
  });

  final int? minPrice;
  final int? maxPrice;
  final List<int>? rating;
  final List<dynamic>? promotion;
  final List<double>? reviewScore;
  final List<String>? adminPromotion;
  final List<CapsulePromotion>? capsulePromotion;
  final List<String>? infotechPromotion;
  final bool? availableHotel;
  final List<String>? sha;

  factory Filter.fromJson(String str) => Filter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Filter.fromMap(Map<String, dynamic> json) => Filter(
        minPrice: json["minPrice"] == null
            ? null
            : (double.tryParse('${json["minPrice"]}') ?? 0.0).round(),
        maxPrice: json["maxPrice"] == null
            ? null
            : (double.tryParse('${json["maxPrice"]}') ?? 0.0).round(),
        rating: json["rating"] == null
            ? null
            : List<int>.generate(
                (json["rating"] as List).length,
                (index) =>
                    (double.tryParse('${(json["rating"] as List)[index]}') ??
                            0.0)
                        .round(),
              ),
        promotion: json["promotion"] == null
            ? null
            : List<dynamic>.from(json["promotion"].map((x) => x)),
        reviewScore: json["reviewScore"] == null
            ? null
            : List<double>.generate(
                (json["reviewScore"] as List).length,
                (index) =>
                    double.tryParse(
                        '${(json["reviewScore"] as List)[index]}') ??
                    0.0,
              ),
        adminPromotion: json["adminPromotion"] == null
            ? null
            : List<String>.from(json["adminPromotion"].map((x) => x)),
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CapsulePromotion.fromMap(x))),
        infotechPromotion: json["infotechPromotion"] == null
            ? null
            : List<String>.from(json["infotechPromotion"].map((x) => x)),
        availableHotel: json["availableHotel"],
        sha: json["sha"] == null
            ? null
            : List<String>.from(json["sha"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "minPrice": minPrice,
        "maxPrice": maxPrice,
        "rating":
            rating == null ? null : List<dynamic>.from(rating!.map((x) => x)),
        "promotion": promotion == null
            ? null
            : List<dynamic>.from(promotion!.map((x) => x)),
        "reviewScore": reviewScore == null
            ? null
            : List<dynamic>.from(reviewScore!.map((x) => x)),
        "adminPromotion": adminPromotion == null
            ? null
            : List<dynamic>.from(adminPromotion!.map((x) => x)),
        "capsulePromotion": capsulePromotion == null
            ? null
            : List<dynamic>.from(capsulePromotion!.map((x) => x.toMap())),
        "infotechPromotion": infotechPromotion == null
            ? null
            : List<dynamic>.from(infotechPromotion!.map((x) => x)),
        "availableHotel": availableHotel,
        "sha": sha == null ? null : List<dynamic>.from(sha!.map((x) => x)),
      };
}

class CapsulePromotion {
  CapsulePromotion({
    this.name,
    this.code,
  });

  final String? name;
  final String? code;

  factory CapsulePromotion.fromJson(String str) =>
      CapsulePromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CapsulePromotion.fromMap(Map<String, dynamic> json) =>
      CapsulePromotion(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
      };
}

class HotelList {
  HotelList({
    this.sortSequence,
    this.hotelId,
    this.hotelName,
    this.rating,
    this.locationName,
    this.address,
    this.countryId,
    this.hotelStatus,
    this.hotelImage,
    this.percentageDiscount,
    this.rackRate,
    this.rackRatePerNight,
    this.totalPrice,
    this.pricePerNight,
    this.ratingTitle,
    this.reviewText,
    this.offerPercent,
    this.discount,
    this.adminPromotionLine1,
    this.adminPromotionLine2,
    this.capsulePromotion,
    this.review,
    this.cityName,
    this.score,
    this.infotech11Promo,
  });

  final int? sortSequence;
  final String? hotelId;
  final String? hotelName;
  final String? hotelImage;
  final int? rating;
  final String? address;
  final double? totalPrice;
  final double? pricePerNight;
  final String? ratingTitle;
  final String? reviewText;
  final String? offerPercent;
  final String? score;
  final String? discount;
  final String? locationName;
  final String? countryId;
  final String? hotelStatus;
  final int? percentageDiscount;
  final double? rackRate;
  final double? rackRatePerNight;
  final String? adminPromotionLine1;
  final String? adminPromotionLine2;
  final List<CapsulePromotion>? capsulePromotion;
  final Review? review;
  final String? cityName;
  final List<String>? infotech11Promo;

  factory HotelList.fromJson(String str) => HotelList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelList.fromMap(Map<String, dynamic> json) => HotelList(
        sortSequence: json["sortSequence"],
        hotelId: json["hotelId"],
        hotelName: json["hotelName"],
        hotelImage: json["hotelImage"],
        rating: json["rating"] == null
            ? null
            : (double.tryParse('${json["rating"]}') ?? 0.0).round(),
        address: json["address"],
        ratingTitle: json["ratingTitle"],
        reviewText: json["reviewText"],
        offerPercent: json["offerPercent"],
        score: json["score"],
        discount: json["discount"],
        totalPrice: json["totalPrice"]?.toDouble(),
        pricePerNight: json["pricePerNight"]?.toDouble(),
        locationName: json["locationName"],
        countryId: json["countryId"],
        hotelStatus: json["hotelStatus"],
        percentageDiscount: json["percentageDiscount"],
        rackRate: json["rackRate"]?.toDouble(),
        rackRatePerNight: json["rackRatePerNight"]?.toDouble(),
        adminPromotionLine1: json["adminPromotionLine1"],
        adminPromotionLine2: json["adminPromotionLine2"],
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CapsulePromotion.fromMap(x))),
        review: json["review"] == null ? null : Review.fromMap(json["review"]),
        cityName: json["cityName"],
        infotech11Promo: json["infotech11Promo"] == null
            ? null
            : List<String>.from(json["infotech11Promo"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "locationName": locationName,
        "countryId": countryId,
        "address": address,
        "sortSequence": sortSequence,
        "hotelStatus": hotelStatus,
        "hotelId": hotelId,
        "hotelName": hotelName,
        "hotelImage": hotelImage,
        "rating": rating,
        "percentageDiscount": percentageDiscount,
        "rackRate": rackRate,
        "rackRatePerNight": rackRatePerNight,
        "totalPrice": totalPrice,
        "pricePerNight": pricePerNight,
        "ratingTitle": ratingTitle,
        "reviewText": reviewText,
        "offerPercent": offerPercent,
        "discount": discount,
        "adminPromotionLine1": adminPromotionLine1,
        "adminPromotionLine2": adminPromotionLine2,
        "capsulePromotion": capsulePromotion == null
            ? null
            : List<dynamic>.from(capsulePromotion!.map((x) => x.toMap())),
        "review": review?.toMap(),
        "cityName": cityName,
        "score": score,
        "infotech11Promo": infotech11Promo == null
            ? null
            : List<dynamic>.from(infotech11Promo!.map((x) => x)),
      };
}

class Review {
  Review({
    this.score,
    this.totalReview,
    this.reviewText,
  });

  final int? score;
  final int? totalReview;
  final String? reviewText;

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        score: json["score"],
        totalReview: json["totalReview"],
        reviewText: json["reviewText"],
      );

  Map<String, dynamic> toMap() => {
        "score": score,
        "totalReview": totalReview,
        "reviewText": reviewText,
      };
}

class TicketActivity {
  TicketActivity({
    this.filter,
    this.ticketActivityList,
  });

  final ActivityFilter? filter;
  final List<ActivityList>? ticketActivityList;

  factory TicketActivity.fromMap(Map<String, dynamic> json) => TicketActivity(
        filter: json["filter"] == null
            ? null
            : ActivityFilter.fromMap(json["filter"]),
        ticketActivityList: json["ticketActivityList"] == null
            ? null
            : List<ActivityList>.from(
                json["ticketActivityList"].map((x) => ActivityList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "filter": filter?.toMap(),
        "ticketActivityList": ticketActivityList == null
            ? null
            : List<dynamic>.from(ticketActivityList!.map((x) => x.toMap())),
      };
}

class ActivityFilter {
  ActivityFilter({
    this.minPrice,
    this.maxPrice,
    this.styleName,
  });

  final double? minPrice;
  final double? maxPrice;
  final List<String>? styleName;

  factory ActivityFilter.fromMap(Map<String, dynamic> json) => ActivityFilter(
        minPrice: json["minPrice"]?.toDouble(),
        maxPrice: json["maxPrice"]?.toDouble(),
        styleName: json["styleName"] == null
            ? null
            : List<String>.from(json["styleName"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "minPrice": minPrice,
        "maxPrice": maxPrice,
        "styleName": styleName == null
            ? null
            : List<dynamic>.from(styleName!.map((x) => x)),
      };
}

class ActivityList {
  ActivityList({
    this.id,
    this.name,
    this.styleName,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.countryName,
    this.imageUrl,
    this.startPrice,
    this.promotionTextLine1,
    this.promotionTextLine2,
    this.capsulePromotion,
  });

  final String? id;
  final String? name;
  final String? styleName;
  final String? locationName;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  final String? countryName;
  final String? imageUrl;
  final double? startPrice;
  final String? promotionTextLine1;
  final String? promotionTextLine2;
  final List<CapsulePromotion>? capsulePromotion;

  factory ActivityList.fromMap(Map<String, dynamic> json) => ActivityList(
        id: json["id"],
        name: json["name"],
        styleName: json["styleName"],
        locationName: json["locationName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
        countryName: json["countryName"],
        imageUrl: json["imageUrl"],
        startPrice: json["startPrice"]?.toDouble(),
        promotionTextLine1: json["promotionText_line1"],
        promotionTextLine2: json["promotionText_line2"],
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CapsulePromotion.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "styleName": styleName,
        "locationName": locationName,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
        "countryName": countryName,
        "imageUrl": imageUrl,
        "startPrice": startPrice,
        "promotionText_line1": promotionTextLine1,
        "promotionText_line2": promotionTextLine2,
        "capsulePromotion": capsulePromotion == null
            ? null
            : List<dynamic>.from(capsulePromotion!.map((x) => x.toMap())),
      };
}

class TourActivity {
  TourActivity({
    this.filter,
    this.tourActivityList,
  });

  final ActivityFilter? filter;
  final List<ActivityList>? tourActivityList;

  factory TourActivity.fromMap(Map<String, dynamic> json) => TourActivity(
        filter: json["filter"] == null
            ? null
            : ActivityFilter.fromMap(json["filter"]),
        tourActivityList: json["tourActivityList"] == null
            ? null
            : List<ActivityList>.from(
                json["tourActivityList"].map((x) => ActivityList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "filter": filter?.toMap(),
        "tourActivityList": tourActivityList == null
            ? null
            : List<dynamic>.from(tourActivityList!.map((x) => x.toMap())),
      };
}

class Status {
  Status({
    this.code,
    this.description,
    this.header,
  });

  final String? code;
  final String? description;
  final String? header;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        description: json["description"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "description": description,
        "header": header,
      };
}
