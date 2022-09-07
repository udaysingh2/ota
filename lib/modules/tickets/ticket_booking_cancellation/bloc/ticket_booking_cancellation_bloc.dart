import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/use_cases/ticket_booking_cancellation_usecases.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_argument.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_view_model.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_cancellation_reason_view_model.dart';

class TicketBookingCancellationBloc
    extends Bloc<TicketBookingCancellationViewModel> {
  TicketBookingCancellationUseCases ticketBookingCancellationUseCases =
      TicketBookingCancellationUseCasesImpl();

  @override
  TicketBookingCancellationViewModel initDefaultValue() {
    return TicketBookingCancellationViewModel(
      state: TicketBookingCancellationScreenStates.initial,
      cancellationReasonViewModel: TicketCancellationReasonViewModel(
          cancellationReason: '', isSelected: false),
    );
  }

  Future<void> getTicketBookingCancellationData(
      TicketBookingCancellationArgument? argument) async {
    emit(TicketBookingCancellationViewModel(
        state: TicketBookingCancellationScreenStates.loading));
    if (argument == null) {
      emit(TicketBookingCancellationViewModel(
          state: TicketBookingCancellationScreenStates.failure));
      return;
    }

    mapHotelBookingCancellationData(
        ticketBookingCancellationUseCases, argument);
  }

  void mapHotelBookingCancellationData(
      TicketBookingCancellationUseCases ticketBookingCancellationUseCases,
      TicketBookingCancellationArgument argument) async {
    Either<Failure, TicketBookingDetailCancellationDomain?>? result =
        await ticketBookingCancellationUseCases.getTicketCancellationDetail(
            argument.toTicketBookingCancellationDomainArgument());
    if (result?.isRight ?? false) {
      TicketBookingDetailCancellationDomain? data = result!.right;
      String? statusCode = data?.getTicketBookingReject?.status?.code;
      if (statusCode != null && statusCode == kErrorCode1899) {
        emit(TicketBookingCancellationViewModel(
            state: TicketBookingCancellationScreenStates.failure1899));
      } else if (data != null &&
          data.getTicketBookingReject != null &&
          data.getTicketBookingReject!.data != null) {
        emit(TicketBookingCancellationViewModel(
            state: TicketBookingCancellationScreenStates.success,
            data: TicketBookingCancellationData.fromDomain(
                data.getTicketBookingReject!)));
      } else {
        emit(TicketBookingCancellationViewModel(
            state: TicketBookingCancellationScreenStates.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(TicketBookingCancellationViewModel(
          state: TicketBookingCancellationScreenStates.internetFailure));
    } else {
      emit(TicketBookingCancellationViewModel(
          state: TicketBookingCancellationScreenStates.failure));
    }
  }
}
