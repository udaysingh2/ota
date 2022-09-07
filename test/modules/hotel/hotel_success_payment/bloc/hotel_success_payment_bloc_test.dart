import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_success_payment/bloc/hotel_success_payment_bloc.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_view_model.dart';

void main() {
  HotelSuccessPaymentBloc bloc = HotelSuccessPaymentBloc();
  HotelSuccessPaymentArgumentModel argumentModel =
      HotelSuccessPaymentArgumentModel();

  test('HotelSuccessPaymentBloc ==> initDefaultValue()', () {
    bloc.initDefaultValue();
  });

  test('HotelSuccessPaymentBloc ==> loadFromArgument()', () {
    bloc.loadFromArgument(argumentModel);
    bloc.state.argumentModel = argumentModel;
    expect(bloc.state.state, HotelSuccessPaymentViewModelState.loaded);
  });
}
