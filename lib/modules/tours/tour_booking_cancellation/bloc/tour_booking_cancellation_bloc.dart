import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/use_cases/tour_booking_cancellation_usecases.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view_model/tour_booking_cancellation_argument.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view_model/tour_booking_cancellation_view_model.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view_model/tour_cancellation_reason_view_model.dart';

class TourBookingCancellationBloc
    extends Bloc<TourBookingCancellationViewModel> {
  TourBookingCancellationUseCases tourBookingCancellationUseCases =
      TourBookingCancellationUseCasesImpl();

  @override
  TourBookingCancellationViewModel initDefaultValue() {
    return TourBookingCancellationViewModel(
      state: TourBookingCancellationScreenStates.initial,
      cancellationReasonViewModel: TourCancellationReasonViewModel(
          cancellationReason: '', isSelected: false),
    );
  }

  Future<void> getTourBookingCancellationData(
      TourBookingCancellationArgument? argument) async {
    emit(TourBookingCancellationViewModel(
        state: TourBookingCancellationScreenStates.loading));
    if (argument == null) {
      emit(TourBookingCancellationViewModel(
          state: TourBookingCancellationScreenStates.failure));
      return;
    }

    mapTourBookingCancellationData(tourBookingCancellationUseCases, argument);
  }

  void mapTourBookingCancellationData(
      TourBookingCancellationUseCases tourBookingCancellationUseCases,
      TourBookingCancellationArgument argument) async {
    Either<Failure, TourBookingDetailCancellationDomain?>? result =
        await tourBookingCancellationUseCases.getTourCancellationDetail(
            argument.toTourBookingCancellationDomainArgument());
    if (result?.isRight ?? false) {
      TourBookingDetailCancellationDomain? data = result!.right;

      String? statusCode = data?.getTourBookingReject?.status?.code;
      if (statusCode != null && statusCode == kErrorCode1899) {
        emit(TourBookingCancellationViewModel(
            state: TourBookingCancellationScreenStates.failure1899));
      } else if (data != null &&
          data.getTourBookingReject != null &&
          data.getTourBookingReject!.data != null) {
        emit(TourBookingCancellationViewModel(
            state: TourBookingCancellationScreenStates.success,
            data: TourBookingCancellationData.fromDomain(
                data.getTourBookingReject!)));
      } else {
        emit(TourBookingCancellationViewModel(
            state: TourBookingCancellationScreenStates.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(
        TourBookingCancellationViewModel(
            state: TourBookingCancellationScreenStates.internetFailure),
      );
    } else {
      emit(
        TourBookingCancellationViewModel(
            state: TourBookingCancellationScreenStates.failure),
      );
    }
  }
}
