import 'package:ota/core_components/bloc/bloc.dart';

class PageViewIndicatorBloc extends Bloc<int> {
  @override
  int initDefaultValue() {
    return 0;
  }

  void onIndexChanged(int? index) {
    if (index == null) {
      return;
    }
    if (index != state) emit(index);
  }
}
