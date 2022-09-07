import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/usecases/hotel_detail_use_cases.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/hotel_favorites_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_favorites_view_model.dart';

import '../../repositories/hotel_detail_failure_usecase_mock.dart';
import '../../repositories/hotel_detail_success_usecase_error_cases_mock.dart';
import '../../repositories/hotel_detail_success_usecase_mock.dart';

void main() {
  ///Use Case Success
  HotelDetailUseCasesImpl hotelDetailUseCasesSuccessImpl =
      HotelDetailUseCaseImplSuccessMock();

  ///Use case other Screnarios
  HotelDetailUseCasesImpl hotelDetailUseCasesErrorScenariosImpl =
      HotelDetailUseCaseImplErrorCasesMock();

  ///Failure Usecase
  HotelDetailUseCasesImpl hotelDetailUseCasesFailureImpl =
      HotelDetailUseCaseImplFailureMock();

  AddFavoriteArgumentModelDomain favoriteArgumentModel =
      AddFavoriteArgumentModelDomain(
    hotelId: "hotelId",
    cityId: "cityId",
    countryId: "countryId",
    hotelName: "hotelName",
    location: "location",
    hotelImage: "hotelImage",
  );

  HotelFavoritesBloc hotelFavoritesBloc = HotelFavoritesBloc();

  test("Hotel Detail View Bloc Test", () async {
    ///default
    expect(hotelFavoritesBloc.state.addFavoriteHotelState,
        AddFavoriteHotelState.none);
    expect(hotelFavoritesBloc.state.unFavoriteHotelState,
        UnFavoriteHotelState.none);

    ///Case No API Call
    ///Add Favorite
    hotelFavoritesBloc.addFavouriteHotel(favoriteArgumentModel);
    expect(hotelFavoritesBloc.state.addFavoriteHotelState,
        AddFavoriteHotelState.loading);

    ///Remove Favorite
    hotelFavoritesBloc.removeFavouriteHotel("Hotel", "ABC123445");
    expect(hotelFavoritesBloc.state.unFavoriteHotelState,
        UnFavoriteHotelState.loading);

    /// Check Favorite
    hotelFavoritesBloc.checkFavorites("Hotel", "hotelId");
    expect(hotelFavoritesBloc.state.heartButtonType,
        HotelDetailHeartButtonType.unselected);

    /// Upfdate State
    hotelFavoritesBloc.updateUnfavouritesHotelState();
    expect(hotelFavoritesBloc.state.unFavoriteHotelState,
        UnFavoriteHotelState.none);

    hotelFavoritesBloc.updateAddfavouritesHotelState();
    expect(hotelFavoritesBloc.state.addFavoriteHotelState,
        AddFavoriteHotelState.none);

    ///Case when full data available
    hotelFavoritesBloc.hotelDetailUseCasesImpl = hotelDetailUseCasesSuccessImpl;

    ///Add Favorite
    hotelFavoritesBloc.addFavouriteHotel(favoriteArgumentModel);
    Either<Failure, AddFavoriteModelDomain>? resultAdd =
        (await hotelDetailUseCasesSuccessImpl.addFavouriteHotel(
            favoriteArgumentModel: favoriteArgumentModel));
    expect(resultAdd?.isRight, true);
    expect(hotelFavoritesBloc.state.addFavoriteHotelState,
        AddFavoriteHotelState.failureMaxLimit);

    ///Remove Favorite
    hotelFavoritesBloc.removeFavouriteHotel("Hotel", "ABC123445");
    Either<Failure, DeleteFavoriteModelDomain>? resultUnFav =
        (await hotelDetailUseCasesSuccessImpl.unfavouritesHotel(
      type: "Hotel",
      hotelId: "hotelId",
    ));
    expect(resultUnFav?.isRight, true);
    expect(hotelFavoritesBloc.state.unFavoriteHotelState,
        UnFavoriteHotelState.success);

    /// Check Favorite
    hotelFavoritesBloc.checkFavorites("Hotel", "hotelId");
    Either<Failure, IsFavoritesDomain>? resultCheck =
        await hotelDetailUseCasesSuccessImpl.checkFavouriteHotel(
            type: "Hotel", hotelId: "hotelId");
    expect(resultCheck?.isRight, true);
    expect(hotelFavoritesBloc.state.heartButtonType,
        HotelDetailHeartButtonType.unselected);

    ///Case of Failure
    hotelFavoritesBloc.hotelDetailUseCasesImpl = hotelDetailUseCasesFailureImpl;

    ///Add Favorite
    hotelFavoritesBloc.addFavouriteHotel(favoriteArgumentModel);
    Either<Failure, AddFavoriteModelDomain>? resultAddFail =
        (await hotelDetailUseCasesFailureImpl.addFavouriteHotel(
            favoriteArgumentModel: favoriteArgumentModel));
    expect(resultAddFail?.isLeft, true);
    expect(hotelFavoritesBloc.state.addFavoriteHotelState,
        AddFavoriteHotelState.internetFailure);

    ///Remove Favorite
    hotelFavoritesBloc.removeFavouriteHotel("Hotel", "ABC123445");
    Either<Failure, DeleteFavoriteModelDomain>? resultUnFavFail =
        (await hotelDetailUseCasesFailureImpl.unfavouritesHotel(
      type: "Hotel",
      hotelId: "hotelId",
    ));
    expect(resultUnFavFail?.isLeft, true);
    expect(hotelFavoritesBloc.state.unFavoriteHotelState,
        UnFavoriteHotelState.internetFailure);

    /// Check Favorite
    hotelFavoritesBloc.checkFavorites("Hotel", "hotelId");
    Either<Failure, IsFavoritesDomain>? resultCheckFail =
        await hotelDetailUseCasesFailureImpl.checkFavouriteHotel(
            type: "Hotel", hotelId: "hotelId");
    expect(resultCheckFail?.isLeft, true);
    expect(hotelFavoritesBloc.state.heartButtonType,
        HotelDetailHeartButtonType.unselected);

    ///Case Error Scenario
    hotelFavoritesBloc.hotelDetailUseCasesImpl =
        hotelDetailUseCasesErrorScenariosImpl;

    ///Add Favorite
    hotelFavoritesBloc.addFavouriteHotel(favoriteArgumentModel);
    Either<Failure, AddFavoriteModelDomain>? resultAddError =
        (await hotelDetailUseCasesErrorScenariosImpl.addFavouriteHotel(
            favoriteArgumentModel: favoriteArgumentModel));
    expect(resultAddError?.isRight, true);
    expect(hotelFavoritesBloc.state.addFavoriteHotelState,
        AddFavoriteHotelState.success);

    /// Check Favorite
    hotelFavoritesBloc.checkFavorites("Hotel", "hotelId");
    Either<Failure, IsFavoritesDomain>? resultCheckError =
        await hotelDetailUseCasesErrorScenariosImpl.checkFavouriteHotel(
            type: "Hotel", hotelId: "hotelId");
    expect(resultCheckError?.isRight, true);
    expect(hotelFavoritesBloc.state.heartButtonType,
        HotelDetailHeartButtonType.selected);
  });
}
