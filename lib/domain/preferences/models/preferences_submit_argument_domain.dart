import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/modules/preferences/helpers/preferences_helper.dart';
import 'package:ota/modules/preferences/view_model/preferences_progress_view_model.dart';

class PreferencesSubmitArgumentDomain {
  final List<PreferencesSubmitModel> preferences;
  PreferencesSubmitArgumentDomain({required this.preferences});

  factory PreferencesSubmitArgumentDomain.fromPreferencesModel(
      List<PreferencesModel>? preferenceModelList) {
    return PreferencesSubmitArgumentDomain(
      preferences:
          PreferencesHelper.getPreferencesSubmitModelList(preferenceModelList),
    );
  }

  List<Map<String, dynamic>> toMap() =>
      preferences.map((e) => e.toMap()).toList();
}

class PreferencesSubmitModel {
  final String questionId;
  final String description;
  final List<PreferencesAnswerModel> answers;
  PreferencesSubmitModel({
    required this.questionId,
    required this.description,
    required this.answers,
  });

  factory PreferencesSubmitModel.fromPreferencesModel(
      PreferencesModel preferencesModel) {
    return PreferencesSubmitModel(
      questionId: preferencesModel.questionId,
      description: preferencesModel.description1,
      answers: PreferencesHelper.getPreferencesAnswerModelList(
          preferencesModel.options),
    );
  }

  Map<String, dynamic> toMap() => {
        "questionId": questionId.surroundWithDoubleQuote(),
        "description": description.surroundWithDoubleQuote(),
        "answers": answers.map((e) => e.toMap()).toList(),
      };
}

class PreferencesAnswerModel {
  final String optionCode;
  final String optionDesc;
  PreferencesAnswerModel({required this.optionCode, required this.optionDesc});

  factory PreferencesAnswerModel.fromOptionModel(OptionModel optionModel) {
    return PreferencesAnswerModel(
      optionCode: optionModel.optionCode,
      optionDesc: optionModel.optionDesc,
    );
  }

  Map<String, dynamic> toMap() => {
        "optionCode": optionCode.surroundWithDoubleQuote(),
        "optionDesc": optionDesc.surroundWithDoubleQuote(),
      };
}
