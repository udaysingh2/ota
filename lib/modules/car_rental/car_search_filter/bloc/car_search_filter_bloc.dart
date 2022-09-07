import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_search_filter/model/car_search_filter_domain_model.dart';
import 'package:ota/domain/car_rental/car_search_filter/usecases/car_search_filter_use_cases.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_view_model.dart';

const String _kPromotionValue = "criteria_rbh_pro";
const String _kCarType = "car_type";
const String _kCarBrand = "car_brand";
const String _kCarServiceProvider = "car_service_provider";

class CarSearchFilterBloc extends Bloc<CarSearchFilterViewModel> {
  bool _isPromotionFilterAvailable = false;
  bool _isCarTypeFilterAvailable = false;
  bool _isCarBrandFilterAvailable = false;
  bool _isCarSupplierFilterAvailable = false;
  bool get isPromotionFilterAvailable => _isPromotionFilterAvailable;
  bool get isCarTypeFilterAvailable => _isCarTypeFilterAvailable;
  bool get isCarBrandFilterAvailable => _isCarBrandFilterAvailable;
  bool get isCarSupplierFilterAvailable => _isCarSupplierFilterAvailable;

  @override
  CarSearchFilterViewModel initDefaultValue() {
    return CarSearchFilterViewModel(
      pageState: CarSearchFilterPageState.initial,
      carSearchFilter: CarSearchFilterModel(
        sortInfo: [],
        criteria: [],
      ),
    );
  }

  Future<void> getCarSearchFilterData(
      {CarSearchFilterArgumentViewModel? arguments}) async {
    if (arguments == null || arguments.availableFilterViewModel == null) {
      state.pageState = CarSearchFilterPageState.noFilterData;
      emit(state);
      return;
    }
    state.pageState = CarSearchFilterPageState.loading;
    emit(state);

    CarSearchFilterUseCasesImpl carSearchFilterUseCasesImpl =
        CarSearchFilterUseCasesImpl();
    Either<Failure, CarSearchFilterDomainModel>? result =
        await carSearchFilterUseCasesImpl.getCarSearchFilterData();
    if (result?.isRight ?? false) {
      CarSearchFilterDomainModel carSearchFilter = result!.right;
      if (carSearchFilter.filterData == null) {
        state.pageState = CarSearchFilterPageState.noFilterValue;
      } else {
        state.carSearchFilter = CarSearchFilterModel.fromCarSearchFilterData(
            carSearchFilter.filterData!);
        _setAvailbleFilter();
        state.pageState = CarSearchFilterPageState.success;
      }
      emit(state);
    } else {
      if (result?.left is InternetFailure) {
        state.pageState = CarSearchFilterPageState.failureNetwork;
        emit(state);
      } else {
        state.pageState = CarSearchFilterPageState.failure;
        emit(state);
      }
    }
  }

  _setAvailbleFilter() {
    List<CriterionModel> criterias = state.carSearchFilter?.criteria ?? [];
    for (var criteria in criterias) {
      if (criteria.value == _kPromotionValue) {
        _isPromotionFilterAvailable = true;
      } else if (criteria.value == _kCarType) {
        _isCarTypeFilterAvailable = true;
      } else if (criteria.value == _kCarBrand) {
        _isCarBrandFilterAvailable = true;
      } else if (criteria.value == _kCarServiceProvider) {
        _isCarSupplierFilterAvailable = true;
      }
    }
  }
}
