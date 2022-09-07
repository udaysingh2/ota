import 'package:ota/modules/landing/view_model/preferences_view_model.dart';

class PreferencesArgumentModel {
  String? questionId;
  String? description1;
  String? description2;
  bool? multiChoice;
  int? minNum;
  String? backgroundImageUrl;
  List<OptionArgumentModel>? options;

  PreferencesArgumentModel({
    this.questionId,
    this.description1,
    this.description2,
    this.multiChoice,
    this.minNum,
    this.backgroundImageUrl,
    this.options,
  });

  factory PreferencesArgumentModel.fromViewModel(
      PreferencesViewModel preferencesViewModel) {
    return PreferencesArgumentModel(
      questionId: preferencesViewModel.questionId,
      description1: preferencesViewModel.description1,
      description2: preferencesViewModel.description2,
      backgroundImageUrl: preferencesViewModel.backgroundImageUrl,
      multiChoice: preferencesViewModel.multiChoice,
      minNum: preferencesViewModel.minNum,
      options: preferencesViewModel.options.isNotEmpty
          ? preferencesViewModel.options
              .map((e) => OptionArgumentModel.fromViewModel(e))
              .toList()
          : [],
    );
  }
}

class OptionArgumentModel {
  String? optionCode;
  String? optionDesc;
  String? imageUrl;

  OptionArgumentModel({
    this.optionCode,
    this.optionDesc,
    this.imageUrl,
  });

  factory OptionArgumentModel.fromViewModel(OptionViewModel optionViewModel) {
    return OptionArgumentModel(
      optionCode: optionViewModel.optionCode,
      optionDesc: optionViewModel.optionDesc,
      imageUrl: optionViewModel.imageUrl,
    );
  }
}
