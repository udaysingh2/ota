import 'package:flutter_test/flutter_test.dart';

import 'package:ota/domain/car_rental/car_supplier/repositories/car_supplier_repository_impl.dart';
import 'package:ota/domain/car_rental/car_supplier/usecases/car_supplier_use_cases.dart';
import 'package:ota/modules/car_rental/car_supplier/bloc/car_supplier_bloc.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_view_model.dart';

import '../../../hotel/repositories/internet_failure_mock.dart';

import '../repositories/car_supplier_impl_success_mock_with_null_data.dart';
import '../repositories/car_supplier_remote_data_source_impl.dart';
import '../repositories/car_supplier_usecases_impl_mock.dart';

void main() {
  CarSupplierBloc bloc = CarSupplierBloc();
  CarSupplierArgumentViewModel argument = CarSupplierArgumentViewModel(
    brandName: "",
  );

  test('Car Supplier bloc with Mocked repository with null data pass',
      () async {
    bloc.carSupplierUseCases = CarSupplierUseCasesImpl(
        repository: CarSupplierRepositoryImplSuccessMock());
    bloc.getCarSupplierData(argument);
    expect(bloc.state.carSupplierViewModelState,
        CarSupplierViewModelState.loading);
  });

  test("Car Supplier Bloc with mocked repository with Internet Failure", () {
    bloc.carSupplierUseCases = CarSupplierUseCasesImpl(
        repository: CarSupplierRepositoryImpl(
            remoteDataSource: CarSupplierRemoteDataSourceImplSuccessMock(),
            internetInfo: InternetFailureMock()));
    bloc.getCarSupplierData(argument);
    expect(bloc.state.carSupplierViewModelState,
        CarSupplierViewModelState.loading);
  });
  test("Car Supplier Bloc with mocked repository", () {
    bloc.carSupplierUseCases = CarSupplierUseCasesImpl(
        repository: CarSupplierRepositoryImplSuccessMockNull());
    bloc.getCarSupplierData(argument);
    expect(bloc.state.carSupplierViewModelState,
        CarSupplierViewModelState.loading);
  });

  test("Car Supplier Bloc with mocked repository and gallery data", () {
    bloc.carSupplierUseCases = CarSupplierUseCasesImpl(
        repository: CarSupplierRepositoryImplSuccessMock());
    bloc.getCarSupplierData(argument);
    expect(bloc.state.carSupplierViewModelState,
        CarSupplierViewModelState.loading);

    bloc.state.promotionListData = [
      PromotionListData(
          description: "",
          productType: "",
          promotionCode: "",
          title: "",
          web: "")
    ];
    bloc.state.data = [
      CarSupplierData(
        totalPrice: 2,
        refCode: "",
        rateKey: "",
        pricePerDay: 2,
      )
    ];
    expect(bloc.state.promotionListData.length, 1);
    expect(bloc.state.promotionListData[0].description, "");
    expect(bloc.state.data.length, 1);
    expect(bloc.state.data[0].totalPrice, 2);
  });
}
