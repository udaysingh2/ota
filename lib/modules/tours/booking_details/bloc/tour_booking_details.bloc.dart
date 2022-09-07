import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart';
import 'package:ota/domain/tours/tour_booking_detail/use_cases/tour_booking_details_usecases.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_detail_argument.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_package_detail_view_model.dart';

const _kDefaultCoordinates = "0.0";

class TourBookingDetailsBloc extends Bloc<TourBookingDetailsViewModel> {
  @override
  TourBookingDetailsViewModel initDefaultValue() {
    return TourBookingDetailsViewModel(
        pageState: TourBookingDetailsPageStates.initial);
  }

  Future<void> getTourBookingDetailsData(
      TourBookingDetailArgument? argument) async {
    if (argument == null) {
      emit(TourBookingDetailsViewModel(
          pageState: TourBookingDetailsPageStates.failure));
      return;
    }
    TourBookingDetailUseCasesImpl tourBookingDetailUseCasesImpl =
        TourBookingDetailUseCasesImpl();
    await mapTourBookingDetailsData(tourBookingDetailUseCasesImpl, argument);
  }

  Future<void> mapTourBookingDetailsData(
      TourBookingDetailUseCasesImpl tourBookingDetailUseCasesImpl,
      TourBookingDetailArgument argument) async {
    emit(TourBookingDetailsViewModel(
        pageState: TourBookingDetailsPageStates.loading));
    Either<Failure, TourBookingDetailModelDomain?>? result =
        await tourBookingDetailUseCasesImpl
            .getBookingTourDetail(argument.toTourBookingDetailArgumentDomain());

    if (result?.isRight ?? false) {
      TourBookingDetailModelDomain? data = result!.right;
      if (data?.otaBookingDetails?.data?.tourBookingDetail != null) {
        emit(TourBookingDetailsViewModel(
            pageState: TourBookingDetailsPageStates.success,
            data: TourBookingDetailsData.fromDomain(
                data!.otaBookingDetails!.data!),
            packageDetail: TourBookingPackageDetailViewModel.mapFromTourPackage(
                data.otaBookingDetails!.data!.tourBookingDetail!
                    .packageDetail!)));
      } else {
        emit(TourBookingDetailsViewModel(
            pageState: TourBookingDetailsPageStates.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(TourBookingDetailsViewModel(
          pageState: TourBookingDetailsPageStates.internetFailure));
    } else {
      emit(TourBookingDetailsViewModel(
          pageState: TourBookingDetailsPageStates.failure));
    }
  }

  TourBookingWalletPaymentDetails? get walletPaymentDetails =>
      state.data?.walletPaymentDetails;

  bool get isMeetingPointValid =>
      (state.data!.location != null && state.data!.location!.isNotEmpty) ||
      (state.packageDetail != null && state.packageDetail!.isNotEmpty()) ||
      (state.packageDetail!.meetingPoint != null &&
          state.packageDetail!.meetingPoint!.isNotEmpty) ||
      (state.packageDetail!.meetingPointLatitude != null &&
          state.packageDetail!.meetingPointLatitude != _kDefaultCoordinates) ||
      (state.packageDetail!.meetingPointLongitude != null &&
          state.packageDetail!.meetingPointLongitude != _kDefaultCoordinates);

  bool get isProviderDetailsAvialable => ((state.data!.providerName != null &&
          state.data!.providerName!.isNotEmpty) ||
      (state.data!.supplierContact != null &&
          state.data!.supplierContact!.isNotEmpty));
}
