import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/favourites/models/favourites_model_domain.dart';
import 'package:ota/domain/favourites/usecasees/favourites_use_cases.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'package:ota/modules/favourites/view_model/favourite_hotel_list_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_hotel_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';

const int _kFavouritesLimit = 20;

class FavouritesHotelBloc extends Bloc<FavouritesListViewModel> {
  FavouritesUseCases favouritesUseCases = FavouritesUseCasesImpl();
  int get getPageSize => _kFavouritesLimit;
  bool _isNewDataRequired = true;
  bool get isNewDataRequired => _isNewDataRequired;

  void setNewDataRequired() {
    _isNewDataRequired = false;
  }

  @override
  initDefaultValue() {
    return FavouritesListViewModel(
      favouritesList: [],
    );
  }

  Future<void> getFavouriteHotelsData(
      {bool refreshData = true, required String type}) async {
    state.favouritesScreenState = refreshData && state.favouritesList.isEmpty
        ? OtaFavouritesPageState.loading
        : OtaFavouritesPageState.pullDownLoading;
    emit(state);

    Either<Failure, FavoritesModelDomain>? result =
        (await favouritesUseCases.getFavourites(
      type: FavouriteHelper.getServiceType(type),
      offset: refreshData ? 0 : state.favouritesList.length,
      limit: _kFavouritesLimit,
    ));

    if (result != null && result.isRight) {
      if (result.right.getFavorites != null) {
        List<FavouritesHotelViewModel> resultImageList =
            _getFavouritesViewModelList(
                result.right.getFavorites?.data?.favorites ?? []);
        _isNewDataRequired = resultImageList.length == _kFavouritesLimit;

        if (refreshData) {
          state.favouritesList.clear();
        }

        if (state.favouritesList.isEmpty) {
          state.favouritesList = resultImageList;
        } else {
          state.favouritesList.addAll(resultImageList);
        }
      }

      state.favouritesScreenState = OtaFavouritesPageState.success;
    } else if (result?.left is InternetFailure) {
      if (state.favouritesScreenState == OtaFavouritesPageState.loading) {
        _isNewDataRequired = true;
        state.favouritesScreenState = OtaFavouritesPageState.internetFailure;
      } else if (state.favouritesScreenState ==
          OtaFavouritesPageState.emptyDataPullDownLoading) {
        state.favouritesScreenState =
            OtaFavouritesPageState.emptyInternetFailureRefresh;
      } else {
        state.favouritesScreenState =
            OtaFavouritesPageState.internetFailureRefresh;
      }
    } else {
      _isNewDataRequired = true;
      state.favouritesScreenState = OtaFavouritesPageState.failure;
    }
    emit(state);
  }

  List<FavouritesHotelViewModel> _getFavouritesViewModelList(
      List<Favorite> favouritesListModel) {
    return favouritesListModel
        .map((e) => FavouritesHotelViewModel.fromFavoriteModel(e))
        .toList();
  }

  void removeFavouriteHotel(
      FavouritesHotelViewModel favouritesHotel, String type) async {
    state.unFavouritesState = OtaFavouritesPageState.loading;
    emit(state);

    Either<Failure, DeleteFavoriteModelDomain>? result =
        (await favouritesUseCases.unfavouritesHotel(
      type: FavouriteHelper.getServiceType(type),
      hotelId: favouritesHotel.hotelId,
    ));

    if (result != null && result.isRight) {
      String? statusCode = result.right.deleteFavorite?.status?.code;
      if (statusCode == kSuccessCode) {
        state.unFavouritesState = OtaFavouritesPageState.success;
        state.favouritesList.remove(favouritesHotel);
      }
    } else if (result?.left is InternetFailure) {
      if (state.unFavouritesState == OtaFavouritesPageState.loading) {
        state.unFavouritesState = OtaFavouritesPageState.internetFailure;
      } else if (state.unFavouritesState ==
          OtaFavouritesPageState.emptyDataPullDownLoading) {
        state.unFavouritesState =
            OtaFavouritesPageState.emptyInternetFailureRefresh;
      } else {
        state.unFavouritesState = OtaFavouritesPageState.internetFailureRefresh;
      }
    } else {
      state.unFavouritesState = OtaFavouritesPageState.failure;
    }
    emit(state);
  }

  void updateUnfavouritesHotelState() {
    state.unFavouritesState = OtaFavouritesPageState.none;
  }
}
