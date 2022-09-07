import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/use_cases/hotel_booking_cancellation_use_cases.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/cancellation_reason_view_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_view_model.dart';

class HotelBookingCancellationBloc
    extends Bloc<HotelBookingCancellationViewModel> {
  HotelBookingCancellationUseCases hotelBookingCancellationUseCases =
      HotelBookingCancellationUseCasesImpl();

  @override
  HotelBookingCancellationViewModel initDefaultValue() {
    return HotelBookingCancellationViewModel(
      state: HotelBookingCancellationScreenStates.initial,
      cancellationReasonViewModel: CancellationReasonViewModel(
          cancellationReason: '', isSelected: false),
    );
  }

  Future<void> getHotelBookingCancellationData(
      HotelBookingCancellationArgument? argument) async {
    emit(HotelBookingCancellationViewModel(
        state: HotelBookingCancellationScreenStates.loading));
    if (argument == null) {
      emit(HotelBookingCancellationViewModel(
          state: HotelBookingCancellationScreenStates.failure));
      return;
    }

    mapHotelBookingCancellationData(hotelBookingCancellationUseCases, argument);
  }

  void mapHotelBookingCancellationData(
      HotelBookingCancellationUseCases hotelBookingCancellationUseCases,
      HotelBookingCancellationArgument argument) async {
    Either<Failure, HotelBookingCancellationModelDomain?>? result =
        await hotelBookingCancellationUseCases
            .getHotelBookingCancellationData(argument);
    if (result?.isRight ?? false) {
      HotelBookingCancellationModelDomain? data = result!.right;
      if (data != null) {
        String? statusCode = data.status?.code;
        if (statusCode != null && statusCode == kErrorCode1899) {
          emit(HotelBookingCancellationViewModel(
              state: HotelBookingCancellationScreenStates.failure1899));
        } else if (data.data != null) {
          emit(HotelBookingCancellationViewModel(
              state: HotelBookingCancellationScreenStates.success,
              data: HotelBookingCancellationData.fromDomain(data, argument)));
        } else {
          emit(HotelBookingCancellationViewModel(
              state: HotelBookingCancellationScreenStates.failure));
        }
      } else {
        emit(HotelBookingCancellationViewModel(
            state: HotelBookingCancellationScreenStates.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(HotelBookingCancellationViewModel(
          state: HotelBookingCancellationScreenStates.internetFailure));
    } else {
      emit(HotelBookingCancellationViewModel(
          state: HotelBookingCancellationScreenStates.failure));
    }
  }
}
