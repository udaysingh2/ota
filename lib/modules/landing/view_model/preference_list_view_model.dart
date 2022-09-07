import 'package:ota/modules/landing/view_model/preferences_view_model.dart';

class PreferenceListViewModel {
  List<PreferencesViewModel> preferencesList;
  PreferencesListViewModelState preferencesListViewModelState;

  PreferenceListViewModel({
    required this.preferencesList,
    this.preferencesListViewModelState = PreferencesListViewModelState.none,
  });
}

enum PreferencesListViewModelState {
  none,
  loading,
  success,
  failure,
}
