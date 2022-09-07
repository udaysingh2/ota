import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_detail_model_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_details/use_cases/hotel_booking_detail_use_cases.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_detail_argument.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_view_model.dart';

const String _kVA = "VA";

class HotelBookingDetailsBloc extends Bloc<HotelBookingDetailsViewModel> {
  @override
  HotelBookingDetailsViewModel initDefaultValue() {
    return HotelBookingDetailsViewModel(
        pageState: HotelBookingDetailsPageState.initial);
  }

  Future<void> getHotelBookingDetailsData(
      HotelBookingDetailArgument? argument) async {
    if (argument == null) {
      emit(HotelBookingDetailsViewModel(
          pageState: HotelBookingDetailsPageState.failure));
      return;
    }
    HotelBookingDetailUseCasesImpl hotelBookingDetailUseCasesImpl =
        HotelBookingDetailUseCasesImpl();
    await mapHotelBookingDetailsData(hotelBookingDetailUseCasesImpl, argument);
  }

  Future<void> mapHotelBookingDetailsData(
      HotelBookingDetailUseCasesImpl hotelBookingDetailUseCasesImpl,
      HotelBookingDetailArgument argument) async {
    emit(HotelBookingDetailsViewModel(
        pageState: HotelBookingDetailsPageState.loading));
    Either<Failure, HotelBookingDetailModelDomain?>? result =
        await hotelBookingDetailUseCasesImpl.getBookingHotelDetail(
            argument.toHotelBookingDetailArgumentDomain());

    if (result?.isRight ?? false) {
      HotelBookingDetailModelDomain? data = result!.right;
      if (data != null &&
          data.data != null &&
          data.data?.bookingStatusCode != null) {
        emit(HotelBookingDetailsViewModel(
            pageState: HotelBookingDetailsPageState.success,
            data: HotelBookingDetailsData.fromDomain(data.data!, argument)));
      } else {
        emit(HotelBookingDetailsViewModel(
            pageState: HotelBookingDetailsPageState.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(HotelBookingDetailsViewModel(
          pageState: HotelBookingDetailsPageState.internetFailure));
    } else {
      emit(HotelBookingDetailsViewModel(
          pageState: HotelBookingDetailsPageState.failure));
    }
  }

  /// The current date = card payment confirm date + 1
  bool isCardPaymentConfirmDateCriteriaSuccess() {
    if (state.data!.confirmationDate == null) return false;
    if (state.data!.checkOutDate.isEmpty) return false;

    final DateTime confirmationPlusDate = Helpers()
        .parseDateTime(state.data!.confirmationDate!)
        .add(const Duration(days: 1));
    final DateTime checkOutDate = Helpers.getOnlyDateFromDateTime(
        Helpers().parseDateTime(state.data!.checkOutDate));

    DateTime confirmDate =
        Helpers.getOnlyDateFromDateTime(confirmationPlusDate);
    DateTime currentDate = Helpers.getOnlyDateFromDateTime(DateTime.now());
    return ((confirmDate == currentDate) ||
            (currentDate.isAfter(confirmDate))) &&
        (currentDate.isBefore(checkOutDate));
  }

  HotelBookingDetailsPaymentDetails? getPaymentMethod() {
    List<HotelBookingDetailsPaymentDetails>? hotelBookingPaymentDetails =
        state.data?.hotelBookingDetailsPaymentDetails;
    HotelBookingDetailsPaymentDetails? hotelBookingDetailsPaymentDetails;
    if (hotelBookingPaymentDetails != null &&
        hotelBookingPaymentDetails.isNotEmpty) {
      for (HotelBookingDetailsPaymentDetails paymentDetail
          in hotelBookingPaymentDetails) {
        if (paymentDetail.type != _kVA) {
          hotelBookingDetailsPaymentDetails = paymentDetail;
        }
      }
    }

    return hotelBookingDetailsPaymentDetails;
  }

  HotelBookingDetailsPaymentDetails? getWalletPaymentMethod() {
    final List<HotelBookingDetailsPaymentDetails>? paymentDetails =
        state.data?.hotelBookingDetailsPaymentDetails;
    if (paymentDetails != null && paymentDetails.isNotEmpty) {
      for (HotelBookingDetailsPaymentDetails paymentDetail in paymentDetails) {
        if (paymentDetail.type == _kVA) {
          return paymentDetail;
        }
      }
    }
    return null;
  }
}
