import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

class CarSearchArgumentModel {
  final CarLandingBloc carLandingBloc;
  final bool? isPickUpUpdate;
  final bool? isDifferentDropOff;
  final String cityId;
  final LocationModel? locationModel;
  final List? locationList;
  final String? locationName;
  final bool? isRedirected;
  final bool? isLanding;
  final String? searchText;

  CarSearchArgumentModel(
      {required this.carLandingBloc,
      this.isPickUpUpdate,
      this.isDifferentDropOff,
      required this.cityId,
      this.locationModel,
      this.locationList,
      this.locationName,
      this.isRedirected,
      this.isLanding,
      this.searchText});
}
