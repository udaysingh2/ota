import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';

class HotelSuccessPaymentViewModel {
  HotelSuccessPaymentArgumentModel? argumentModel;
  HotelSuccessPaymentViewModelState state;
  HotelSuccessPaymentViewModel(
      {this.argumentModel,
      this.state = HotelSuccessPaymentViewModelState.initial});
}

enum HotelSuccessPaymentViewModelState {
  initial,
  loading,
  loaded,
}
