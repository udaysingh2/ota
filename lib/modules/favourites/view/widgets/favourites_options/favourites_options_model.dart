class FavouritesOptionsModel {
  FavouritesOptionsState listingOptionsState;
  String chosenOption;
  FavouritesOptionsModel(
      {this.listingOptionsState = FavouritesOptionsState.collapsed,
      this.chosenOption = "hotel_key"});
}

enum FavouriteService {
  all,
  hotel,
  toursAndTickets,
  carRental,
  flights,
  tour,
  tickets,
  none,
}
enum FavouritesOptionsState { isExpanded, collapsed }
