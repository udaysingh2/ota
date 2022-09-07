import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_argument_domain.dart';
import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_model_domain.dart';
import 'package:ota/domain/ota_booking_mailer/use_cases/ota_booking_mailer_use_cases.dart';
import 'package:ota/modules/ota_common/model/ota_booking_mailer_view_model.dart';

const String _kStatusSuccess = 'success';

class OtaBookingMailerBloc extends Bloc<OtaBookingMailerViewModel> {
  @override
  initDefaultValue() {
    return OtaBookingMailerViewModel(actionStatus: '');
  }

  void sendBookingMailer(String? confirmNo, String? mailId, String? bookingUrn,
      String bookingType) async {
    if (confirmNo != null && mailId != null) {
      state.otaBookingMailerStatus = OtaBookingMailerState.failure;
      emit(state);
    }

    state.otaBookingMailerStatus = OtaBookingMailerState.loading;
    emit(state);

    OtaBookingMailerUseCases otaBookingMailerUseCases =
        OtaBookingMailerUseCasesImpl();
    Either<Failure, OtaBookingMailerModelDomain>? result =
        await otaBookingMailerUseCases.sendBookingOtaMailer(
      OtaBookingMailerArgumentDomain(
          confirmNo: confirmNo!,
          mailId: mailId!,
          bookingUrn: bookingUrn,
          bookingType: bookingType),
    );

    if (result != null && result.isRight) {
      state.actionStatus =
          result.right.sendEmailConfirmation?.data?.actionStatus ?? '';
      state.otaBookingMailerStatus = OtaBookingMailerState.success;
      emit(state);
    } else if (result?.left is InternetFailure) {
      state.otaBookingMailerStatus = OtaBookingMailerState.internetFailure;
      emit(state);
    } else {
      state.otaBookingMailerStatus = OtaBookingMailerState.failure;
      emit(state);
    }
  }

  void resetState() {
    state.otaBookingMailerStatus = OtaBookingMailerState.none;
  }

  bool isLoading() =>
      state.otaBookingMailerStatus == OtaBookingMailerState.loading;

  bool isActionStatusSuccess() => state.actionStatus == _kStatusSuccess;

  bool isSuccess() =>
      state.otaBookingMailerStatus == OtaBookingMailerState.success;

  bool isFailure() =>
      state.otaBookingMailerStatus == OtaBookingMailerState.failure;
}
