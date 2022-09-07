import 'package:ota/core_components/bloc/bloc.dart';

import '../../favourites/view/widgets/favourites_options/favourites_options_model.dart';

const String kHotelKey = "hotel_key";

class OtaBookingOptionsController extends Bloc<FavouritesOptionsModel> {
  @override
  FavouritesOptionsModel initDefaultValue() {
    return FavouritesOptionsModel(
      listingOptionsState: FavouritesOptionsState.collapsed,
      chosenOption: kHotelKey,
    );
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

  get chosenOption => state.chosenOption;

  FavouritesOptionsState getState() {
    return state.listingOptionsState;
  }
}
