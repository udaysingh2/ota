import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';

class HotelPaymentMainArgumentModel {
  OtaCountDownController otaCountDownController;
  String totalCost;
  String firstName;
  String lastName;
  String bookingUrn;
  String hotelId;
  String membershipId;
  String? firstGuestName;
  String? secondGuestName;
  String roomCode;
  String additionalNeedsText;
  List<HotelPaymentAddonsModel> addonsModels;
  bool freefoodDelivery;

  HotelConfirmBookingArgumentModelDomain mapToDomainArgument() {
    return HotelConfirmBookingArgumentModelDomain(
        additionalNeedsText: additionalNeedsText,
        hotelId: hotelId,
        roomCode: roomCode,
        bookingUrn: bookingUrn,
        bookingForSomeoneElse:
            (firstGuestName != null && firstGuestName!.isNotEmpty),
        customerInfo: CustomerInfoDataDomain(
            firstName: firstName,
            lastName: lastName,
            membershipId: membershipId),
        totalPrice: double.parse(totalCost),
        addOnServices: _getListAddons(addonsModels),
        guestInfo: (firstGuestName != null && firstGuestName!.isNotEmpty)
            ? [
                GuestInfoDataDomain(
                    firstName: firstGuestName!, lastName: secondGuestName!)
              ]
            : null);
  }

  List<AddonDataDomain> _getListAddons(
      List<HotelPaymentAddonsModel> addonsModels) {
    List<AddonDataDomain> result = [];
    for (HotelPaymentAddonsModel data in addonsModels) {
      result.add(
        AddonDataDomain(
          description: data.description,
          hotelServiceId: data.uniqueId,
          hotelServiceName: data.serviceName,
          image: data.imageUrl,
          isFlightRequired: data.isFlightRequired,
          price: data.cost,
          quantity: int.parse(data.quantity),
          serviceDate: Helpers.getYYYYmmddFromDateTime(data.selectedDate),
        ),
      );
    }
    return result;
  }

  factory HotelPaymentMainArgumentModel({
    required OtaCountDownController otaCountDownController,
    required String totalCost,
    required List<HotelPaymentAddonsModel> addonsModels,
    required String firstName,
    required String lastName,
    required String bookingUrn,
    required String hotelId,
    required String membershipId,
    required String firstGuestName,
    required String secondGuestName,
    required String roomCode,
    required String additionalNeedsText,
    required bool freefoodDelivery,
  }) {
    return HotelPaymentMainArgumentModel._named(
      otaCountDownController: otaCountDownController,
      addonsModels: addonsModels,
      totalCost: totalCost,
      firstName: firstName,
      lastName: lastName,
      hotelId: hotelId,
      roomCode: roomCode,
      additionalNeedsText: additionalNeedsText,
      bookingUrn: bookingUrn,
      membershipId: membershipId,
      firstGuestName: firstGuestName,
      secondGuestName: secondGuestName,
      freefoodDelivery: freefoodDelivery,
    );
  }

  HotelPaymentMainArgumentModel._named({
    required this.otaCountDownController,
    required this.totalCost,
    required this.addonsModels,
    required this.firstName,
    required this.lastName,
    required this.roomCode,
    required this.hotelId,
    required this.additionalNeedsText,
    required this.bookingUrn,
    required this.membershipId,
    this.firstGuestName,
    this.secondGuestName,
    required this.freefoodDelivery,
  });
}

class HotelPaymentAddonsModel {
  String serviceName;
  String imageUrl;
  String quantity;
  DateTime? selectedDate;
  String cost;
  String uniqueId;
  String description;
  bool isFlightRequired;

  HotelPaymentAddonsModel({
    this.imageUrl = "",
    this.quantity = "",
    this.cost = "",
    this.selectedDate,
    this.serviceName = "",
    this.uniqueId = "",
    this.description = "",
    this.isFlightRequired = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelPaymentAddonsModel &&
          runtimeType == other.runtimeType &&
          uniqueId == other.uniqueId;

  @override
  int get hashCode => uniqueId.hashCode;
}
