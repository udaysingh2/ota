import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';

class PromoWidgetBloc extends Bloc<PromoWidgetViewModel> {
  @override
  PromoWidgetViewModel initDefaultValue() {
    return PromoWidgetViewModel();
  }

  void emitAppliedPromoData(PromoCodeData promoData) {
    emit(PromoWidgetViewModel(
        promoState: PromoWidgetState.appliedPromo, data: promoData));
  }

  void removePromodata() {
    emit(PromoWidgetViewModel(promoState: PromoWidgetState.noPromo));
  }

  void initPreviousAppliedPromo(PromoWidgetViewModel? promoWidgetViewModel) {
    if (promoWidgetViewModel?.data != null) {
      state.promoState = promoWidgetViewModel!.promoState;
      state.data = promoWidgetViewModel.data;
      emit(state);
    }
  }
}
