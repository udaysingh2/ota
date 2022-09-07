import 'package:ota/domain/car_rental/car_search_filter/model/car_search_filter_domain_model.dart';

class CarSearchFilterViewModel {
  CarSearchFilterModel? carSearchFilter;
  CarSearchFilterPageState pageState;
  CarSearchFilterViewModel({
    required this.pageState,
    this.carSearchFilter,
  });
}

enum CarSearchFilterPageState {
  initial,
  loading,
  success,
  failure,
  failureNetwork,
  noFilterData, //depend on car search result available filter
  noFilterValue, //depend on sort criteria
}

class CarSearchFilterModel {
  CarSearchFilterModel({
    required this.sortInfo,
    required this.criteria,
  });

  final List<CriterionModel>? sortInfo;
  final List<CriterionModel>? criteria;

  factory CarSearchFilterModel.fromCarSearchFilterData(
      CarSearchFilterData data) {
    return CarSearchFilterModel(
      sortInfo: data.sortInfo == null
          ? []
          : List<CriterionModel>.from(
              data.sortInfo!.map((info) => CriterionModel.fromCriterion(info))),
      criteria: data.criteria == null
          ? []
          : List<CriterionModel>.from(
              data.criteria!.map((info) => CriterionModel.fromCriterion(info))),
    );
  }
}

class CriterionModel {
  CriterionModel({
    this.displayTitle,
    this.sortSeq,
    this.value,
    this.description,
  });

  final String? displayTitle;
  final int? sortSeq;
  final String? value;
  final String? description;

  factory CriterionModel.fromCriterion(Criterion criterion) {
    return CriterionModel(
      displayTitle: criterion.displayTitle,
      sortSeq: criterion.sortSeq,
      value: criterion.value,
      description: criterion.description,
    );
  }
}
