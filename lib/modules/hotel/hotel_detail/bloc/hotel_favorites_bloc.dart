import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/usecases/hotel_detail_use_cases.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/favourite_helper.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_favorites_view_model.dart';

class HotelFavoritesBloc extends Bloc<HotelFavoritesViewModel> {
  HotelDetailUseCasesImpl hotelDetailUseCasesImpl = HotelDetailUseCasesImpl();
  @override
  HotelFavoritesViewModel initDefaultValue() {
    return HotelFavoritesViewModel();
  }

  Future<void> checkFavorites(String type, String hotelId) async {
    Either<Failure, IsFavoritesDomain>? result = await hotelDetailUseCasesImpl
        .checkFavouriteHotel(type: type, hotelId: hotelId);
    if (result != null && result.isRight) {
      IsFavoritesDomain isFavorites = result.right;
      bool checkFavorite =
          isFavorites.checkFavorites?.data?.isFavorite ?? false;
      if (checkFavorite) {
        state.heartButtonType = HotelDetailHeartButtonType.selected;
        emit(state);
      }
    }
  }

  removeFavouriteHotel(String type, String hotelId) async {
    state.unFavoriteHotelState = UnFavoriteHotelState.loading;
    emit(state);

    Either<Failure, DeleteFavoriteModelDomain>? result =
        (await hotelDetailUseCasesImpl.unfavouritesHotel(
      type: type,
      hotelId: hotelId,
    ));

    if (result != null && result.isRight) {
      String? statusCode = result.right.deleteFavorite?.status?.code;
      if (statusCode == kSuccessCode) {
        state.unFavoriteHotelState = UnFavoriteHotelState.success;
        state.heartButtonType = HotelDetailHeartButtonType.unselected;
        emit(state);
        return;
      }
    } else if (result?.left is InternetFailure) {
      state.unFavoriteHotelState = UnFavoriteHotelState.internetFailure;
      emit(state);
      return;
    }

    state.unFavoriteHotelState = UnFavoriteHotelState.failure;
    emit(state);
  }

  updateUnfavouritesHotelState() {
    state.unFavoriteHotelState = UnFavoriteHotelState.none;
  }

  addFavouriteHotel(
      AddFavoriteArgumentModelDomain favoriteArgumentModel) async {
    state.addFavoriteHotelState = AddFavoriteHotelState.loading;
    emit(state);

    Either<Failure, AddFavoriteModelDomain>? result =
        (await hotelDetailUseCasesImpl.addFavouriteHotel(
            favoriteArgumentModel: favoriteArgumentModel));

    if (result != null && result.isRight) {
      AddFavoriteModelDomain favoriteModel = result.right;
      if (favoriteModel.addFavorite?.status?.code == kSuccessCode) {
        state.addFavoriteHotelState = AddFavoriteHotelState.success;
        state.heartButtonType = HotelDetailHeartButtonType.selected;
        emit(state);
        return;
      } else if (favoriteModel.addFavorite?.status?.code == kErrorCode1899) {
        state.addFavoriteHotelState = FavoriteHelper.getAddFavoriteState(
            favoriteModel.addFavorite?.status?.header ?? "");
        emit(state);
        return;
      }
    } else if (result?.left is InternetFailure) {
      state.addFavoriteHotelState = AddFavoriteHotelState.internetFailure;
      emit(state);
      return;
    }

    state.addFavoriteHotelState = AddFavoriteHotelState.failure;
    emit(state);
  }

  updateAddfavouritesHotelState() {
    state.addFavoriteHotelState = AddFavoriteHotelState.none;
  }
}
