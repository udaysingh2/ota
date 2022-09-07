import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';
import 'package:ota/modules/hotel/hotel_payment/helper/hotel_payment_facility_list_helper.dart';

import '../../../../core_pack/custom_widgets/ota_room_promotion_widget/ota_promotion_model.dart';
import 'hotel_payment_main_argument_model.dart';
import 'hotel_payment_room_view_model.dart';

class HotelPaymentMainViewModel {
  HotelPaymentMainViewModelState state;
  String hotelName;
  String offerName;
  int nights;
  int rooms;
  DateTime fromDate;
  DateTime toDate;
  String cancellationPolicy;
  List<HotelPaymentRoomDetails> roomDetails;
  List<HotelPaymentFacilityList> facilityList;
  String perRoomCost;
  String totalCost;
  List<HotelPaymentRoom> hotelPaymentRooms;
  List<HotelPaymentAddonsModel> addonsModels;
  double discount;
  double promoDiscount;
  String imageUrl;
  String firstName;
  String lastName;
  String currency;
  double? percentageDiscount;
  double? priceBeforeDiscount;
  bool freeFoodDelivery;
  List<OtaCancellationPolicyListModel> cancellationPolicyList;
  List<OtaPromotionModel> specialPromotionDetailList;
  List<OtaFreeFoodPromotionModel> freeFoodPromotions;

  factory HotelPaymentMainViewModel({
    required String hotelName,
    required String offerName,
    required int nights,
    required int rooms,
    required DateTime fromDate,
    required DateTime toDate,
    required String cancellationPolicy,
    required List<HotelPaymentRoomDetails> roomDetails,
    required List<HotelPaymentFacilityList> facilityList,
    required String perRoomCost,
    required String totalCost,
    required List<HotelPaymentRoom> hotelPaymentRooms,
    required List<HotelPaymentAddonsModel> addonsModels,
    required double discount,
    required double promoDiscount,
    required String imageUrl,
    required String firstName,
    required String lastName,
    required String currency,
    double? percentageDiscount,
    double? priceBeforeDiscount,
    required bool freeFoodDelivery,
    required List<OtaCancellationPolicyListModel> cancellationPolicyList,
    required HotelPaymentMainViewModelState state,
    required List<OtaPromotionModel> specialPromotionDetailList,
    required List<OtaFreeFoodPromotionModel> freeFoodPromotions,
  }) {
    return HotelPaymentMainViewModel._named(
      rooms: rooms,
      fromDate: fromDate,
      toDate: toDate,
      discount: discount,
      promoDiscount: promoDiscount,
      facilityList: facilityList,
      addonsModels: addonsModels,
      cancellationPolicy: cancellationPolicy,
      hotelName: hotelName,
      hotelPaymentRooms: hotelPaymentRooms,
      nights: nights,
      offerName: offerName,
      perRoomCost: perRoomCost,
      roomDetails: roomDetails,
      totalCost: totalCost,
      imageUrl: imageUrl,
      firstName: firstName,
      lastName: lastName,
      currency: currency,
      state: state,
      cancellationPolicyList: cancellationPolicyList,
      percentageDiscount: percentageDiscount,
      priceBeforeDiscount: priceBeforeDiscount,
      freeFoodDelivery: freeFoodDelivery,
      specialPromotionDetailList: specialPromotionDetailList,
      freeFoodPromotions: freeFoodPromotions,
    );
  }
  factory HotelPaymentMainViewModel.initial() {
    return HotelPaymentMainViewModel._named(
      rooms: 0,
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
      discount: 1,
      promoDiscount: 0,
      facilityList: [],
      addonsModels: [],
      cancellationPolicy: "",
      hotelName: "",
      hotelPaymentRooms: [],
      nights: 1,
      offerName: "",
      perRoomCost: "",
      roomDetails: [],
      totalCost: "",
      imageUrl: "",
      firstName: "",
      lastName: "",
      currency: "",
      cancellationPolicyList: [],
      state: HotelPaymentMainViewModelState.initial,
      percentageDiscount: 0,
      priceBeforeDiscount: 0,
      freeFoodDelivery: false,
      specialPromotionDetailList: [],
      freeFoodPromotions: [],
    );
  }
  static List<HotelPaymentRoom> _getRooms(
      List<RequestedRoomDetail> roomDetails) {
    List<HotelPaymentRoom> result = [];
    for (RequestedRoomDetail data in roomDetails) {
      result.add(HotelPaymentRoom(
          adults: data.adults!,
          children: data.children ?? AppConfig().configModel.defaultChildCount,
          childAge1: data.childAge1,
          childAge2: data.childAge2));
    }
    return result;
  }

  static List<HotelPaymentRoomDetails> _getRoomsDetails(
      List<RoomCategory> roomDetails) {
    List<HotelPaymentRoomDetails> result = [];
    for (RoomCategory data in roomDetails) {
      result.add(HotelPaymentRoomDetails(
          category: data.roomName ?? " ",
          roomType: data.roomType ?? "",
          numberOfRooms: data.noOfRooms,
          noOfRoomsAndName: data.noOfRoomsAndName ?? ""));
    }
    return result;
  }

  static List<HotelPaymentAddonsModel> _getAddonServices(
      List<AddOnService> addonService) {
    List<HotelPaymentAddonsModel> result = [];
    for (AddOnService data in addonService) {
      result.add(HotelPaymentAddonsModel(
        imageUrl: data.image ?? "",
        description: data.description ?? "",
        serviceName: data.hotelServiceName ?? "",
        uniqueId: data.hotelServiceId!,
        cost: data.price!,
        selectedDate: data.serviceDate,
        quantity: data.quantity!.toString(),
        isFlightRequired: data.isFlightRequired!,
      ));
    }
    return result;
  }

  static List<OtaCancellationPolicyListModel> _getCancellationPolicyList(
      List<CancellationPolicy> list) {
    List<OtaCancellationPolicyListModel> result = [];
    for (CancellationPolicy data in list) {
      result.add(OtaCancellationPolicyListModel(
        cancellationChargeDescription: data.cancellationChargeDescription,
        cancellationDaysDescription: data.cancellationDaysDescription,
        cancellationPolicyState: data.cancellationStatus,
      ));
    }
    return result;
  }

  factory HotelPaymentMainViewModel.fromDomain(BookingConfirmationData data) {
    return HotelPaymentMainViewModel(
      totalCost: data.data!.totalAmount.toString(),
      facilityList: HotelPaymentFacilityListHelper.getFacility(
          data.data!.hotelBookingDetails!.roomDetails!.facilities ?? []),
      state: HotelPaymentMainViewModelState.loaded,
      hotelPaymentRooms:
          _getRooms(data.data!.hotelBookingDetails!.requestedRoomDetails!),
      nights: int.parse(
          data.data!.hotelBookingDetails!.roomDetails!.numberOfNights!),
      offerName: data.data!.hotelBookingDetails!.roomDetails!.mealType!,
      perRoomCost:
          data.data!.hotelBookingDetails!.roomDetails!.perNightPrice.toString(),
      roomDetails: _getRoomsDetails(
          data.data!.hotelBookingDetails!.roomDetails!.roomCategories!),
      hotelName: data.data!.hotelBookingDetails!.roomDetails!.hotelName!,
      cancellationPolicy: data.data!.hotelBookingDetails!.roomDetails!
          .cancellationPolicy!.first.cancellationStatus!,
      addonsModels: _getAddonServices(
          data.data!.hotelBookingDetails!.addOnServices ?? []),
      discount: data.data!.totalDiscount!,
      promoDiscount: 0,
      toDate: data.data!.hotelBookingDetails!.checkOutDate!,
      fromDate: data.data!.hotelBookingDetails!.checkInDate!,
      rooms: data.data!.hotelBookingDetails!.requestedRoomDetails!.length,
      imageUrl: data.data!.hotelBookingDetails!.roomDetails!.hotelImage!,
      lastName: data.data!.customerInfo!.lastName!,
      firstName: data.data!.customerInfo!.firstName!,
      currency: AppConfig().currency,
      cancellationPolicyList: _getCancellationPolicyList(
          data.data!.hotelBookingDetails!.roomDetails!.cancellationPolicy ??
              []),
      percentageDiscount:
          data.data!.hotelBookingDetails!.roomDetails?.discountPercent,
      priceBeforeDiscount:
          data.data!.hotelBookingDetails!.roomDetails?.nightPriceBeforeDiscount,
      freeFoodDelivery:
          data.data!.hotelBookingDetails?.freeFoodDelivery ?? false,
      specialPromotionDetailList:
          HotelPaymentFacilityListHelper.generatePromotionList(
              data.data!.hotelBookingDetails!.roomDetails!.specialPromotions),
      freeFoodPromotions:
          HotelPaymentFacilityListHelper.generateFreeFoodPromotionList(
              data.data!.promotionList),
    );
  }

  HotelPaymentMainViewModel._named({
    required this.hotelName,
    required this.offerName,
    required this.nights,
    required this.rooms,
    required this.fromDate,
    required this.toDate,
    required this.cancellationPolicy,
    required this.roomDetails,
    required this.facilityList,
    required this.perRoomCost,
    required this.totalCost,
    required this.hotelPaymentRooms,
    required this.addonsModels,
    required this.discount,
    required this.promoDiscount,
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.currency,
    required this.state,
    required this.cancellationPolicyList,
    this.percentageDiscount,
    this.priceBeforeDiscount,
    required this.freeFoodDelivery,
    required this.specialPromotionDetailList,
    required this.freeFoodPromotions,
  });

  int getChildCount() {
    int count = 0;
    for (HotelPaymentRoom room in hotelPaymentRooms) {
      count += room.children;
    }
    return count;
  }

  double getTotalServiceCost() {
    double count = 0;
    for (HotelPaymentAddonsModel addons in addonsModels) {
      count += ((double.tryParse(addons.cost) ?? 0) *
          (int.tryParse(addons.quantity) ?? 0));
    }
    return count;
  }

  /// totalCost = totalRoomCost+addonServices
  double getTotalRoomCost() {
    return (double.tryParse(totalCost) ?? 0) - getTotalServiceCost();
  }

  double getGrandTotalMinusDiscount() {
    double totalAmount = (double.tryParse(totalCost) ?? 0) - promoDiscount;
    if (totalAmount >= 0) {
      return totalAmount;
    } else {
      return 0.0;
    }
  }

  double getWalletAmountTobeDeducted(double balance) {
    double totalValueAfterPromoApplied = getGrandTotalMinusDiscount();

    if (balance > 0) {
      if (balance >= totalValueAfterPromoApplied) {
        return totalValueAfterPromoApplied;
      } else if (balance < totalValueAfterPromoApplied) {
        return balance;
      }
    }

    return 0.0;
  }

  double getGrandTotalWithWalletApplied(bool walletState, double balance) {
    double totalAmount = getGrandTotalMinusDiscount();

    double walletAmount = getWalletAmountTobeDeducted(balance);

    if (totalAmount >= 0 && walletState) {
      return totalAmount - walletAmount;
    } else {
      return totalAmount;
    }
  }

  int getAdultCount() {
    int count = 0;
    for (HotelPaymentRoom room in hotelPaymentRooms) {
      count += room.adults;
    }
    return count;
  }
}

class HotelPaymentRoom {
  int adults;
  int children;
  int? childAge1;
  int? childAge2;
  HotelPaymentRoom({
    required this.adults,
    required this.children,
    this.childAge1,
    this.childAge2,
  });
}

enum HotelPaymentMainViewModelState {
  initial,
  loading,
  loaded,
  failure,
  internetFailure,
}
