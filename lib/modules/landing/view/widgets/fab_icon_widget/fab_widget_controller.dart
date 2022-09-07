import 'dart:core';
import 'package:ota/core_components/bloc/bloc.dart';

import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_widget_model.dart';

class FabWidgetController extends Bloc<FabWidgetModel> {
  @override
  FabWidgetModel initDefaultValue() {
    return FabWidgetModel();
  }

  void setExpanded() {
    emit(FabWidgetModel(fabWidgetState: FabWidgetState.isExpanded));
  }

  void setCollapsed() {
    emit(FabWidgetModel(fabWidgetState: FabWidgetState.collapsed));
  }

  void notExpanded() {
    emit(FabWidgetModel(fabWidgetState: FabWidgetState.collapsed));
  }

  bool isExpanded() {
    return state.fabWidgetState == FabWidgetState.isExpanded;
  }

  void toggle() {
    if (state.fabWidgetState == FabWidgetState.isExpanded) {
      emit(FabWidgetModel(fabWidgetState: FabWidgetState.collapsed));
    } else {
      emit(FabWidgetModel(fabWidgetState: FabWidgetState.isExpanded));
    }
  }

  FabWidgetState getState() {
    return state.fabWidgetState;
  }
}
