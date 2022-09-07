class HotelSuccessPaymentArgumentModel {
  String? currency;
  String? roomCode;
  String? hotelId;
  DateTime? checkInDate;
  DateTime? checkOutDate;
  List<RoomDetails>? roomDetailsList;
  List<FacilityList>? facilityMap;
  String? cancellationPolicyStatus;
  String? offerName;
  String? propertyName;
  double? pricePerNight;
  String? imageUrl;
  int? numberOfNights;
  int? numberOfRooms;
  int? numberOfAdults;
  int? numberOfChildren;
  String? bookingUrn;
  List<AddonsModel>? addonsModels;

  HotelSuccessPaymentArgumentModel({
    this.cancellationPolicyStatus,
    this.currency,
    this.facilityMap,
    this.hotelId,
    this.imageUrl,
    this.numberOfAdults,
    this.numberOfChildren,
    this.numberOfNights,
    this.numberOfRooms,
    this.pricePerNight,
    this.roomCode,
    this.addonsModels,
    this.roomDetailsList,
    this.checkInDate,
    this.checkOutDate,
    this.offerName,
    this.propertyName,
    this.bookingUrn,
  });

  void getFromProvider(HotelSuccessPaymentArgumentModel argumentModel) {
    currency = argumentModel.currency;
    roomCode = argumentModel.roomCode;
    hotelId = argumentModel.hotelId;
    checkInDate = argumentModel.checkInDate;
    checkOutDate = argumentModel.checkOutDate;
    roomDetailsList = argumentModel.roomDetailsList;
    facilityMap = argumentModel.facilityMap;
    cancellationPolicyStatus = argumentModel.cancellationPolicyStatus;
    offerName = argumentModel.offerName;
    propertyName = argumentModel.propertyName;
    pricePerNight = argumentModel.pricePerNight;
    imageUrl = argumentModel.imageUrl;
    numberOfNights = argumentModel.numberOfNights;
    numberOfRooms = argumentModel.numberOfRooms;
    numberOfAdults = argumentModel.numberOfAdults;
    numberOfChildren = argumentModel.numberOfChildren;
    addonsModels = argumentModel.addonsModels;
    bookingUrn = argumentModel.bookingUrn;
  }
}

class AddonsModel {
  String? serviceName;
  String? imageUrl;
  String? quantity;
  DateTime? selectedDate;
  String? cost;
  String? uniqueId;
  String? description;
  AddonsModel(
      {this.imageUrl,
      this.quantity,
      this.cost,
      this.selectedDate,
      this.serviceName,
      this.uniqueId,
      this.description});
}

class RoomDetails {
  String? category;
  String? roomType;
  int? numberOfRooms;
  RoomDetails({this.category, this.roomType, this.numberOfRooms});
}

class FacilityList {
  String? key;
  String? value;
  FacilityList({this.key, this.value});
}
