import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/use_cases/hotel_booking_mailer_use_cases.dart';
import 'package:ota/modules/hotel/hotel_booking_mailer/view_model/hotel_booking_mailer_view_model.dart';

const String _kStatusSuccess = 'success';
const String _kStatusCode = '1000';

class HotelBookingMailerBloc extends Bloc<HotelBookingMailerViewModel> {
  HotelBookingMailerUseCases hotelBookingMailerUseCases =
      HotelBookingMailerUseCasesImpl();

  @override
  initDefaultValue() {
    return HotelBookingMailerViewModel(actionStatus: '');
  }

  void sendHotelBookingMailer(String? confirmNo, String? mailId,
      String? bookingUrn, String? serviceName) async {
    if (confirmNo != null && mailId == null) {
      state.hotelBookingMailerStatus = HotelBookingMailerState.failure;
      emit(state);
      return;
    }

    state.hotelBookingMailerStatus = HotelBookingMailerState.loading;
    emit(state);

    Either<Failure, HotelBookingMailerModelDomain>? result =
        await hotelBookingMailerUseCases.sendBookingHotelMailer(
      HotelBookingMailerArgumentDomain(
          confirmNo: confirmNo!,
          mailId: mailId!,
          bookingUrn: bookingUrn,
          serviceName: serviceName),
    );

    if (result != null &&
        result.isRight &&
        result.right.sendEmailConfirmation?.status?.code == _kStatusCode) {
      state.actionStatus =
          result.right.sendEmailConfirmation?.data?.actionStatus ?? '';
      state.hotelBookingMailerStatus = HotelBookingMailerState.success;
      emit(state);
    } else if (result != null &&
        result.isLeft &&
        result.left is InternetFailure) {
      state.hotelBookingMailerStatus = HotelBookingMailerState.internetFailure;
      emit(state);
    } else {
      state.hotelBookingMailerStatus = HotelBookingMailerState.failure;
      emit(state);
    }
  }

  void resetState() {
    state.hotelBookingMailerStatus = HotelBookingMailerState.none;
  }

  bool isLoading() =>
      state.hotelBookingMailerStatus == HotelBookingMailerState.loading;

  bool isActionStatusSuccess() => state.actionStatus == _kStatusSuccess;

  bool isSuccess() =>
      state.hotelBookingMailerStatus == HotelBookingMailerState.success;

  bool isFailure() =>
      state.hotelBookingMailerStatus == HotelBookingMailerState.failure;
}
