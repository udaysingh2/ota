class CarInfoReservationModel {
  final CarInfoReservationModelState state;

  CarInfoReservationModel(
      {this.state = CarInfoReservationModelState.collapsed});
}

enum CarInfoReservationModelState { expanded, collapsed }
