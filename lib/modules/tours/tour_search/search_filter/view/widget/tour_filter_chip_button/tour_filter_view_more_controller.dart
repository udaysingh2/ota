import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc.dart';

const int _kDefaultVisibleRows = 3;
const double _kVisibleRowHeight = kSize36;

class TourFilterViewMoreController extends Bloc<TourFilterViewMoreModel> {
  @override
  TourFilterViewMoreModel initDefaultValue() {
    return TourFilterViewMoreModel(
        visibleHeight: _kDefaultVisibleRows * _kVisibleRowHeight);
  }

  void viewMoreToggle() {
    if (state.visibleHeight != double.infinity) {
      state.visibleHeight = double.infinity;
    } else {
      state.visibleHeight = _kDefaultVisibleRows * _kVisibleRowHeight;
    }
    emit(state);
    return;
  }

  bool isExpanded() {
    return state.visibleHeight == double.infinity;
  }
}

class TourFilterViewMoreModel {
  double visibleHeight;
  TourFilterViewMoreModel({
    required this.visibleHeight,
  });
}
