import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/domain/tickets/details/usecases/ticket_details_usecase.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/helpers/ticket_booking_calendar_helpers.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_argument.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_view_model.dart';

class TicketBookingCalendarBloc extends Bloc<TicketBookingCalendarViewModel> {
  final int _kDefaultInt = 0;
  final double _kDefaultDouble = 0;
  final int _kMinimumAvailability = 0;
  bool _isValidationSuccess = false;
  bool get isValidationSuccess => _isValidationSuccess;

  @override
  TicketBookingCalendarViewModel initDefaultValue() {
    return TicketBookingCalendarViewModel(
      ticketPackageModel: TicketPackageModel(),
    );
  }

  void resetValidation() {
    _isValidationSuccess = false;
  }

  void initDetails(
      String name, List<TicketTypes> ticketTypes, int availableSeats) {
    state.ticketPackageModel.packageName = name;
    state.ticketPackageModel.ticketTypes = ticketTypes;
    state.ticketPackageModel.totalPrice = ticketTypes.first.price;
    state.ticketPackageModel.availableSeats = availableSeats;
    state.ticketBookingCalendarState = TicketBookingCalendarState.initial;
    emit(state);
  }

  void getTicketPackageDetails(TicketBookingCalendarArgument? argument) async {
    resetValidation();
    if (argument == null) {
      state.ticketBookingCalendarState = TicketBookingCalendarState.failure;
      emit(state);
      return;
    }

    TicketDetailsUseCasesImpl ticketDetailsUseCases =
        TicketDetailsUseCasesImpl();
    Either<Failure, TicketDetail>? result = await ticketDetailsUseCases
        .getTicketPackageDetails(argument.toTicketPackageDetailsArgument());

    if (result?.isRight ?? false) {
      TicketDetail data = result!.right;
      String? statusCode = data.getTicketDetails?.status?.code;
      if (statusCode == kErrorCode1899) {
        state.ticketBookingCalendarState =
            TicketBookingCalendarState.failure1899;
        emit(state);
      } else if (statusCode == kErrorCode1999) {
        state.ticketBookingCalendarState =
            TicketBookingCalendarState.failure1999;
        emit(state);
      } else if (statusCode == kSuccessCode) {
        Ticket? ticketDetail = data.getTicketDetails?.data?.ticket;
        if (ticketDetail != null) {
          final selectedPackage =
              TicketBookingCalendarHelper.getSelectedTicketPackage(
                  argument.rateKey, ticketDetail.packages ?? []);
          if (selectedPackage == null) {
            state.ticketBookingCalendarState =
                TicketBookingCalendarState.noTickets;
            emit(state);
            return;
          }
          if (_isAllTicketSoldOut(selectedPackage)) {
            state.ticketBookingCalendarState =
                TicketBookingCalendarState.ticketsSoldOut;
            emit(state);
            return;
          }
          state.ticketPackageModel =
              TicketBookingCalendarHelper.fromTicketPackage(selectedPackage);
          state.ticketBookingCalendarState = TicketBookingCalendarState.success;
          emit(state);
        } else {
          _emitFailure();
        }
      } else {
        _emitFailure();
      }
    } else {
      if (result?.left is InternetFailure) {
        state.ticketBookingCalendarState =
            TicketBookingCalendarState.failureNetwork;
        emit(state);
      } else {
        _emitFailure();
      }
    }
  }

  void _emitFailure() {
    state.ticketBookingCalendarState = TicketBookingCalendarState.failure;
    emit(state);
  }

  void updateTickets(int count, int index) {
    ticketPackage.ticketTypes[index].ticketCount = count;
    ticketPackage.totalPrice = ticketTotalPrice;
    emit(state);
  }

  double get ticketTotalPrice {
    double totalPrice = _kDefaultDouble;
    for (TicketTypes tickets in ticketPackage.ticketTypes) {
      if (tickets.ticketCount > _kDefaultInt) {
        totalPrice = totalPrice + tickets.ticketCount * tickets.price;
      }
    }
    return totalPrice;
  }

  int get totalSelectedTickets {
    int totalTickets = _kMinimumAvailability;
    for (TicketTypes tickets in ticketPackage.ticketTypes) {
      totalTickets = totalTickets + tickets.ticketCount;
    }
    return totalTickets;
  }

  bool _isAllTicketSoldOut(Package ticketPackageModel) {
    int totalAvailable = _kMinimumAvailability;
    for (TicketType tickets in ticketPackageModel.ticketTypes!) {
      totalAvailable = totalAvailable + tickets.available!;
    }
    return totalAvailable <= _kMinimumAvailability;
  }

  TicketPackageModel get ticketPackage => state.ticketPackageModel;
}
