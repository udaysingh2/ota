import 'package:ota/core_components/bloc/bloc.dart';

const double _kMaxScrollExtent = 390;

class HotelLandingScrollStateBloc
    extends Bloc<HotelLandingScrollStateBlocState> {
  @override
  HotelLandingScrollStateBlocState initDefaultValue() {
    return HotelLandingScrollStateBlocState.shown;
  }

  void checkScrollListener(double scrollIndex) {
    if (scrollIndex >= _kMaxScrollExtent) {
      if (state == HotelLandingScrollStateBlocState.shown) {
        emit(HotelLandingScrollStateBlocState.hidden);
      }
    } else {
      if (state == HotelLandingScrollStateBlocState.hidden) {
        emit(HotelLandingScrollStateBlocState.shown);
      }
    }
  }
}

enum HotelLandingScrollStateBlocState {
  shown,
  hidden,
}
