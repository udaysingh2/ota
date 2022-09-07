
class CarSearchPickUpPointsModel {
  List locationList;
  String cityId;
  CarSearchPickUpPointsState carSearchPickUpPointsState;
  CarSearchPickUpPointsModel({required this.locationList,required this.cityId,this.carSearchPickUpPointsState = CarSearchPickUpPointsState.none});
}

enum CarSearchPickUpPointsState { none, pickUpPointsAvailable,loading, failure ,internetFailure}
