import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/helper/ticket_cancellation_reasons_helper.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_cancellation_reason_view_model.dart';

class TicketCancellationReasonBloc
    extends Bloc<TicketCancellationReasonViewModel> {
  @override
  initDefaultValue() {
    TicketCancellationReasonViewModel cancellationReasonViewModel =
        TicketCancellationReasonViewModel(
            cancellationReason:
                TicketCancellationReasonsHelper.cancellationReasons[0],
            isSelected: false);
    return cancellationReasonViewModel;
  }

  setCancellationReason(
      {int? index, required bool isSelected, required String reason}) {
    state.cancellationReason = reason;
    state.isSelected = isSelected;
    emit(state);
  }

  bool getBookingAndConfirmationDateSame(
      {required String bookingDateValue,
      required String confirmationDateValue}) {
    final currentDate = DateTime.now();
    final today =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    final confirmationDate = Helpers().parseDateAndTime(confirmationDateValue);
    final bookingDate = Helpers().parseDateAndTime(bookingDateValue);
    final booking =
        DateTime(bookingDate.year, bookingDate.month, bookingDate.day);
    final confirmation = DateTime(
        confirmationDate.year, confirmationDate.month, confirmationDate.day);
    return booking == confirmation && confirmation == today;
  }
}
