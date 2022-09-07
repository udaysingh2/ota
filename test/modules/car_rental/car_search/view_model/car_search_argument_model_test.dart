import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_argument_model.dart';

void main() {
  CarLandingBloc bloc = CarLandingBloc();
  test('car search argument model test ...', () async {
    final carSearchArgumentModel =
        CarSearchArgumentModel(carLandingBloc: bloc, cityId: 'cityId');

    expect(carSearchArgumentModel.cityId, 'cityId');
  });
}
