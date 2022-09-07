import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';
import 'package:ota/domain/confirm_booking/usecases/hotel_confirm_booking_usecases.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_main_argument_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_main_view_model.dart';

class HotelPaymentMainBloc extends Bloc<HotelPaymentMainViewModel> {
  @override
  HotelPaymentMainViewModel initDefaultValue() {
    return HotelPaymentMainViewModel.initial();
  }

  Future<void> loadFromArgument(
      HotelPaymentMainArgumentModel argumentModel) async {
    state.state = HotelPaymentMainViewModelState.loading;
    emit(state);
    HotelConfirmBookingUseCases hotelConfirmBookingUseCases =
        HotelConfirmBookingUseCasesImpl();
    Either<Failure, BookingConfirmationData>? result =
        await hotelConfirmBookingUseCases
            .getHotelConfirmBooking(argumentModel.mapToDomainArgument());
    if (result == null) {
      state.state = HotelPaymentMainViewModelState.failure;
      emit(state);
      return;
    }
    if (result.isLeft) {
      if (result.left is InternetFailure) {
        state.state = HotelPaymentMainViewModelState.internetFailure;
      } else {
        state.state = HotelPaymentMainViewModelState.failure;
      }
      emit(state);
      return;
    }
    BookingConfirmationData data = result.right;
    var viewModelData = HotelPaymentMainViewModel.fromDomain(data);
    viewModelData.state = HotelPaymentMainViewModelState.loaded;
    emit(viewModelData);
  }

  void updateDiscountAmount(double promoDiscount) {
    state.promoDiscount = promoDiscount;
    emit(state);
  }

  void updateDiscountAmountNoEmit(double promoDiscount) {
    state.promoDiscount = promoDiscount;
  }
}
