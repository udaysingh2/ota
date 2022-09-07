import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_detail/usecases/car_detail_use_cases.dart';
import 'package:ota/modules/car_rental/car_detail/helper/favourite_helper.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_view_model.dart';

import '../../../../domain/car_rental/car_detail/model/add_favorite_argument_model_domain.dart';
import '../../../../domain/car_rental/car_detail/model/add_favourite_model_domain.dart';
import '../../../../domain/car_rental/car_detail/model/check_favourite_domain_model.dart';
import '../../../../domain/favourites/models/unfavourite_model_domain.dart';
import '../view_model/car_rental_favorites_view_model.dart';

const String _kSuccessCode = "1000";
const String _kFailureCode = "1899";

class CarRentalFavoritesBloc extends Bloc<CarRentalFavoritesViewModel> {
  final CarDetailUseCases _carDetailUseCasesImpl = CarDetailUseCasesImpl();
  @override
  CarRentalFavoritesViewModel initDefaultValue() {
    return CarRentalFavoritesViewModel();
  }

  Future<void> checkFavorites(
      String carId, String supplierId, String serviceName) async {
    state.unFavoriteCarRentalState = UnFavoriteCarRentalState.none;
    state.addFavoriteCarRentalState = AddFavoriteCarRentalState.none;

    Either<Failure, CheckFavouriteDomainModel>? result =
        await _carDetailUseCasesImpl.checkFavouriteCar(
            carId: carId, supplierId: supplierId, serviceName: serviceName);
    if (result != null && result.isRight) {
      CheckFavouriteDomainModel isFavorites = result.right;
      bool checkFavourite =
          isFavorites.checkCarFavorites?.data?.isFavorite ?? false;
      if (checkFavourite) {
        state.heartButtonType = CarRentalDetailHeartButtonType.selected;
        emit(state);
      }
    }
  }

  Future<void> removeFavouriteCar(
      String serviceName, String id, String supplierId) async {
    state.unFavoriteCarRentalState = UnFavoriteCarRentalState.loading;
    emit(state);

    Either<Failure, UnFavouriteModelDomain>? result =
        (await _carDetailUseCasesImpl.unfavouritesCar(
            id: id, serviceName: serviceName, supplierId: supplierId));

    if (result != null &&
        result.isRight &&
        result.right.status?.code == _kSuccessCode) {
      state.unFavoriteCarRentalState = UnFavoriteCarRentalState.success;
      state.heartButtonType = CarRentalDetailHeartButtonType.unselected;
      emit(state);
      return;
    } else {
      if (result?.left is InternetFailure) {
        state.unFavoriteCarRentalState =
            UnFavoriteCarRentalState.failureNetwork;
        emit(state);
      } else {
        state.unFavoriteCarRentalState = UnFavoriteCarRentalState.failure;
        emit(state);
      }
    }
  }

  updateUnfavouritesCarState() {
    state.unFavoriteCarRentalState = UnFavoriteCarRentalState.none;
  }

  Future<void> addFavouriteCar(
      AddFavoriteArgumentModelDomain favoriteArgumentModelDomain,
      String serviceName) async {
    state.addFavoriteCarRentalState = AddFavoriteCarRentalState.loading;
    emit(state);

    Either<Failure, AddfavouriteModelDomain>? result =
        (await _carDetailUseCasesImpl.addFavouriteCar(
            favoriteArgumentModel: favoriteArgumentModelDomain,
            serviceName: serviceName));

    if (result != null && result.isRight) {
      AddfavouriteModelDomain favoriteModel = result.right;
      if (favoriteModel.addFavorite?.status?.code == _kSuccessCode) {
        state.addFavoriteCarRentalState = AddFavoriteCarRentalState.success;
        state.heartButtonType = CarRentalDetailHeartButtonType.selected;
        emit(state);
        return;
      } else if (favoriteModel.addFavorite?.status?.code == _kFailureCode) {
        state.addFavoriteCarRentalState = FavoriteHelper.getAddFavoriteState(
            favoriteModel.addFavorite?.status?.header ?? "");
        emit(state);
        return;
      }
    } else {
      if (result?.left is InternetFailure) {
        state.addFavoriteCarRentalState =
            AddFavoriteCarRentalState.failureNetwork;
        emit(state);
      } else {
        state.addFavoriteCarRentalState = AddFavoriteCarRentalState.failure;
        emit(state);
      }
    }
  }

  updateAddfavouritesCarState() {
    state.addFavoriteCarRentalState = AddFavoriteCarRentalState.none;
  }
}
