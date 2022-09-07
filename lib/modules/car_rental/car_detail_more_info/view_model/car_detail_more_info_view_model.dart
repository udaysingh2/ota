class CarDetailMoreInfoViewModel {
  CarDetailMoreInfoViewModelType carDetailInfoViewModelType;
  CarDetailMoreInfoPickType carDetailInfoPickType;
  CarDetailMoreInfoIncludedInRentalPrice carDetailMoreInfoIncludedInRentalPrice;
  CarDetailMoreInfoCarRentalCondition carDetailMoreInfoCarRentalCondition;
  CarDetailMoreInfoPickUp carDetailMoreInfoPickUp;
  factory CarDetailMoreInfoViewModel.empty() {
    return CarDetailMoreInfoViewModel(
      carDetailInfoPickType: CarDetailMoreInfoPickType.includedInRentalPrice,
      carDetailInfoViewModelType: CarDetailMoreInfoViewModelType.initial,
      carDetailMoreInfoCarRentalCondition:
          CarDetailMoreInfoCarRentalCondition(description: ""),
      carDetailMoreInfoIncludedInRentalPrice:
          CarDetailMoreInfoIncludedInRentalPrice(description: ""),
      carDetailMoreInfoPickUp: CarDetailMoreInfoPickUp(description: ''),
    );
  }
  CarDetailMoreInfoViewModel({
    required this.carDetailInfoPickType,
    required this.carDetailInfoViewModelType,
    required this.carDetailMoreInfoCarRentalCondition,
    required this.carDetailMoreInfoIncludedInRentalPrice,
    required this.carDetailMoreInfoPickUp,
  });
}

class CarDetailMoreInfoIncludedInRentalPrice {
  String description;
  CarDetailMoreInfoIncludedInRentalPrice({required this.description});
}

class CarDetailMoreInfoCarRentalCondition {
  String description;
  CarDetailMoreInfoCarRentalCondition({required this.description});
}

class CarDetailMoreInfoPickUp {
  String description;
  CarDetailMoreInfoPickUp({required this.description});
}

enum CarDetailMoreInfoViewModelType {
  initial,
  loading,
  loaded,
}
enum CarDetailMoreInfoPickType {
  includedInRentalPrice,
  carRentalCondition,
  pickUp,
}
