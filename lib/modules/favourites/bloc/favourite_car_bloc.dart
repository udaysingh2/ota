import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/favourites/models/favourites_carrental_model_domain.dart';
import 'package:ota/domain/favourites/usecasees/favourites_service_use_cases.dart';
import 'package:ota/domain/favourites/usecasees/favourites_use_cases_car_rental.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'package:ota/modules/favourites/view_model/favourite_car_list_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_car_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';
import '../../../domain/favourites/models/unfavourite_model_domain.dart';

const int _kFavouritesLimit = 20;
const String _kSuccessCode = "1000";

class FavouritesCarBloc extends Bloc<FavouritesCarListViewModel> {
  FavouritesCarRentalUseCases favouritesUseCases =
      FavouritesCarRentalUseCasesImpl();
  FavouritesServiceUseCases serviceUseCasesImpl =
      FavouritesServiceUseCasesImpl();

  int get getPageSize => _kFavouritesLimit;
  bool _isNewDataRequired = true;

  setNewDataRequired() {
    _isNewDataRequired = false;
  }

  setInternetPopupShown() {
    state.isInternetPopupShown = true;
  }

  bool get isNewDataRequired {
    return _isNewDataRequired;
  }

  @override
  initDefaultValue() {
    return FavouritesCarListViewModel(
      favouritesList: [],
    );
  }

  List<FavouritesCarViewModel> _getFavouritesViewModelList(
      List<Favorite> favouritesListModel) {
    return favouritesListModel
        .map((e) => FavouritesCarViewModel.fromCarModel(e))
        .toList();
  }

  removeFavourite(int index) async {
    state.favouritesScreenState = OtaFavouritesPageState.unFavoriteLoading;
    emit(state);

    Either<Failure, UnFavouriteModelDomain>? result =
        (await serviceUseCasesImpl.unFavouriteCarRental(
      carId: state.favouritesList[index].id,
      supplierId: state.favouritesList[index].supplierId ?? "",
      serviceName: state.favouritesList[index].serviceName,
    ));

    if (result != null &&
        result.isRight &&
        result.right.status?.code == _kSuccessCode) {
      state.favouritesScreenState = OtaFavouritesPageState.unFavoriteSuccess;
      state.favouritesList.removeAt(index);
      emit(state);
      return;
    } else {
      if (result?.left is InternetFailure) {
        state.favouritesScreenState =
            OtaFavouritesPageState.unFavoriteInternetFailure;
      } else {
        state.favouritesScreenState = OtaFavouritesPageState.unFavoriteFailure;
      }
      emit(state);
    }
  }

  Future<void> getFavouriteData({
    bool refreshData = true,
    required String type,
    bool isForceFetch = false,
  }) async {
    if (isForceFetch) {
      state.favouritesScreenState = OtaFavouritesPageState.loading;
      emit(state);
    } else if (state.favouritesScreenState ==
            OtaFavouritesPageState.emptyData ||
        state.favouritesScreenState ==
            OtaFavouritesPageState.emptyInternetFailureRefresh) {
      state.favouritesScreenState =
          OtaFavouritesPageState.emptyDataPullDownLoading;
      emit(state);
    } else if (state.favouritesScreenState == OtaFavouritesPageState.failure) {
      state.favouritesScreenState =
          OtaFavouritesPageState.errorCasePullDownLoading;
      emit(state);
    } else {
      state.favouritesScreenState = refreshData && state.favouritesList.isEmpty
          ? OtaFavouritesPageState.loading
          : OtaFavouritesPageState.pullDownLoading;
      emit(state);
    }

    Either<Failure, FavouritesCarRentalModelDomain>? result =
        (await favouritesUseCases.getFavouritesData(
      type: FavouriteHelper.getServiceType(type),
      offset: refreshData ? 0 : state.favouritesList.length,
      limit: _kFavouritesLimit,
    ));

    if (result != null && result.isRight) {
      if (result.right.getAllFavorites != null) {
        List<FavouritesCarViewModel> resultFavoriteList =
            _getFavouritesViewModelList(
                result.right.getAllFavorites?.data?.favorites ?? []);
        _isNewDataRequired = resultFavoriteList.length == _kFavouritesLimit;

        if (refreshData) {
          state.favouritesList.clear();
        }

        if (state.favouritesList.isEmpty) {
          state.favouritesList = resultFavoriteList;
        } else {
          state.favouritesList.addAll(resultFavoriteList);
        }
      }

      state.isInternetPopupShown = false;
      if (state.favouritesList.isEmpty) {
        state.favouritesScreenState = OtaFavouritesPageState.emptyData;
        emit(state);
      } else {
        state.favouritesScreenState = OtaFavouritesPageState.success;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      if (state.favouritesScreenState == OtaFavouritesPageState.loading) {
        _isNewDataRequired = true;
        state.favouritesScreenState = OtaFavouritesPageState.internetFailure;
        emit(state);
        return;
      } else if (state.favouritesScreenState ==
          OtaFavouritesPageState.emptyDataPullDownLoading) {
        state.favouritesScreenState =
            OtaFavouritesPageState.emptyInternetFailureRefresh;
        emit(state);
        return;
      } else {
        state.favouritesScreenState =
            OtaFavouritesPageState.internetFailureRefresh;
        _isNewDataRequired = true;
        emit(state);
        return;
      }
    } else {
      _isNewDataRequired = true;
      state.favouritesScreenState = OtaFavouritesPageState.failure;
      emit(state);
    }
  }

  updateEmptyState() {
    state.favouritesScreenState = OtaFavouritesPageState.emptyData;
    emit(state);
    return;
  }
}
