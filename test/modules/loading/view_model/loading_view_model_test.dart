import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/loading/models/loading_model.dart';
import 'package:ota/modules/loading/view_model/loading_view_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String json = fixture("loading/loading_data.json");
  LoadingModelData? loadingModelData = LoadingModelData.fromJson(json);
  test("Loading View Model", () {
    LoadingViewModel loadingViewModelData =
        LoadingViewModel.mapFromLoadingModel(loadingModelData);
    LoadingViewModel loadingViewModel = LoadingViewModel(
        loadingViewModelState: LoadingViewModelState.loaded,
        imageUrl: loadingViewModelData.imageUrl);
    expect(
        loadingViewModel.loadingViewModelState, LoadingViewModelState.loaded);
  });
}
