import 'dart:convert';

class FavouritesResultModelDomainAutomation {
  FavouritesResultModelDomainAutomation({
    this.getAllFavorites,
  });

  final GetFavouritesResultModelAutomation? getAllFavorites;

  factory FavouritesResultModelDomainAutomation.fromJson(String str) =>
      FavouritesResultModelDomainAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavouritesResultModelDomainAutomation.fromMap(
      Map<String, dynamic> json) =>
      FavouritesResultModelDomainAutomation(
        getAllFavorites: json["getAllFavorites"] == null
            ? null
            : GetFavouritesResultModelAutomation.fromMap(
            json["getAllFavorites"]),
      );

  Map<String, dynamic> toMap() => {
    "getAllFavorites":
    getAllFavorites == null ? null : getAllFavorites!.toMap(),
  };
}

class GetFavouritesResultModelAutomation {
  GetFavouritesResultModelAutomation({
    this.data,
  });

  final DataAutomation? data;

  factory GetFavouritesResultModelAutomation.fromJson(String str) =>
      GetFavouritesResultModelAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetFavouritesResultModelAutomation.fromMap(
      Map<String, dynamic> json) =>
      GetFavouritesResultModelAutomation(
        data:
        json["data"] == null ? null : DataAutomation.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data!.toMap(),
  };
}

class DataAutomation {
  DataAutomation({
    this.favourites,
  });

  final List<FavouritesAutomation>? favourites;

  factory DataAutomation.fromJson(String str) =>
      DataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAutomation.fromMap(Map<String, dynamic> json) => DataAutomation(
    favourites: json["favorites"] == null
        ? null
        : List<FavouritesAutomation>.from(
        json["favorites"].map((x) => FavouritesAutomation.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "favorites": favourites == null
        ? null
        : List<dynamic>.from(favourites!.map((x) => x.toMap())),
  };
}

class FavouritesAutomation {
  final String hotelId;
  final String? hotelName;
  final String? location;
  final String? imageUrl;
  final String? cityId;
  final String? countryId;
  final double? latitude;
  final double? longitude;

  FavouritesAutomation({
    required this.hotelId,
    this.hotelName,
    this.location,
    this.imageUrl,
    this.cityId,
    this.countryId,
    this.latitude,
    this.longitude,
  });

  factory FavouritesAutomation.fromJson(String str) =>
      FavouritesAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavouritesAutomation.fromMap(Map<String, dynamic> json) =>
      FavouritesAutomation(
        hotelId: json["hotelId"],
        hotelName: json["hotelName"],
        location: json["location"],
        imageUrl: json["hotelImage"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
    "hotelId": hotelId,
    "hotelName": hotelName,
    "location": location,
    "hotelImage": imageUrl,
    "cityId": cityId,
    "countryId": countryId,
    "latitude": latitude,
    "longitude": longitude,
  };
}
