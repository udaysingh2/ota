import 'dart:convert';

class PlaylistResultModel {
  PlaylistResultModel({
    this.getPlaylists,
  });

  final GetPlaylists? getPlaylists;

  factory PlaylistResultModel.fromJson(String str) =>
      PlaylistResultModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaylistResultModel.fromMap(Map<String, dynamic> json) =>
      PlaylistResultModel(
        getPlaylists: json["getPlaylists"] == null
            ? null
            : GetPlaylists.fromMap(json["getPlaylists"]),
      );

  Map<String, dynamic> toMap() => {
        "getPlaylists": getPlaylists == null ? null : getPlaylists!.toMap(),
      };
}

class GetPlaylists {
  GetPlaylists({
    this.staticPlaylist,
    this.dynamicPlaylist,
  });

  final List<IcPlaylist>? staticPlaylist;
  final List<IcPlaylist>? dynamicPlaylist;

  factory GetPlaylists.fromJson(String str) =>
      GetPlaylists.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPlaylists.fromMap(Map<String, dynamic> json) => GetPlaylists(
        staticPlaylist: json["staticPlaylist"] == null
            ? []
            : _getStaticPlaylist(json["staticPlaylist"]),
        dynamicPlaylist: json["dynamicPlaylist"] == null
            ? []
            : List<IcPlaylist>.from(
                json["dynamicPlaylist"].map((x) => IcPlaylist.fromMap(x))),
      );

  static List<IcPlaylist> _getStaticPlaylist(List staticPlaylistJson) {
    List<IcPlaylist> staticPlaylist = [];
    for (var service in staticPlaylistJson) {
      String serviceName = service['serviceName'];
      String source = service['source'];
      if (service['playList'] != null) {
        service['playList'].forEach((playList) {
          IcPlaylist list = IcPlaylist.fromMap(playList);
          list.serviceName = serviceName;
          list.source = source;
          staticPlaylist.add(list);
        });
      }
    }

    return staticPlaylist;
  }

  Map<String, dynamic> toMap() => {
        "staticPlaylist": staticPlaylist == null
            ? null
            : List<dynamic>.from(staticPlaylist!.map((x) => x.toMap())),
        "dynamicPlaylist": dynamicPlaylist == null
            ? null
            : List<dynamic>.from(dynamicPlaylist!.map((x) => x.toMap())),
      };
}

class IcPlaylist {
  IcPlaylist({
    this.name,
    this.source,
    this.serviceName,
    this.list,
  });

  final String? name;
  String? source;
  String? serviceName;
  final List<ListElement>? list;

  factory IcPlaylist.fromJson(String str) =>
      IcPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IcPlaylist.fromMap(Map<String, dynamic> json) => IcPlaylist(
        name: json["name"],
        source: json["source"],
        serviceName: json["serviceName"],
        list: json["list"] == null
            ? []
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "source": source,
        "serviceName": serviceName,
        "list":
            list == null ? [] : List<dynamic>.from(list!.map((x) => x.toMap())),
      };
}

class ListElement {
  ListElement({
    this.hotelId,
    this.hotelName,
    this.rating,
    this.image,
    this.review,
    this.address,
    this.promotion,
    this.adminPromotion,
  });

  final String? hotelId;
  final String? hotelName;
  final int? rating;
  final String? image;
  final Review? review;
  final Address? address;
  final List<Promotion>? promotion;
  final AdminPromotion? adminPromotion;

  factory ListElement.fromJson(String str) =>
      ListElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
        hotelId: json["hotelId"],
        hotelName: json["hotelName"],
        rating: json["rating"],
        image: json["image"],
        review: json["review"] == null ? null : Review.fromMap(json["review"]),
        address:
            json["address"] == null ? null : Address.fromMap(json["address"]),
        promotion: json["promotion"] == null
            ? null
            : List<Promotion>.from(
                json["promotion"].map((x) => Promotion.fromMap(x))),
        adminPromotion: json["adminPromotion"] == null
            ? null
            : AdminPromotion.fromMap(json["adminPromotion"]),
      );

  Map<String, dynamic> toMap() => {
        "hotelId": hotelId,
        "hotelName": hotelName,
        "rating": rating,
        "image": image,
        "review": review == null ? null : review!.toMap(),
        "address": address == null ? null : address!.toMap(),
        "promotion": promotion == null
            ? null
            : List<dynamic>.from(promotion!.map((x) => x.toMap())),
        "adminPromotion":
            adminPromotion == null ? null : adminPromotion!.toMap(),
      };
}

class Address {
  Address({
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

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        locationId: json["locationId"],
        locationName: json["locationName"],
        address1: json["address1"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
        countryName: json["countryName"],
      );

  Map<String, dynamic> toMap() => {
        "locationId": locationId,
        "locationName": locationName,
        "address1": address1,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
        "countryName": countryName,
      };
}

class Review {
  Review({
    this.score,
    this.numReview,
    this.description,
  });

  final num? score;
  final int? numReview;
  final String? description;

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        score: json["score"],
        numReview: json["numReview"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "score": score,
        "numReview": numReview,
        "description": description,
      };
}

class Promotion {
  Promotion({
    this.promotionText,
  });

  final String? promotionText;

  factory Promotion.fromJson(String str) => Promotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Promotion.fromMap(Map<String, dynamic> json) => Promotion(
        promotionText: json["promotionText"],
      );

  Map<String, dynamic> toMap() => {
        "promotionText": promotionText,
      };
}

class AdminPromotion {
  AdminPromotion({
    this.promotionText1,
    this.promotionText2,
  });

  final String? promotionText1;
  final String? promotionText2;

  factory AdminPromotion.fromJson(String str) =>
      AdminPromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdminPromotion.fromMap(Map<String, dynamic> json) => AdminPromotion(
        promotionText1: json["promotionText1"],
        promotionText2: json["promotionText2"],
      );

  Map<String, dynamic> toMap() => {
        "promotionText1": promotionText1,
        "promotionText2": promotionText2,
      };
}
