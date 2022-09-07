class BannerViewModel {
  List<BannerDataModel> data;
  BannerViewModelState bannerViewModelState;
  BannerViewModel(
      {this.data = const [],
      this.bannerViewModelState = BannerViewModelState.none});
}

class BannerDataModel {
  String imageUrl;
  String deepLinkUrl;
  String bannerId;
  String? function;
  BannerDataModel({this.bannerId ="", this.deepLinkUrl = "", this.imageUrl = "",
  this.function = ""});

  List<BannerDataModel> getDummyData() {
    List<BannerDataModel> dummyList = [
      BannerDataModel(
          bannerId: "bannerId",
          deepLinkUrl: 'https://flutter.io',
          imageUrl:
              "https://images.template.net/wp-content/uploads/2016/03/29072829/Infographic-Free-Sample-Banner-Template.jpg"),
      BannerDataModel(
          bannerId: "bannerId",
          deepLinkUrl:
              'https://en.wikipedia.org/wiki/Deep_linking#:~:text=In%20the%20context%20of%20the%20World%20Wide%20Web%2C,information%20needed%20to%20point%20to%20a%20particular%20item.',
          imageUrl:
              "https://images.template.net/wp-content/uploads/2016/03/29072829/Infographic-Free-Sample-Banner-Template.jpg"),
      BannerDataModel(bannerId: "bannerId", deepLinkUrl: '', imageUrl: "")
    ];
    return dummyList;
  }
}

enum BannerViewModelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
