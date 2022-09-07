import 'package:ota/core_components/bloc/bloc.dart';

class TicketConfirmBookingExpandBloc
    extends Bloc<TicketConfirmBookingMinMaxState> {
  @override
  TicketConfirmBookingMinMaxState initDefaultValue() {
    return TicketConfirmBookingMinMaxState.isCollapsed;
  }

  void toggle() {
    if (state == TicketConfirmBookingMinMaxState.isCollapsed) {
      emit(TicketConfirmBookingMinMaxState.isExpanded);
    } else {
      emit(TicketConfirmBookingMinMaxState.isCollapsed);
    }
  }

  void setMinimised() {
    emit(TicketConfirmBookingMinMaxState.isCollapsed);
  }

  void setMaximised() {
    emit(TicketConfirmBookingMinMaxState.isExpanded);
  }
}

enum TicketConfirmBookingMinMaxState {
  isExpanded,
  isCollapsed,
}
