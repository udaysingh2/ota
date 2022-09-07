import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/favourites/models/favourites_add_service_domain.dart';
import 'package:ota/domain/favourites/models/favourites_check_service_domain.dart';
import 'package:ota/domain/favourites/models/favourites_remove_service_domain.dart';
import 'package:ota/domain/favourites/usecasees/favourites_service_use_cases.dart';
import 'package:ota/modules/favourites/view_model/ota_favourite_argument_model.dart';
import 'package:ota/modules/favourites/view_model/ota_favourite_view_model.dart';

const String _kSuccessCode = "1000";
const String _kFailureCode = "1899";
const String _kLimitExceededHeader = "Limit exceeded";

class OtaFavouriteServiceBloc extends Bloc<OtaFavoritesViewModel> {
  FavouritesServiceUseCases serviceUseCasesImpl =
      FavouritesServiceUseCasesImpl();
  @override
  OtaFavoritesViewModel initDefaultValue() {
    return OtaFavoritesViewModel();
  }

  Future<void> checkFavorite(
      {required String serviceName, required String serviceId}) async {
    emit(OtaFavoritesViewModel(
        pageState: FavoritePageState.none, isFavourite: false));

    Either<Failure, FavouriteCheckServiceDomain>? result =
        await serviceUseCasesImpl.checkFavorite(
            serviceName: serviceName, serviceId: serviceId);
    if (result != null && result.isRight) {
      FavouriteCheckServiceDomain isFavorites = result.right;
      bool checkFavorite = isFavorites.isFavorite?.data?.isFavorite ?? false;
      emit(OtaFavoritesViewModel(
          pageState: FavoritePageState.success, isFavourite: checkFavorite));
    } else {
      emit(OtaFavoritesViewModel(
          pageState: FavoritePageState.failure, isFavourite: false));
    }
  }

  Future<void> removeFavorite(
      {required String serviceName, required String serviceId}) async {
    emit(OtaFavoritesViewModel(
        pageState: FavoritePageState.loading, isFavourite: true));

    Either<Failure, FavouriteRemoveServiceDomain>? result =
        (await serviceUseCasesImpl.removeFavorite(
      serviceName: serviceName,
      serviceId: serviceId,
    ));

    if (result != null && result.isRight) {
      if ((result.right.removeFavorite?.status?.code == _kSuccessCode)) {
        emit(OtaFavoritesViewModel(
            pageState: FavoritePageState.success, isFavourite: false));
      } else {
        emit(OtaFavoritesViewModel(
            pageState: FavoritePageState.unFavoriteFailure, isFavourite: true));
      }
    } else if (result?.left is InternetFailure) {
      emit(OtaFavoritesViewModel(
          pageState: FavoritePageState.unfavouriteInternetFailure,
          isFavourite: true));
    } else {
      emit(OtaFavoritesViewModel(
          pageState: FavoritePageState.unFavoriteFailure, isFavourite: true));
    }
  }

  Future<void> markFavorite(
      OtaFavoritesArgumentModel favoriteArgumentModel) async {
    emit(OtaFavoritesViewModel(
        pageState: FavoritePageState.loading, isFavourite: false));

    Either<Failure, FavouriteAddServiceDomain>? result =
        (await serviceUseCasesImpl.markFavorite(
            favoriteArgumentModel:
                favoriteArgumentModel.toFavoritesArgumentDomainModel()));

    if (result != null && result.isRight) {
      FavouriteAddServiceDomain favoriteModel = result.right;
      if (favoriteModel.markFavorite?.status?.code == _kSuccessCode) {
        emit(OtaFavoritesViewModel(
            pageState: FavoritePageState.success, isFavourite: true));
      } else if (favoriteModel.markFavorite?.status?.code == _kFailureCode &&
          favoriteModel.markFavorite?.status?.header == _kLimitExceededHeader) {
        emit(OtaFavoritesViewModel(
            pageState: FavoritePageState.failureMaxLimit, isFavourite: false));
      } else {
        emit(OtaFavoritesViewModel(
            pageState: FavoritePageState.addFavouriteFailure,
            isFavourite: false));
      }
    } else if (result?.left is InternetFailure) {
      emit(OtaFavoritesViewModel(
          pageState: FavoritePageState.addfavouriteInternetFailure,
          isFavourite: false));
    } else {
      emit(OtaFavoritesViewModel(
          pageState: FavoritePageState.addFavouriteFailure,
          isFavourite: false));
    }
  }
}
