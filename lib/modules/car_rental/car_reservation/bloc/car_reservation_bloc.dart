import 'package:either_dart/either.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import '../../../../common/network/failures.dart';
import '../../../../domain/car_rental/car_reservation/models/car_reservation_domain_model.dart';
import '../../../../domain/car_rental/car_reservation/usecases/car_reservation_usecases.dart';
import '../view_model/car_reservation_argument_view_model.dart';
import '../view_model/car_reservation_view_model.dart';

const String kSuccessCode = '1000';
const String kErrorCode1899 = "1899";
const String _kUnavailableHeaderError = 'Information Not Available';

class CarReservationBloc extends Bloc<CarReservationViewModel> {
  CarReservationUseCases carReservationUseCases = CarReservationUseCasesImpl();
  @override
  initDefaultValue() {
    return CarReservationViewModel(
        carDetailInfoModel: CarDetailInfoModel(isCarAvailable: true),
        pageState: CarReservationPageState.initial);
  }

  Future<void> saveCarReservationData(
      CarReservationViewArgumentModel? carReservationViewArgumentModel,
      {isRefresh = false}) async {
    if (carReservationViewArgumentModel == null) {
      state.pageState = CarReservationPageState.failure;
      emit(state);
      return;
    }
    if (!isRefresh) {
      state.pageState = CarReservationPageState.loading;
      emit(state);
    }

    Either<Failure, CarReservationScreenDomainData>? result =
        await carReservationUseCases.getCarReservationData(
            carReservationViewArgumentModel
                .toCarReservationDomainArgumentModel());

    if (result?.isRight ?? false) {
      CarReservationScreenDomainData getCarReservation = result!.right;
      String? statusCode =
          getCarReservation.getCarInitiateBookingResponse?.status?.code;
      String? header =
          getCarReservation.getCarInitiateBookingResponse?.status?.header;
      if (statusCode == kSuccessCode) {
        emit(CarReservationViewModel(
          pageState: CarReservationPageState.success,
          carDetailInfoModel: CarDetailInfoModel.fromCarDetailInforModel(
              getCarReservation.getCarInitiateBookingResponse?.data),
        ));
      } else if (statusCode == kErrorCode1899 &&
          header == _kUnavailableHeaderError) {
        emit(CarReservationViewModel(
            pageState: CarReservationPageState.failureUnAvailable));
      } else {
        emit(CarReservationViewModel(
            pageState: CarReservationPageState.failure));
      }
    } else {
      if (result?.left is InternetFailure) {
        state.pageState = CarReservationPageState.failureNetwork;
        emit(state);
      } else {
        emit(CarReservationViewModel(
            pageState: CarReservationPageState.failure));
        emit(state);
      }
    }
  }

  bool get isValidationRequired =>
      state.pageState == CarReservationPageState.success ||
      state.pageState == CarReservationPageState.failureUnAvailable;
}
