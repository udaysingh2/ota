import 'dart:convert';

class PlaylistResultModelAutomation {
  PlaylistResultModelAutomation({
    this.getPlaylists,
  });

  final GetPlaylistsAutomation? getPlaylists;

  factory PlaylistResultModelAutomation.fromJson(String str) =>
      PlaylistResultModelAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaylistResultModelAutomation.fromMap(Map<String, dynamic> json) =>
      PlaylistResultModelAutomation(
        getPlaylists: json["getPlaylists"] == null
            ? null
            : GetPlaylistsAutomation.fromMap(json["getPlaylists"]),
      );

  Map<String, dynamic> toMap() => {
        "getPlaylists": getPlaylists == null ? null : getPlaylists!.toMap(),
      };
}

class GetPlaylistsAutomation {
  GetPlaylistsAutomation({
    this.staticPlaylist,
    this.dynamicPlaylist,
  });

  final List<IcPlaylistAutomation>? staticPlaylist;
  final List<IcPlaylistAutomation>? dynamicPlaylist;

  factory GetPlaylistsAutomation.fromJson(String str) =>
      GetPlaylistsAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPlaylistsAutomation.fromMap(Map<String, dynamic> json) =>
      GetPlaylistsAutomation(
        staticPlaylist: json["staticPlaylist"] == null
            ? null
            : List<IcPlaylistAutomation>.from(json["staticPlaylist"]
                .map((x) => IcPlaylistAutomation.fromMap(x))),
        dynamicPlaylist: json["dynamicPlaylist"] == null
            ? null
            : List<IcPlaylistAutomation>.from(json["dynamicPlaylist"]
                .map((x) => IcPlaylistAutomation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "staticPlaylist": staticPlaylist == null
            ? null
            : List<dynamic>.from(staticPlaylist!.map((x) => x.toMap())),
        "dynamicPlaylist": dynamicPlaylist == null
            ? null
            : List<dynamic>.from(dynamicPlaylist!.map((x) => x.toMap())),
      };
}

class IcPlaylistAutomation {
  IcPlaylistAutomation({
    this.name,
    this.source,
    this.serviceName,
    this.list,
  });

  final String? name;
  final String? source;
  final String? serviceName;
  final List<ListElementAutomation>? list;

  factory IcPlaylistAutomation.fromJson(String str) =>
      IcPlaylistAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IcPlaylistAutomation.fromMap(Map<String, dynamic> json) =>
      IcPlaylistAutomation(
        name: json["name"] == null ? null : json["name"],
        source: json["source"] == null ? null : json["source"],
        serviceName: json["serviceName"] == null ? null : json["serviceName"],
        list: json["list"] == null
            ? null
            : List<ListElementAutomation>.from(
                json["list"].map((x) => ListElementAutomation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "source": source == null ? null : source,
        "serviceName": serviceName == null ? null : serviceName,
        "list": list == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toMap())),
      };
}

class ListElementAutomation {
  ListElementAutomation({
    this.hotelId,
    this.hotelName,
    this.rating,
    this.image,
    this.review,
    this.address,
    this.promotion,
  });

  final String? hotelId;
  final String? hotelName;
  final int? rating;
  final String? image;
  final ReviewAutomation? review;
  final AddressAutomation? address;
  final List<PromotionAutomation>? promotion;

  factory ListElementAutomation.fromJson(String str) =>
      ListElementAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElementAutomation.fromMap(Map<String, dynamic> json) =>
      ListElementAutomation(
        hotelId: json["hotelId"] == null ? null : json["hotelId"],
        hotelName: json["hotelName"] == null ? null : json["hotelName"],
        rating: json["rating"] == null ? null : json["rating"],
        image: json["image"] == null ? null : json["image"],
        review: json["review"] == null
            ? null
            : ReviewAutomation.fromMap(json["review"]),
        address: json["address"] == null
            ? null
            : AddressAutomation.fromMap(json["address"]),
        promotion: json["promotion"] == null
            ? null
            : List<PromotionAutomation>.from(
                json["promotion"].map((x) => PromotionAutomation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "hotelId": hotelId == null ? null : hotelId,
        "hotelName": hotelName == null ? null : hotelName,
        "rating": rating == null ? null : rating,
        "image": image == null ? null : image,
        "review": review == null ? null : review!.toMap(),
        "address": address == null ? null : address!.toMap(),
        "promotion": promotion == null
            ? null
            : List<dynamic>.from(promotion!.map((x) => x.toMap())),
      };
}

class AddressAutomation {
  AddressAutomation({
    this.locationId,
    this.locationName,
    this.address1,
    this.cityId,
    this.cityName,
    this.countryId,
    this.countryName,
  });

  final String? locationId;
  final String? locationName;
  final String? address1;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  final String? countryName;

  factory AddressAutomation.fromJson(String str) =>
      AddressAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressAutomation.fromMap(Map<String, dynamic> json) =>
      AddressAutomation(
        locationId: json["locationId"] == null ? null : json["locationId"],
        locationName:
            json["locationName"] == null ? null : json["locationName"],
        address1: json["address1"] == null ? null : json["address1"],
        cityId: json["cityId"] == null ? null : json["cityId"],
        cityName: json["cityName"] == null ? null : json["cityName"],
        countryId: json["countryId"] == null ? null : json["countryId"],
        countryName: json["countryName"] == null ? null : json["countryName"],
      );

  Map<String, dynamic> toMap() => {
        "locationId": locationId == null ? null : locationId,
        "locationName": locationName == null ? null : locationName,
        "address1": address1 == null ? null : address1,
        "cityId": cityId == null ? null : cityId,
        "cityName": cityName == null ? null : cityName,
        "countryId": countryId == null ? null : countryId,
        "countryName": countryName == null ? null : countryName,
      };
}

class ReviewAutomation {
  ReviewAutomation({
    this.score,
    this.numReview,
    this.description,
  });

  final num? score;
  final int? numReview;
  final String? description;

  factory ReviewAutomation.fromJson(String str) =>
      ReviewAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReviewAutomation.fromMap(Map<String, dynamic> json) =>
      ReviewAutomation(
        score: json["score"] == null ? null : json["score"],
        numReview: json["numReview"] == null ? null : json["numReview"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "score": score == null ? null : score,
        "numReview": numReview == null ? null : numReview,
        "description": description == null ? null : description,
      };
}

class PromotionAutomation {
  PromotionAutomation({
    this.promotionText,
  });

  final String? promotionText;

  factory PromotionAutomation.fromJson(String str) =>
      PromotionAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PromotionAutomation.fromMap(Map<String, dynamic> json) =>
      PromotionAutomation(
        promotionText:
            json["promotionText"] == null ? null : json["promotionText"],
      );

  Map<String, dynamic> toMap() => {
        "promotionText": promotionText == null ? null : promotionText,
      };
}
