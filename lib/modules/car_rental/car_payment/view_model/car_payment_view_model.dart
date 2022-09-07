import '../../../../domain/car_rental/car_payment/models/car_payment_model_domain.dart';

class CarPaymentViewModel {
  CarPaymentViewModelState state;
  String bookingUrn;
  String pricePerDay;
  double? carRentalTotalPrice;
  double? extrasOnlinePrice;
  double? extrasOfflinePrice;
  List<CancellationPolicyList> cancellationPolicyList;
  double promoDiscount;
  double? discount;
  String? cancellationStatus;
  double? returnExtraCharge;

  factory CarPaymentViewModel({
    required String bookingUrn,
    required String pricePerDay,
    required String cancellationStatus,
    required double carRentalTotalPrice,
    required double extrasOnlinePrice,
    required double extrasOfflinePrice,
    required List<CancellationPolicyList> cancellationPolicyList,
    required CarPaymentViewModelState state,
    required double returnExtraCharge,
    required double promoDiscount,
  }) {
    return CarPaymentViewModel._named(
      state: state,
      carRentalTotalPrice: carRentalTotalPrice,
      extrasOfflinePrice: extrasOfflinePrice,
      extrasOnlinePrice: extrasOnlinePrice,
      bookingUrn: bookingUrn,
      cancellationPolicyList: cancellationPolicyList,
      pricePerDay: pricePerDay,
      cancellationStatus: cancellationStatus,
      promoDiscount: promoDiscount,
      returnExtraCharge: returnExtraCharge,
    );
  }
  factory CarPaymentViewModel.initial() {
    return CarPaymentViewModel._named(
      state: CarPaymentViewModelState.initial,
      carRentalTotalPrice: 1,
      extrasOfflinePrice: 1,
      extrasOnlinePrice: 1,
      bookingUrn: "",
      cancellationPolicyList: [],
      pricePerDay: "",
      cancellationStatus: "",
      returnExtraCharge: 1,
      promoDiscount: 0,
    );
  }

  factory CarPaymentViewModel.fromDomain(CarPaymentDomainModelData data) {
    return CarPaymentViewModel(
      cancellationPolicyList: _getCancellationPolicyList(
          data.saveCarBookingConfirmationDetails?.data?.cancellationPolicy ??
              []),
      carRentalTotalPrice:
          data.saveCarBookingConfirmationDetails!.data!.carRentalTotalPrice!,
      bookingUrn:
          data.saveCarBookingConfirmationDetails!.data!.bookingUrn.toString(),
      pricePerDay:
          data.saveCarBookingConfirmationDetails!.data!.pricePerDay.toString(),
      extrasOnlinePrice:
          data.saveCarBookingConfirmationDetails!.data!.extrasOnlinePrice!,
      extrasOfflinePrice:
          data.saveCarBookingConfirmationDetails!.data!.extrasOfflinePrice!,
      state: CarPaymentViewModelState.loaded,
      cancellationStatus:
          data.saveCarBookingConfirmationDetails!.data!.isNonRefund!,
      returnExtraCharge:
          data.saveCarBookingConfirmationDetails!.data!.returnExtraCharge ??
              0.0,
      promoDiscount: 0,
    );
  }

  CarPaymentViewModel._named({
    required this.state,
    required this.bookingUrn,
    required this.pricePerDay,
    required this.carRentalTotalPrice,
    required this.extrasOnlinePrice,
    required this.extrasOfflinePrice,
    required this.cancellationPolicyList,
    required this.cancellationStatus,
    required this.returnExtraCharge,
    required this.promoDiscount,
    // required this.addonsModels,
  });

  static List<CancellationPolicyList> _getCancellationPolicyList(
      List<CancellationPolicy> list) {
    List<CancellationPolicyList> result = [];
    for (CancellationPolicy data in list) {
      result.add(CancellationPolicyList(
          cancellationDays: data.cancelDays,
          cancellationMessage: data.message));
    }
    return result;
  }

}

class CancellationPolicyList {
  int? cancellationDays;
  String? cancellationMessage;
  CancellationPolicyListModelState state;
  CancellationPolicyList({
    this.cancellationDays,
    this.cancellationMessage,
    this.state = CancellationPolicyListModelState.collapsed,
  });
}

enum CancellationPolicyListModelState { expanded, collapsed }

enum CarPaymentViewModelState {
  initial,
  loading,
  loaded,
  failure,
  failureNetwork,
}
