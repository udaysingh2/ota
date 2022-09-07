import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_model.dart';
import 'package:ota/domain/car_rental/car_detail/usecases/car_detail_use_cases.dart';
import 'package:ota/modules/car_rental/car_date_time_selection/model/car_date_time_selection_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_view_model.dart';

class CarDetailViewBloc extends Bloc<CarDetailViewModel> {
  @override
  CarDetailViewModel initDefaultValue() {
    return CarDetailViewModel(
      pageState: CarDetailViewPageState.loading,
      carDetailInfo: CarDetailInfoModel(),
    );
  }

  setCarDetail(CarDetailArgumentModel? argument) {
    if (argument != null) {
      state.carDetailInfo = CarDetailInfoModel(
        carDetail: CarDetailModel(
          car: CarModel(id: argument.carId),
        ),
        carInfo: CarInfoModel(id: argument.carId),
        fromDate: argument.pickupDate,
        toDate: argument.returnDate,
      );

      CarDetailModel();
    }
  }

  updateDateAndTime(CarDateTimePickerArgumentModel? dateTime) {
    if (dateTime != null) {
      state.carDetailInfo?.fromDate = dateTime.pickUpDate;
      state.carDetailInfo?.toDate = dateTime.dropOffDate;
      emit(state);
    }
  }

  Future<void> getCarDetail(
      CarDetailArgumentModel? argument, bool isRefresh) async {
    if (argument == null) {
      state.pageState = CarDetailViewPageState.failure;
      emit(state);
      return;
    }

    if (!isRefresh) {
      state.pageState = CarDetailViewPageState.loading;
      emit(state);
    }

    CarDetailUseCasesImpl carDetailUseCasesImpl = CarDetailUseCasesImpl();
    Either<Failure, CarDetailDomainModel>? result =
        await carDetailUseCasesImpl.getCarDetail(
      state.carDetailInfo!.toCarDetailDomainArgumentModel(argument),
    );

    if (result?.isRight ?? false) {
      CarDetailDomainModel data = result!.right;
      CarDetailInfo? carDetailInfo = data.carDetailInfo;

      if (carDetailInfo == null) {
        state.pageState = CarDetailViewPageState.failure;
        emit(state);
      } else {
        if (carDetailInfo.carInfo == null) {
          state.pageState = CarDetailViewPageState.failure;
        } else {
          state.carDetailInfo = CarDetailInfoModel.mapFromCarDetailInfo(
            carDetailInfo,
            argument,
            state.carDetailInfo?.fromDate,
            state.carDetailInfo?.toDate,
          );
          if (carDetailInfo.carDeatil == null ||
              carDetailInfo.carDeatil?.car == null) {
            state.pageState = CarDetailViewPageState.noData;
          } else {
            state.pageState = CarDetailViewPageState.success;
          }
        }
        emit(state);
      }
    } else {
      if (result?.left is InternetFailure) {
        state.pageState = CarDetailViewPageState.failureNetwork;
        emit(state);
      } else {
        state.pageState = CarDetailViewPageState.failure;
        emit(state);
      }
    }
    return;
  }
}
