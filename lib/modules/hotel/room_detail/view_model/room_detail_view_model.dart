import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/modules/hotel/room_detail/helper/room_detail_helper.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_argument_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_category_view_model.dart';

import '../../../../core_pack/custom_widgets/ota_room_promotion_widget/ota_promotion_model.dart';

String _kConditionalCancellation = "conditional.cancellation";
String _kFreeCancellation = "policy.cancellation.free";

class RoomDetailViewModel {
  RoomDetailViewPageState pageState;
  RoomDetailModel? data;

  RoomDetailViewModel({
    required this.pageState,
    this.data,
  });
}

class RoomDetailModel {
  String roomType;
  String roomImage;
  List<RoomCategoryViewModel> roomList;
  List<FacilityModel> facilityList;
  List<String> roomFacilities;
  String supplier;
  String supplierId;
  String supplierName;
  RoomDetailCancellationPolicyType roomDetailCancellationPolicyType;
  List<CancellationPolicyModel> cancellationPolicies;
  double? totalAmount;
  double? discountPercent;
  double? nightPriceBeforeDiscount;
  double? perNightPrice;
  List<OtaPromotionModel> specialPromotionDetailList;

  RoomDetailModel({
    required this.roomType,
    required this.roomImage,
    this.roomList = const [],
    this.facilityList = const [],
    this.roomDetailCancellationPolicyType =
        RoomDetailCancellationPolicyType.nonRefundable,
    this.roomFacilities = const [],
    this.supplier = '',
    required this.supplierId,
    required this.supplierName,
    this.cancellationPolicies = const [],
    this.totalAmount,
    this.discountPercent,
    this.nightPriceBeforeDiscount,
    this.perNightPrice,
    this.specialPromotionDetailList = const [],
  });

  factory RoomDetailModel.mapFromRoomDetail(
      GetRoomDetailsData data, RoomDetailArgument? argument) {
    return RoomDetailModel(
        roomType: data.mealType ?? '',
        roomImage: _getRoomImage(data.roomInfo),
        roomList:
            RoomDetailHelper.generateRoomCategory(data.roomCategories) ?? [],
        facilityList: RoomDetailHelper.generateFacilityList(data.facilities),
        roomDetailCancellationPolicyType: data
                    .cancellationPolicy![0].cancellationStatus ==
                _kConditionalCancellation
            ? RoomDetailCancellationPolicyType.conditionalCancellation
            : _getPolicyType(data.cancellationPolicy![0].cancellationStatus),
        roomFacilities: data.roomFacilities!,
        supplier: data.supplier ?? '',
        supplierId: data.supplierId ?? '',
        supplierName: data.supplierName ?? '',
        cancellationPolicies: RoomDetailHelper.generateCancellationPolicy(
                data.cancellationPolicy) ??
            const [],
        totalAmount: data.totalPrice,
        perNightPrice: data.perNightPrice,
        discountPercent: data.discountPercent,
        nightPriceBeforeDiscount: data.nightPriceBeforeDiscount,
        specialPromotionDetailList:
            RoomDetailHelper.generatePromotionList(data.specialPromotions));
  }
}

String _getRoomImage(RoomInfo? roomInfo) {
  if (roomInfo != null) {
    return roomInfo.coverImage ?? "";
  } else {
    return "";
  }
}

RoomDetailCancellationPolicyType _getPolicyType(String? cancellationStatus) {
  return cancellationStatus == _kFreeCancellation
      ? RoomDetailCancellationPolicyType.freeCancellation
      : RoomDetailCancellationPolicyType.nonRefundable;
}

class FacilityModel {
  String key;
  String value;

  FacilityModel(this.key, this.value);
}

enum RoomDetailViewPageState {
  initial,
  loading,
  failure,
  success,
  internetFailure,
}

enum RoomDetailCancellationPolicyType {
  freeCancellation,
  conditionalCancellation,
  nonRefundable,
}
