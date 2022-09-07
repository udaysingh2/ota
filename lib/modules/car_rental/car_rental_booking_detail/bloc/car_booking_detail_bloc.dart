import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/model/car_booking_detail_domain_model.dart';
import 'package:ota/domain/car_rental/car_rental_booking_detail/usecases/car_booking_detail_use_cases.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_argument_model.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

const String _kVA = "VA";

class CarBookingDetailBloc extends Bloc<CarBookingDetailViewModel> {
  @override
  CarBookingDetailViewModel initDefaultValue() {
    return CarBookingDetailViewModel(
      pageState: CarBookingDetailPageState.loading,
      bookingDetail: CarBookingDetailDataModel(),
    );
  }

  bool get showBookingId {
    String? bookingId = state.bookingDetail?.bookingId ?? '';

    switch (state.bookingDetail?.activityStatus) {
      case CarActivityStatus.paymentPending:
      case CarActivityStatus.awatingConfirmation:
      case CarActivityStatus.paymentFailed:
      case CarActivityStatus.rejected:
        return false;

      default:
        return bookingId.isNotEmpty;
    }
  }

  bool get showFailedBookingStatus {
    switch (state.bookingDetail?.activityStatus) {
      case CarActivityStatus.paymentPending:
      case CarActivityStatus.awatingConfirmation:
      case CarActivityStatus.paymentFailed:
      case CarActivityStatus.rejected:
      case CarActivityStatus.userCancelled:
      case CarActivityStatus.awatingCancellation:
        return true;

      default:
        return false;
    }
  }

  ButtonState get getCancelledButtonState {
    if (!isOngoingBooking) return ButtonState.hide;
    switch (state.bookingDetail?.activityStatus) {
      case CarActivityStatus.paymentPending:
      case CarActivityStatus.awatingConfirmation:
        return ButtonState.disable;

      case CarActivityStatus.success:
        return ButtonState.enable;

      default:
        return ButtonState.hide;
    }
  }

  ButtonState get getMessageButtonState {
    if (isCompletedBooking) return ButtonState.disable;

    switch (state.bookingDetail?.activityStatus) {
      case CarActivityStatus.paymentPending:
      case CarActivityStatus.awatingConfirmation:
      case CarActivityStatus.awatingCancellation:
        return ButtonState.disable;

      case CarActivityStatus.success:
        return ButtonState.enable;
      default:
        return ButtonState.hide;
    }
  }

  ButtonState get getCallButtonState {
    if (isCompletedBooking) return ButtonState.disable;

    switch (state.bookingDetail?.activityStatus) {
      case CarActivityStatus.paymentPending:
      case CarActivityStatus.awatingConfirmation:
      case CarActivityStatus.awatingCancellation:
      case CarActivityStatus.success:
        return ButtonState.enable;

      default:
        return ButtonState.hide;
    }
  }

  bool get isOngoingBooking =>
      state.bookingDetail?.bookingStatus == CarBookingStatus.confirmed;
  bool get isCompletedBooking =>
      state.bookingDetail?.bookingStatus == CarBookingStatus.completed;

  bool get isPaymentFailed =>
      state.bookingDetail?.carBookingDetails?.paymentStatus ==
          CarBookingPaymentStatus.failed ||
      state.bookingDetail?.activityStatus == CarActivityStatus.paymentFailed;

  Future<void> getCarBookingDetailData(
      {CarBookingDetailArgumentModel? arguments}) async {
    state.pageState = CarBookingDetailPageState.loading;
    emit(state);

    CarBookingDetailUseCasesImpl carBookingDetailUseCasesImpl =
        CarBookingDetailUseCasesImpl();
    Either<Failure, CarBookingDetailDomainModel>? result =
        await carBookingDetailUseCasesImpl.getCarBookingDetailData(
      bookingId: arguments?.bookingId ?? '',
      bookingUrn: arguments?.bookingUrn ?? '',
      bookingType: arguments?.bookingType ?? '',
    );
    if (result?.isRight ?? false) {
      CarBookingDetailDomainModel carBookingDetail = result!.right;
      if (carBookingDetail.carBookingDetailData == null) {
        state.pageState = CarBookingDetailPageState.noData;
      } else {
        state.bookingDetail =
            CarBookingDetailDataModel.fromCarBookingDetailData(
                carBookingDetail.carBookingDetailData!);
        state.pageState = CarBookingDetailPageState.success;
      }
    } else {
      if (result?.left is InternetFailure) {
        state.pageState = CarBookingDetailPageState.failureNetwork;
      } else {
        state.pageState = CarBookingDetailPageState.failure;
      }
    }
    emit(state);
  }

  PaymentDetailsModel? getPaymentMethod() {
    List<PaymentDetailsModel>? carBookingPaymentDetails =
        state.bookingDetail?.carBookingDetails?.paymentDetails;
    PaymentDetailsModel? paymentDetailsModel;
    if (carBookingPaymentDetails != null &&
        carBookingPaymentDetails.isNotEmpty) {
      for (PaymentDetailsModel paymentDetail in carBookingPaymentDetails) {
        if (paymentDetail.type != _kVA) {
          paymentDetailsModel = paymentDetail;
        }
      }
    }

    return paymentDetailsModel;
  }

  PaymentDetailsModel? getWalletPaymentMethod() {
    final List<PaymentDetailsModel>? paymentDetails =
        state.bookingDetail?.carBookingDetails?.paymentDetails;
    if (paymentDetails != null && paymentDetails.isNotEmpty) {
      for (PaymentDetailsModel paymentDetail in paymentDetails) {
        if (paymentDetail.type == _kVA) {
          return paymentDetail;
        }
      }
    }
    return null;
  }
}

enum ButtonState {
  hide,
  enable,
  disable,
}
