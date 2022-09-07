class OtaBannerModel {
  CustomMaterialState customMaterialState;
  OtaBannerModel({this.customMaterialState = CustomMaterialState.initial});
}

enum CustomMaterialState { initial, shown, hidden, disposed }
