import 'package:flutter/cupertino.dart';
import 'package:ota/core_components/bloc/bloc.dart';

import 'ota_horizontal_playlist_model.dart';

const int _kCountTime = 100;
const double _kMaxHeight = 5000;

class OtaHorizontalPlayListController extends Bloc<OtaHorizontalPlayListModel> {
  @override
  OtaHorizontalPlayListModel initDefaultValue() {
    return OtaHorizontalPlayListModel(_kMaxHeight);
  }

  Future<void> updateState(GlobalKey key) async {
    await Future.delayed(const Duration(milliseconds: _kCountTime));
    RenderBox? cardBox = key.currentContext?.findRenderObject() as RenderBox?;
    Size? textSize = cardBox?.size;
    if (textSize == null) return;
    if (state.value < textSize.height || state.value == _kMaxHeight) {
      state.value = textSize.height;
      emit(state);
    }
  }

  Future<void> updateStateWithNoEmit(GlobalKey key) async {
    await Future.delayed(const Duration(milliseconds: _kCountTime));
    RenderBox? cardBox = key.currentContext?.findRenderObject() as RenderBox?;
    Size? textSize = cardBox?.size;
    if (textSize == null) return;
    if (state.value < textSize.height || state.value == _kMaxHeight) {
      state.value = textSize.height;
      emit(state);
    }
  }
}
