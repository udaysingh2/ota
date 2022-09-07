import 'package:ota/core_components/bloc/bloc.dart';

//This code will be the part of debugger // No performance test needed or
//Extensive review needed
class TestBloc extends Bloc<bool> {
  @override
  bool initDefaultValue() {
    return false;
  }

  void setTrue() {
    emit(true);
  }

  void setFalse() {
    emit(false);
  }
}

class ShowOverlayBloc extends Bloc<bool> {
  @override
  bool initDefaultValue() {
    return false;
  }

  void show() {
    emit(true);
  }

  void hide() {
    emit(false);
  }
}
