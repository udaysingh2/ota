import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_view_model.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';

class HotelSuccessPaymentBloc extends Bloc<HotelSuccessPaymentViewModel> {
  @override
  HotelSuccessPaymentViewModel initDefaultValue() {
    return HotelSuccessPaymentViewModel();
  }

  void loadFromArgument(HotelSuccessPaymentArgumentModel argumentModel) {
    state.state = HotelSuccessPaymentViewModelState.loading;
    emit(state);
    state.argumentModel = argumentModel;
    state.state = HotelSuccessPaymentViewModelState.loaded;
    emit(state);
  }
}
