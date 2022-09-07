const _kMinNum = 1;

class PreferencesViewModel {
  String questionId;
  String description1;
  String description2;
  bool multiChoice;
  int minNum;
  String backgroundImageUrl;
  List<OptionViewModel> options;
  PreferencesViewModel({
    this.questionId = "",
    this.description1 = "",
    this.description2 = "",
    this.multiChoice = false,
    this.minNum = _kMinNum,
    this.backgroundImageUrl = "",
    this.options = const [],
  });
}

class OptionViewModel {
  String optionCode;
  String optionDesc;
  String imageUrl;
  OptionViewModel({
    this.optionCode = "",
    this.optionDesc = "",
    this.imageUrl = "",
  });
}
