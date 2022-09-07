import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_models.dart';
import 'package:ota/domain/tours/review_reservation/usecases/tours_review_reservation_usecases.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tours_review_reservation_argument.dart';

const String _kTokenHeaderError = 'member_login_failure';
const String _kUnavailableHeaderError = 'not_found';
const String _kMinimumLimitHeaderError = 'min_pax_required';

class TourReviewReservationBloc extends Bloc<TourReservationViewModel> {
  @override
  TourReservationViewModel initDefaultValue() {
    return TourReservationViewModel(
      screenState: TourReviewReservationScreenState.none,
    );
  }

  bool isTravellersDetailsRequired() {
    TourRequireInfoViewModel? requireInfo =
        state.reservationViewModel?.tourPackage?.requireInfo;
    if (requireInfo == null) {
      return false;
    } else {
      bool guestName = requireInfo.guestName ?? false;
      bool weight = requireInfo.weight ?? false;
      bool passportId = requireInfo.passportId ?? false;
      bool dateOfBirth = requireInfo.dateOfBirth ?? false;
      bool passportCountry = requireInfo.passportCountry ?? false;
      bool passportValidDate = requireInfo.passportValidDate ?? false;
      bool passportCountryIssue = requireInfo.passportCountryIssue ?? false;
      bool isFieldRequired = (guestName ||
          weight ||
          passportId ||
          dateOfBirth ||
          passportCountry ||
          passportValidDate ||
          passportCountryIssue);
      return isFieldRequired;
    }
  }

  void initDetails(TourReviewReservationViewModel data) {
    emit(TourReservationViewModel(
        screenState: TourReviewReservationScreenState.success,
        reservationViewModel: data));
  }

  Future<void> initiateTourBooking(TourReviewReservationArgument? argument,
      {isRefresh = false}) async {
    if (argument == null) {
      emit(TourReservationViewModel(
          screenState: TourReviewReservationScreenState.failure));
      return;
    }
    if (!isRefresh) {
      emit(TourReservationViewModel(
          screenState: TourReviewReservationScreenState.loading));
    }
    TourReviewReservationUseCases reservationUseCases =
        TourReviewReservationUseCasesImpl();

    Either<Failure, TourReviewReservation>? result =
        await reservationUseCases.getToursReviewReservationData(
            argument.toTourReviewReservationDomain());

    if (result?.isRight ?? false) {
      TourReviewReservation data = result!.right;
      String? statusCode = data.getTourBookingInitiate?.status?.code;
      String? header = data.getTourBookingInitiate?.status?.header;
      if (statusCode == kSuccessCode) {
        emit(TourReservationViewModel(
            screenState: TourReviewReservationScreenState.success,
            reservationViewModel: TourReviewReservationViewModel.fromData(
                data: data.getTourBookingInitiate!.data!,
                adultCount: argument.packageReservationArgument.adults,
                childCount: argument.packageReservationArgument.children,
                lastPrice: argument.totalPrice,
                promotionList:
                    data.getTourBookingInitiate!.data!.promotionList ?? [])));
      } else if (header == _kTokenHeaderError) {
        emit(TourReservationViewModel(
            screenState: TourReviewReservationScreenState.failureToken));
      } else if (header == _kMinimumLimitHeaderError) {
        emit(TourReservationViewModel(
            screenState: TourReviewReservationScreenState.failureMinimumLimit));
      } else if (header == _kUnavailableHeaderError) {
        emit(TourReservationViewModel(
            screenState: TourReviewReservationScreenState.failureUnavailable));
      } else {
        emit(TourReservationViewModel(
            screenState: TourReviewReservationScreenState.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(TourReservationViewModel(
          screenState: TourReviewReservationScreenState.internetFailure));
    } else {
      emit(TourReservationViewModel(
          screenState: TourReviewReservationScreenState.failure));
    }
  }

  bool get isValidationRequired =>
      state.screenState == TourReviewReservationScreenState.success ||
      state.screenState == TourReviewReservationScreenState.failureToken ||
      state.screenState == TourReviewReservationScreenState.failureUnavailable;
}
