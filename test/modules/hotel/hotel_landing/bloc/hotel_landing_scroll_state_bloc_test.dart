import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_landing_scroll_state_bloc.dart';

void main() {
  HotelLandingScrollStateBloc bloc = HotelLandingScrollStateBloc();

  test('For HotelLandingScrollStateBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual, HotelLandingScrollStateBlocState.shown);
    expect(actual.index, 0);
  });

  test('If offSet is greater than 391.0 for checkScrollListener()', () {
    bloc.checkScrollListener(getMaxOffSet());

    expect(bloc.state, HotelLandingScrollStateBlocState.hidden);
  });

  test('If offSet is less than 389.0 for checkScrollListener()', () {
    bloc.checkScrollListener(getMinOffSet());

    expect(bloc.state, HotelLandingScrollStateBlocState.shown);
  });
}

double getMinOffSet() => 389.0;
double getMaxOffSet() => 391.0;
