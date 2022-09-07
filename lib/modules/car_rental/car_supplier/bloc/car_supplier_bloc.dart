import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';
import 'package:ota/domain/car_rental/car_supplier/usecases/car_supplier_use_cases.dart';
import 'package:ota/modules/car_rental/car_supplier/helpers/car_supplier_helper.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_view_model.dart';

class CarSupplierBloc extends Bloc<CarSupplierViewModel> {
  CarSupplierUseCases carSupplierUseCases = CarSupplierUseCasesImpl();

  @override
  CarSupplierViewModel initDefaultValue() {
    return CarSupplierViewModel();
  }

  Future<void> getCarSupplierData(
      CarSupplierArgumentViewModel? argument) async {
    if (argument == null) {
      state.carSupplierViewModelState = CarSupplierViewModelState.failure;
      emit(state);
      return;
    }

    state.carSupplierViewModelState = CarSupplierViewModelState.loading;
    emit(state);

    Either<Failure, CarSupplierModelDomainData>? result =
        await carSupplierUseCases.getCarSupplierData(
            argument:
                CarSupplierArgumentModel.mapFromViewModelArgument(argument));

    if (result != null && result.isRight) {
      if (result.right.getCarRentalSupplier?.data?.supplierData != null) {
        state.carSupplierViewModelState = CarSupplierViewModelState.success;
        state.data = CarSupplierHelper.getCarSupplierList(
            result.right.getCarRentalSupplier?.data?.supplierData ?? []);
        state.promotionListData = CarSupplierHelper.getPromotionListData(
            result.right.getCarRentalSupplier?.data?.promotionList ?? []);
        state.freeFoodDelivery = CarSupplierHelper.freeFoodFlag(
            result.right.getCarRentalSupplier?.data?.freeFoodDelivery);
        emit(state);
      } else {
        state.carSupplierViewModelState = CarSupplierViewModelState.failure;
        emit(state);
      }
    } else {
      if (result?.left is InternetFailure) {
        state.carSupplierViewModelState =
            CarSupplierViewModelState.failureNetwork;
        emit(state);
      }
    }
  }
}
