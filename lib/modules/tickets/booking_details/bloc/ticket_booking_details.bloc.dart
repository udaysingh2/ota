import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart';
import 'package:ota/domain/tickets/ticket_booking_details/use_cases/ticket_booking_details_usecases.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_detail_argument.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_details_view_model.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_package_detail_view_model.dart';

const _kDefaultCoordinates = "0.0";

class TicketBookingDetailsBloc extends Bloc<TicketBookingDetailsViewModel> {
  @override
  TicketBookingDetailsViewModel initDefaultValue() {
    return TicketBookingDetailsViewModel(
        pageState: TicketBookingDetailsPageStates.initial);
  }

  Future<void> getTicketBookingDetailsData(
      TicketBookingDetailArgument? argument) async {
    if (argument == null) {
      emit(TicketBookingDetailsViewModel(
          pageState: TicketBookingDetailsPageStates.failure));
      return;
    }
    TicketBookingDetailUseCasesImpl ticketBookingDetailUseCasesImpl =
        TicketBookingDetailUseCasesImpl();
    await mapTicketBookingDetailsData(
        ticketBookingDetailUseCasesImpl, argument);
  }

  Future<void> mapTicketBookingDetailsData(
      TicketBookingDetailUseCasesImpl ticketBookingDetailUseCasesImpl,
      argument) async {
    emit(TicketBookingDetailsViewModel(
        pageState: TicketBookingDetailsPageStates.loading));
    Either<Failure, TicketBookingDetailModelDomain?>? result =
        await ticketBookingDetailUseCasesImpl.getBookingTicketDetail(
            argument.toTicketBookingDetailArgumentDomain());

    if (result?.isRight ?? false) {
      TicketBookingDetailModelDomain? data = result!.right;
      if (data?.otaBookingDetails?.data?.ticketBookingDetail != null) {
        emit(TicketBookingDetailsViewModel(
            pageState: TicketBookingDetailsPageStates.success,
            data: TicketBookingDetailsData.fromDomain(
                data!.otaBookingDetails!.data!, argument),
            packageDetail:
                TicketBookingPackageDetailViewModel.mapFromTicketPackage(data
                    .otaBookingDetails!
                    .data!
                    .ticketBookingDetail!
                    .packageDetail)));
      } else {
        emit(TicketBookingDetailsViewModel(
            pageState: TicketBookingDetailsPageStates.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(TicketBookingDetailsViewModel(
          pageState: TicketBookingDetailsPageStates.internetFailure));
    } else {
      emit(TicketBookingDetailsViewModel(
          pageState: TicketBookingDetailsPageStates.failure));
    }
  }

  TicketBookingWalletPaymentDetails? get walletPaymentDetails =>
      state.data?.walletPaymentDetails;
  bool get isMeetingPointValid =>
      (state.data!.location != null && state.data!.location!.isNotEmpty) ||
      (state.packageDetail != null &&
          state.packageDetail!.isNotEmpty() &&
          state.packageDetail!.meetingPoint != null &&
          state.packageDetail!.meetingPoint!.isNotEmpty) ||
      (state.packageDetail != null &&
          state.packageDetail!.isNotEmpty() &&
          state.packageDetail!.meetingPointLatitude != null &&
          state.packageDetail!.meetingPointLatitude!.isNotEmpty &&
          state.packageDetail!.meetingPointLatitude != _kDefaultCoordinates) ||
      (state.packageDetail != null &&
          state.packageDetail!.isNotEmpty() &&
          state.packageDetail!.meetingPointLongitude != null &&
          state.packageDetail!.meetingPointLongitude!.isNotEmpty &&
          state.packageDetail!.meetingPointLongitude != _kDefaultCoordinates);

  bool get isProviderDetailsAvialable => ((state.data!.providerName != null &&
          state.data!.providerName!.isNotEmpty) ||
      (state.data!.supplierContact != null &&
          state.data!.supplierContact!.isNotEmpty));
}
