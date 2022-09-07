import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_models.dart';
import 'package:ota/domain/tickets/review_reservation/usecases/ticket_review_reservation_usecases.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_reservation_view_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_argument.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';

const String _kTokenHeaderError = 'member_login_failure';
const String _kUnavailableHeaderError = 'not_found';

class TicketReviewReservationBloc extends Bloc<TicketReservationViewModel> {
  @override
  TicketReservationViewModel initDefaultValue() {
    return TicketReservationViewModel(
        screenState: TicketReviewReservationScreenState.none);
  }

  void initDetails(TicketReviewReservationViewModel data) {
    emit(TicketReservationViewModel(
        screenState: TicketReviewReservationScreenState.success,
        reservationViewModel: data));
  }

  Future<void> initiateTicketBooking(TicketReviewReservationArgument? argument,
      {isRefresh = false}) async {
    if (argument == null) {
      emit(TicketReservationViewModel(
          screenState: TicketReviewReservationScreenState.failure));
      return;
    }
    if (!isRefresh) {
      emit(TicketReservationViewModel(
          screenState: TicketReviewReservationScreenState.loading));
    }
    TicketReviewReservationUseCases reservationUseCases =
        TicketReviewReservationUseCasesImpl();

    Either<Failure, TicketReviewReservation>? result =
        await reservationUseCases.getTicketReviewReservationData(
            argument.toTicketReviewReservationDomain());

    if (result?.isRight ?? false) {
      TicketReviewReservation data = result!.right;
      String? statusCode = data.getTicketBookingInitiate?.status?.code;
      String? header = data.getTicketBookingInitiate?.status?.header;
      if (statusCode == kSuccessCode) {
        TicketReviewReservationViewModel reservationViewModel =
            TicketReviewReservationViewModel.fromData(
                data: data.getTicketBookingInitiate!.data!,
                totalPrice: argument.price,
                promotionList:
                    data.getTicketBookingInitiate!.data!.promotionList ?? []);
        if (reservationViewModel.ticketPackage != null &&
            reservationViewModel.ticketPackage!.ticketTypeList != null &&
            reservationViewModel.ticketPackage!.ticketTypeList!.isNotEmpty) {
          emit(TicketReservationViewModel(
              screenState: TicketReviewReservationScreenState.success,
              reservationViewModel: TicketReviewReservationViewModel.fromData(
                  data: data.getTicketBookingInitiate!.data!,
                  totalPrice: argument.price,
                  promotionList:
                      data.getTicketBookingInitiate!.data!.promotionList ??
                          [])));
        } else {
          emit(TicketReservationViewModel(
              screenState:
                  TicketReviewReservationScreenState.failureUnavailable));
        }
      } else if (statusCode == kErrorCode1899 && header == _kTokenHeaderError) {
        emit(TicketReservationViewModel(
            screenState: TicketReviewReservationScreenState.failureToken));
      } else if (statusCode == kErrorCode1899 &&
          header == _kUnavailableHeaderError) {
        emit(TicketReservationViewModel(
            screenState:
                TicketReviewReservationScreenState.failureUnavailable));
      } else {
        emit(TicketReservationViewModel(
            screenState: TicketReviewReservationScreenState.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(TicketReservationViewModel(
          screenState: TicketReviewReservationScreenState.internetFailure));
    } else {
      emit(TicketReservationViewModel(
          screenState: TicketReviewReservationScreenState.failure));
    }
  }

  bool get isValidationRequired =>
      state.screenState == TicketReviewReservationScreenState.success ||
      state.screenState == TicketReviewReservationScreenState.failureToken ||
      state.screenState ==
          TicketReviewReservationScreenState.failureUnavailable;

  bool shouldShowTicketHoldersInfoSection() {
    TicketRequireInfoViewModel? requireInfo =
        state.reservationViewModel!.ticketPackage!.requireInfo;
    if (requireInfo == null) {
      return false;
    } else {
      return (requireInfo.guestName ?? false) ||
          (requireInfo.dateOfBirth ?? false) ||
          (requireInfo.weight ?? false) ||
          (requireInfo.passportId ?? false) ||
          (requireInfo.passportValidDate ?? false) ||
          (requireInfo.passportCountryIssue ?? false) ||
          (requireInfo.passportCountry ?? false);
    }
  }
}
