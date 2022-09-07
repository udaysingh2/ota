class SecondaryViewModel {
  final String roomName;
  final String supplier;
  final String supplierId;
  final String supplierName;
  final String roomType;
  final double nightPrice;
  final double totalPrice;
  final RoomOffers? roomOffer;
  final Map<String, dynamic>? facilityList;
  final String roomCode;
  final String noOfRoomsAndName;
  final double? priceWithoutDiscount;
  final int? maxDiscount;
  final bool freeFoodDelivery;
  final String rating;
  final String address;
  final List<String> hotelBenefits;
  final String roomCatName;

  SecondaryViewModel({
    required this.roomName,
    required this.supplier,
    required this.supplierId,
    required this.supplierName,
    required this.roomType,
    required this.nightPrice,
    this.roomOffer,
    required this.totalPrice,
    this.facilityList,
    required this.roomCode,
    this.priceWithoutDiscount,
    this.maxDiscount,
    this.noOfRoomsAndName = "",
    this.freeFoodDelivery = false,
    this.rating = "",
    this.address = "",
    this.hotelBenefits = const [],
    this.roomCatName = "",
  });
}

class RoomOffers {
  RoomOffers({
    this.cancellationPolicy,
    this.payNow,
    this.breakfast,
    this.mealCode,
  });

  final String? cancellationPolicy;
  final String? payNow;
  final int? breakfast;
  final String? mealCode;
}
