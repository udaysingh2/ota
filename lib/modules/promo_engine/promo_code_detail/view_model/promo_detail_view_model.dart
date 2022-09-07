class PromoDetailViewModel {
  bool removed;
  PriceDetails? priceDetails;
  PromoDetailViewModelState promoDetailViewModelState;

  PromoDetailViewModel({
    this.removed = false,
    this.priceDetails,
    this.promoDetailViewModelState = PromoDetailViewModelState.none,
  });
}

class PriceDetails {
  double orderPrice;
  double addonPrice;
  double totalAmount;

  PriceDetails({
    required this.orderPrice,
    required this.addonPrice,
    required this.totalAmount,
  });
}

enum PromoDetailViewModelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
