import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tickets/confirm_booking/models/ticket_confirm_booking_model_domain.dart';
import 'package:ota/domain/tickets/confirm_booking/usecases/ticket_confirm_booking_usecase.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_main_view_model.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_model.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/confirm_booking_argument.dart';

class TicketConfirmBookingBloc extends Bloc<TicketConfirmBookingViewModel> {
  @override
  TicketConfirmBookingViewModel initDefaultValue() {
    return TicketConfirmBookingViewModel(
        state: TicketConfirmBookingScreenState.initial);
  }

  Future<void> loadFromArgument(ConfirmBookingArgument? argumentModel) async {
    if (argumentModel == null) {
      emit(TicketConfirmBookingViewModel(
          state: TicketConfirmBookingScreenState.failure));
      return;
    }
    state.state = TicketConfirmBookingScreenState.loading;
    emit(state);
    TicketConfirmBookingUseCases ticketConfirmBookingUseCases =
        TicketConfirmBookingUseCasesImpl();
    Either<Failure, TicketConfirmBookingModelDomain>? result =
        await ticketConfirmBookingUseCases.getTicketConfirmBookingData(
            argumentModel.toConfirmBookingArgumentDomain());

    if (result != null && result.isRight) {
      TicketConfirmBookingModelDomain model = result.right;
      if (model.getTicketBookingConfirmation != null &&
          model.getTicketBookingConfirmation!.data != null &&
          model.getTicketBookingConfirmation!.data!.packageDetail != null) {
        TicketConfirmBookingModel ticketConfirmBookingModel =
            TicketConfirmBookingModel.mapFromTicketData(
                model.getTicketBookingConfirmation!.data!,
                argumentModel.isAdditionalGuestAvailable);
        emit(TicketConfirmBookingViewModel(
            state: TicketConfirmBookingScreenState.success,
            data: ticketConfirmBookingModel));
        return;
      } else {
        emit(TicketConfirmBookingViewModel(
            state: TicketConfirmBookingScreenState.failure));
        return;
      }
    } else if (result?.left is InternetFailure) {
      emit(TicketConfirmBookingViewModel(
          state: TicketConfirmBookingScreenState.internetFailure));
      return;
    } else {
      emit(TicketConfirmBookingViewModel(
          state: TicketConfirmBookingScreenState.failure));
      return;
    }
  }

  void updatePromoDiscount(double discount) {
    state.data!.promoDiscount = discount;
    emit(state);
  }

  void updatePromoDiscountNoEmit(double discount) {
    state.data!.promoDiscount = discount;
  }
}
