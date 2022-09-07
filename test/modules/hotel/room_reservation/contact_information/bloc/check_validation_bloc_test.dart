

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/bloc/check_validation_bloc.dart';

void main() {
  CheckValidationBloc bloc = CheckValidationBloc();

  test('For CheckValidationBloc class ==> initDefaultValue()', (){
    final actual = bloc.initDefaultValue();

    expect(actual, CheckValidationBlocReload.reload);
  });

  test('For CheckValidationBloc class ==> reload()', (){
    bloc.reload();

    expect(bloc.state, CheckValidationBlocReload.reload);
  });
}