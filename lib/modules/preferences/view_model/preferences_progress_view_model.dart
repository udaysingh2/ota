import 'package:ota/modules/preferences/view_model/preferences_argument_model.dart';

class PreferencesProgressViewModel {
  int currentQuestionNumber;
  List<PreferencesModel> preferenceModelList;

  PreferencesProgressViewModel({
    this.currentQuestionNumber = 1,
    required this.preferenceModelList,
  });
}

class PreferencesModel {
  String questionId;
  String description1;
  String description2;
  bool multiChoice;
  int minNum;
  int selectedOptions;
  String backgroundImageUrl;
  List<OptionModel> options;

  PreferencesModel({
    required this.questionId,
    required this.description1,
    required this.description2,
    required this.multiChoice,
    required this.minNum,
    required this.selectedOptions,
    required this.backgroundImageUrl,
    required this.options,
  });

  factory PreferencesModel.fromArgument(
      PreferencesArgumentModel preferencesArgumentModel) {
    return PreferencesModel(
      questionId: preferencesArgumentModel.questionId ?? '',
      description1: preferencesArgumentModel.description1 ?? '',
      description2: preferencesArgumentModel.description2 ?? '',
      multiChoice: preferencesArgumentModel.multiChoice ?? false,
      minNum: (preferencesArgumentModel.minNum == null ||
              preferencesArgumentModel.minNum! < 1)
          ? 1
          : preferencesArgumentModel.minNum!,
      selectedOptions: 0,
      backgroundImageUrl: preferencesArgumentModel.backgroundImageUrl ?? '',
      options: preferencesArgumentModel.options != null
          ? preferencesArgumentModel.options!
              .map((e) => OptionModel.fromArguemnt(e))
              .toList()
          : [],
    );
  }
}

class OptionModel {
  String optionCode;
  String optionDesc;
  String imageUrl;
  bool isSelected;

  OptionModel({
    required this.optionCode,
    required this.optionDesc,
    required this.imageUrl,
    this.isSelected = false,
  });

  factory OptionModel.fromArguemnt(OptionArgumentModel optionArgumentModel) {
    return OptionModel(
      optionCode: optionArgumentModel.optionCode ?? '',
      optionDesc: optionArgumentModel.optionDesc ?? '',
      imageUrl: optionArgumentModel.imageUrl ?? '',
    );
  }
}
