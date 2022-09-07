import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'favourites_options_model.dart';

class FavouritesOptionsController extends Bloc<FavouritesOptionsModel> {
  @override
  FavouritesOptionsModel initDefaultValue() {
    return FavouritesOptionsModel(
        listingOptionsState: FavouritesOptionsState.collapsed,
        chosenOption:
            FavouriteHelper.isAllFavoritesEnabled() ? "all_key" : "hotel_key");
  }

  void setExpanded() {
    state.listingOptionsState = FavouritesOptionsState.isExpanded;
    emit(state);
  }

  void setCollapsed() {
    state.listingOptionsState = FavouritesOptionsState.collapsed;
    emit(state);
  }

  bool isExpanded() {
    return state.listingOptionsState == FavouritesOptionsState.isExpanded;
  }

  void toggle() {
    if (state.listingOptionsState == FavouritesOptionsState.isExpanded) {
      state.listingOptionsState = FavouritesOptionsState.collapsed;
    } else {
      state.listingOptionsState = FavouritesOptionsState.isExpanded;
    }
    emit(state);
  }

  void updateSelectedOption(String selectedOption) {
    state.chosenOption = selectedOption;
    setCollapsed();
  }

  FavouritesOptionsState getState() {
    return state.listingOptionsState;
  }
}
