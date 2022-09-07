import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_model.dart';

const int _kDelayTime = 100;

class PopupController extends Bloc<PopupModelState> {
  @override
  PopupModelState initDefaultValue() {
    return PopupModelState.initial;
  }

  void setAsLoaded() async {
    await Future.delayed(const Duration(milliseconds: _kDelayTime));
    if (state != PopupModelState.loaded) emit(PopupModelState.loaded);
  }

   void setAsClosed() {
    if (state != PopupModelState.closed) emit(PopupModelState.closed);
  }

  bool isLoaded() {
    return state == PopupModelState.loaded;
  }
}
