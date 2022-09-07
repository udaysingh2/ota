import 'package:ota/domain/insurance/models/insurance_model_domain.dart';

class InsuranceViewModel {
  InsuranceModelData? data;
  InsuranceViewModelState pageState;
  InsuranceViewModel({this.data, required this.pageState});
}

class InsuranceModelData {
  String? serviceBackgroundUrl;
  String? insuranceHeaderTitle;
  String? insuranceFooterTitle;
  List<InsuranceListItem>? insurances;

  InsuranceModelData({
    this.serviceBackgroundUrl,
    this.insuranceHeaderTitle,
    this.insuranceFooterTitle,
    this.insurances,
  });

  factory InsuranceModelData.fromData(Data data) {
    return InsuranceModelData(
      insuranceFooterTitle: data.insuranceFooterTitle,
      insuranceHeaderTitle: data.insuranceHeaderTitle,
      serviceBackgroundUrl: data.serviceBackgroundUrl,
      insurances: data.insurances == null
          ? []
          : List.generate(
              data.insurances!.length,
              (index) => InsuranceListItem.fromInsurance(
                data.insurances![index],
              ),
            ),
    );
  }
}

class InsuranceListItem {
  final int? insuranceId;
  final int? sortSeqNo;
  final String? insuranceImage;
  final String? insuranceTitle;
  final String? insuranceDetail;
  final InsurancePromotion? promotions;
  final InsurancePopup? popup;

  InsuranceListItem({
    this.insuranceId,
    this.sortSeqNo,
    this.insuranceImage,
    this.insuranceTitle,
    this.insuranceDetail,
    this.promotions,
    this.popup,
  });

  factory InsuranceListItem.fromInsurance(Insurance listItem) {
    return InsuranceListItem(
      insuranceId: listItem.insuranceId,
      sortSeqNo: listItem.sortSeqNo,
      insuranceImage: listItem.insuranceImage,
      insuranceTitle: listItem.insuranceTitle,
      insuranceDetail: listItem.insuranceDetail,
      promotions: InsurancePromotion.mapFromPromotions(listItem.promotions),
      popup: InsurancePopup.mapFromPopup(listItem.popup),
    );
  }
}

class InsurancePromotion {
  final String? type;
  final String? promotionTextLine1;

  InsurancePromotion({this.type, this.promotionTextLine1});

  factory InsurancePromotion.mapFromPromotions(Promotions? promotion) {
    return InsurancePromotion(
        type: promotion?.type,
        promotionTextLine1: promotion?.promotionTextLine1);
  }
}

class InsurancePopup {
  final String? body;
  final String? actionType;
  final String? actionUrl;
  bool? urlStatus;
  InsurancePopup({this.body, this.actionType, this.actionUrl, this.urlStatus});

  factory InsurancePopup.mapFromPopup(Popup? popup) {
    return InsurancePopup(
      actionType: popup?.actionType,
      body: popup?.body,
      actionUrl: popup?.actionUrl,
    );
  }
}

enum InsuranceViewModelState {
  initial,
  loading,
  pullDownLoading,
  pullDownLoadingFailureNetwork,
  success,
  failure,
  failureNetwork,
  failure1899,
  failure1999,
}
