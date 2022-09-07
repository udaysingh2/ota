import 'package:ota/core_components/bloc/bloc.dart';

class TourConfirmBookingCollapseExpandBloc
    extends Bloc<TourPaymentReviewCollapseExpandState> {
  @override
  TourPaymentReviewCollapseExpandState initDefaultValue() {
    return TourPaymentReviewCollapseExpandState.isCollapsed;
  }

  void toggle() {
    if (state == TourPaymentReviewCollapseExpandState.isCollapsed) {
      emit(TourPaymentReviewCollapseExpandState.isExpanded);
    } else {
      emit(TourPaymentReviewCollapseExpandState.isCollapsed);
    }
  }
}

enum TourPaymentReviewCollapseExpandState {
  isExpanded,
  isCollapsed,
}
