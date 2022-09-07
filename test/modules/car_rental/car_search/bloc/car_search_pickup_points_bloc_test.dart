import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/bloc/car_search_pick_up_points_bloc.dart';

void main(){

  test("Testing Blocs Loading State", (){
    String searchText = "Phuket";
    final CarSearchPickUpPointsBloc carSearchPickUpPointsBloc = CarSearchPickUpPointsBloc();
    carSearchPickUpPointsBloc.fetchPickUpLocations(searchText);
    expect(carSearchPickUpPointsBloc.isStateLoading, true);
  });

  test("Testing Blocs Failure State if search Text empty", (){
    final CarSearchPickUpPointsBloc carSearchPickUpPointsBloc = CarSearchPickUpPointsBloc();
    String searchText = "";
    carSearchPickUpPointsBloc.fetchPickUpLocations(searchText);
    expect(carSearchPickUpPointsBloc.isStateFailure, true);
  });

  test("Testing Blocs Initial State", (){
    final CarSearchPickUpPointsBloc carSearchPickUpPointsBloc = CarSearchPickUpPointsBloc();
    expect(carSearchPickUpPointsBloc.isStateNone, true);
  });



}