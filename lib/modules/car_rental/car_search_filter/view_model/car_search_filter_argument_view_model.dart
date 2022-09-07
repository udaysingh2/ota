import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_argument_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_view_model.dart';

class CarSearchFilterArgumentViewModel {
  final AvailableFilterViewModel? availableFilterViewModel;
  final FilterValue? selectedFilter;

  CarSearchFilterArgumentViewModel({
    this.availableFilterViewModel,
    this.selectedFilter,
  });
}
