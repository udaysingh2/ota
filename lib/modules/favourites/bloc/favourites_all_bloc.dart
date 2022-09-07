import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/favourites/models/favourites_all_model_domain.dart';
import 'package:ota/domain/favourites/models/unfavourite_model_domain.dart';
import 'package:ota/domain/favourites/usecasees/favourite_use_cases_all.dart';
import 'package:ota/domain/favourites/usecasees/favourites_service_use_cases.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_all_list_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_all_view_model.dart';

const int _kFavouritesLimit = 20;
const String _kSuccessCode = "1000";

class FavouritesAllBloc extends Bloc<FavouritesAllListViewModel> {
  FavouritesAllUseCasesImpl favouritesUseCases = FavouritesAllUseCasesImpl();
  FavouritesServiceUseCases serviceUseCasesImpl =
      FavouritesServiceUseCasesImpl();

  int get getPageSize => _kFavouritesLimit;
  bool _isNewDataRequired = true;
  bool get isNewDataRequired => _isNewDataRequired;
  setNewDataRequired() {
    _isNewDataRequired = false;
  }

  @override
  initDefaultValue() {
    return FavouritesAllListViewModel(favouritesList: []);
  }

  Future<void> getFavouritesAllData(
      {bool refreshData = true,
      required String type,
      bool isForceFetch = false}) async {
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

    Either<Failure, FavouritesAllModelDomain>? result =
        (await favouritesUseCases.getFavouritesData(
      type: FavouriteHelper.getServiceType(type),
      offset: refreshData ? 0 : state.favouritesList.length,
      limit: _kFavouritesLimit,
    ));

    if (result != null && result.isRight) {
      if (result.right.getFavorites != null) {
        List<FavouritesAllViewModel> resultFavoriteList =
            _getFavouritesViewModelList(
                result.right.getFavorites?.data?.favorites ?? []);
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
        emit(state);
        return;
      }
    } else {
      _isNewDataRequired = true;
      state.favouritesScreenState = OtaFavouritesPageState.failure;
      emit(state);
    }
  }

  List<FavouritesAllViewModel> _getFavouritesViewModelList(
      List<Favorite> favouritesListModel) {
    return favouritesListModel
        .map((e) => FavouritesAllViewModel.fromAllModel(e))
        .toList();
  }

  Future<void> removeAllFavourite(
      {required FavouritesAllViewModel favourites,
      required String serviceName}) async {
    state.favouritesScreenState = OtaFavouritesPageState.unFavoriteLoading;
    emit(state);

    FavouriteService service =
        FavouriteHelper.getServiceTypeKey(favourites.serviceName);
    Either<Failure, UnFavouriteModelDomain>? result =
        await (service == FavouriteService.hotel
            ? serviceUseCasesImpl.unfavouriteHotel(
                serviceName: favourites.serviceName,
                hotelId: favourites.id,
              )
            : service == FavouriteService.carRental
                ? serviceUseCasesImpl.unFavouriteCarRental(
                    serviceName: favourites.serviceName,
                    supplierId: favourites.supplierId ?? '',
                    carId: favourites.id,
                  )
                : serviceUseCasesImpl.unfavouriteTours(
                    serviceName: favourites.serviceName,
                    serviceId: favourites.id,
                  ));

    if (result != null && result.isRight) {
      if (result.right.status?.code == _kSuccessCode) {
        state.favouritesScreenState = OtaFavouritesPageState.unFavoriteSuccess;
        state.favouritesList.remove(favourites);
        emit(state);
      } else {
        state.favouritesScreenState = OtaFavouritesPageState.unFavoriteFailure;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      state.favouritesScreenState =
          OtaFavouritesPageState.unFavoriteInternetFailure;
      emit(state);
    } else {
      state.favouritesScreenState = OtaFavouritesPageState.unFavoriteFailure;
      emit(state);
    }
  }

  updateEmptyState() {
    state.favouritesScreenState = OtaFavouritesPageState.emptyData;
    emit(state);
    return;
  }
}
