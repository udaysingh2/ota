import 'package:ota/core_components/bloc/bloc.dart';

const double _kMaxScrollExtent = 70;

class TourLandingScrollStateBloc extends Bloc<TourLandingScrollStateBlocState> {
  @override
  TourLandingScrollStateBlocState initDefaultValue() {
    return TourLandingScrollStateBlocState.shown;
  }

  void checkScrollListener(double scrollIndex) {
    if (scrollIndex >= _kMaxScrollExtent) {
      if (state == TourLandingScrollStateBlocState.shown) {
        emit(TourLandingScrollStateBlocState.hidden);
      }
    } else {
      if (state == TourLandingScrollStateBlocState.hidden) {
        emit(TourLandingScrollStateBlocState.shown);
      }
    }
  }
}

enum TourLandingScrollStateBlocState {
  shown,
  hidden,
}
