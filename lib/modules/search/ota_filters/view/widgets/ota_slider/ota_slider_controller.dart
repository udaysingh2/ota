import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc.dart';

import 'ota_slider_controller_model.dart';

class SliderController extends Bloc<SliderControllerModel> {
  @override
  SliderControllerModel initDefaultValue() {
    return SliderControllerModel(rangeValues: const RangeValues(1, 1));
  }

  void updateRange(RangeValues rangeValues) {
    state.rangeValues = rangeValues;
    emit(state);
  }
}
