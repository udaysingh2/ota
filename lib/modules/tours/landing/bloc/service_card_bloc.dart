import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/tours/service_card/usecases/service_card_usecases.dart';
import 'package:ota/modules/tours/landing/view_model/service_card_view_model.dart';

class ServiceCardBloc extends Bloc<ServiceCardViewModel> {
  @override
  ServiceCardViewModel initDefaultValue() {
    return ServiceCardViewModel();
  }

  Future<void> getServiceCardData() async {
    state.pageState = ServiceCardPageState.loading;
    emit(state);

    ServiceCardUseCasesImpl serviceCardUseCases = ServiceCardUseCasesImpl();
    Either<Failure, ServiceCardModelDomain?>? result =
        await serviceCardUseCases.getServiceCardData();
    if (result?.isRight ?? false) {
      ServiceCardModelDomain? serviceCardResult = result!.right;
      String? statusCode = serviceCardResult?.getTourServiceCards?.status?.code;
      if (statusCode == kErrorCode1899) {
        state.pageState = ServiceCardPageState.failure1899;
        emit(state);
      } else if (statusCode == kErrorCode1999) {
        state.pageState = ServiceCardPageState.failure1999;
        emit(state);
      } else if (statusCode == kSuccessCode) {
        Ticket? ticket = serviceCardResult?.getTourServiceCards?.data?.ticket;
        Ticket? tour = serviceCardResult?.getTourServiceCards?.data?.tour;
        if (tour != null) {
          state.tourServiceModel = ServiceCardModel.mapFromServiceCard(tour);
        }
        if (ticket != null) {
          state.ticketServiceModel =
              ServiceCardModel.mapFromServiceCard(ticket);
        }
        state.pageState = ServiceCardPageState.success;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      state.pageState = ServiceCardPageState.internetFailure;
      emit(state);
    } else {
      state.pageState = ServiceCardPageState.failure;
      emit(state);
    }
  }

  bool get isLoading => state.pageState == ServiceCardPageState.loading;

  bool get isFailure =>
      state.pageState == ServiceCardPageState.failure ||
      state.pageState == ServiceCardPageState.failure1899 ||
      state.pageState == ServiceCardPageState.failure1999 ||
      state.pageState == ServiceCardPageState.internetFailure;

  bool get isSuccess => state.pageState == ServiceCardPageState.success;

  bool get isServiceCardAvailable =>
      state.ticketServiceModel != null || state.tourServiceModel != null;
}
