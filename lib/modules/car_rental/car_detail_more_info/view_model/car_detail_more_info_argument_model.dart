import 'car_detail_more_info_view_model.dart';

class CarDetailMoreInfoArgumentModel {
  CarDetailMoreInfoPickType carDetailMoreInfoPickType;
  String includedInRentalPriceHtmlText;
  String carRentalConditionHtmlText;
  String pickUpHtmlText;
  CarDetailMoreInfoArgumentModel({
    this.carDetailMoreInfoPickType =
        CarDetailMoreInfoPickType.includedInRentalPrice,
    required this.includedInRentalPriceHtmlText,
    required this.carRentalConditionHtmlText,
    required this.pickUpHtmlText,
  });
}
