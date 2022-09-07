class HeartButtonCarRentalModel {
  HeartButtonCarRentalState heartButtonCarRentalState;
  HeartButtonCarRentalModel(
      {this.heartButtonCarRentalState = HeartButtonCarRentalState.disabled});
}

enum HeartButtonCarRentalState {
  disabled,
  selected,
  unselected,
}
