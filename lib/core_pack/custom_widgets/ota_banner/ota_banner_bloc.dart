import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner_model.dart';

const Duration _kAnimatedDuration = Duration(milliseconds: 100);
const Duration _kCustomBannerDuration = Duration(milliseconds: 2000);

class CustomMaterialBannerBloc extends Bloc<OtaBannerModel> {
  @override
  OtaBannerModel initDefaultValue() {
    return OtaBannerModel();
  }

  double? getTop(double topHeight) {
    if (state.customMaterialState == CustomMaterialState.initial) {
      return (-topHeight);
    } else if (state.customMaterialState == CustomMaterialState.shown) {
      return (kSize0);
    } else if (state.customMaterialState == CustomMaterialState.disposed) {
      return (-topHeight);
    } else if (state.customMaterialState == CustomMaterialState.hidden) {
      return (-topHeight);
    }
    return null;
  }

  void showBanner(OverlayEntry entry) async {
    await Future.delayed(_kAnimatedDuration);
    state.customMaterialState = CustomMaterialState.shown;
    emit(state);
    await Future.delayed(_kCustomBannerDuration);
    state.customMaterialState = CustomMaterialState.hidden;
    emit(state);
    await Future.delayed(_kAnimatedDuration);
    entry.remove();
  }
}
