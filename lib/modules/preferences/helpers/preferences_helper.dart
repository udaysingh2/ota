import 'package:ota/domain/preferences/models/preferences_submit_argument_domain.dart';
import 'package:ota/modules/landing/view_model/preferences_view_model.dart';
import 'package:ota/modules/preferences/view_model/preferences_argument_model.dart';
import 'package:ota/modules/preferences/view_model/preferences_progress_view_model.dart';

class PreferencesHelper {
  static List<PreferencesArgumentModel> getPreferenceArgumentList(
      List<PreferencesViewModel>? list) {
    List<PreferencesArgumentModel>? preferenceArgumentList;
    if (list == null || list.isEmpty) return [];

    preferenceArgumentList = List<PreferencesArgumentModel>.generate(
      list.length,
      (index) => PreferencesArgumentModel.fromViewModel(list[index]),
    );

    return preferenceArgumentList.toList();
  }

  static List<PreferencesModel> getPreferenceList(
      List<PreferencesArgumentModel>? list) {
    List<PreferencesModel>? preferenceList;
    if (list == null || list.isEmpty) return [];

    preferenceList = List<PreferencesModel>.generate(
      list.length,
      (index) => PreferencesModel.fromArgument(list[index]),
    );

    return preferenceList.toList();
  }

  static List<PreferencesAnswerModel> getPreferencesAnswerModelList(
      List<OptionModel>? options) {
    List<PreferencesAnswerModel> preferencesAnswerList = [];

    for (OptionModel optionModel in options ?? []) {
      if (optionModel.isSelected) {
        preferencesAnswerList
            .add(PreferencesAnswerModel.fromOptionModel(optionModel));
      }
    }

    return preferencesAnswerList;
  }

  static List<PreferencesSubmitModel> getPreferencesSubmitModelList(
      List<PreferencesModel>? preferenceModelList) {
    List<PreferencesSubmitModel> preferenceSubmitList;
    if (preferenceModelList == null || preferenceModelList.isEmpty) return [];

    preferenceSubmitList = List<PreferencesSubmitModel>.generate(
      preferenceModelList.length,
      (index) => PreferencesSubmitModel.fromPreferencesModel(
          preferenceModelList[index]),
    );

    return preferenceSubmitList.toList();
  }
}
