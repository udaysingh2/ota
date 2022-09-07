import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/hotel_landing_static_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/usecases/hotel_landing_static_room_usecases.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/bloc/hotel_landing_static_playlist_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/hotel_landing_static_argument_model.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/playlist_view_model.dart';

import 'mocks/static_playlist_use_cases_success_mock.dart';

void main() {
  HotelLandingStaticPlaylistBloc bloc = HotelLandingStaticPlaylistBloc();
  HotelLandingStaticUseCase successMock = StaticPlayListSuccessMock();
  HotelLandingStaticUseCase emptyMock = StaticPlayListEmptyMock();
  HotelLandingStaticUseCase failureMock = StaticPlayListFailureMock();

  test('For HotelLandingDynamicPlaylistBloc ==> initDefaultValue', () {
    final actual = bloc.initDefaultValue();

    expect(actual.playlist.isEmpty, true);
  });

  // test('For HotelLandingDynamicPlaylistBloc ==> pullToRefresh()', () async {
  //   await bloc.pullToRefresh(getArgument());
  //
  //   expect(bloc.state.playlistState, PlaylistViewModelState.failure);
  // });

  group('For HotelLandingDynamicPlaylistBloc ==> getPlayList()', () {
    test('When getPlayList() is Success Then', () async {
      bloc.staticUseCase = successMock;
      await bloc.getPlayList(getArgument());

      Either<Failure, HotelLandingStaticSingleData?>? failResult =
          await successMock.getPlaylist(getSingleArg());

      expect(failResult?.isRight, true);
    });

    test('When getPlayList() is Success Then', () async {
      bloc.staticUseCase = emptyMock;
      await bloc.getPlayList(getArgument());

      Either<Failure, HotelLandingStaticSingleData?>? failResult =
          await emptyMock.getPlaylist(getSingleArg());

      expect(failResult?.isRight, true);
    });

    test('When getPlayList() is Failure then', () async {
      bloc.staticUseCase = failureMock;
      await bloc.getPlayList(getArgument());

      Either<Failure, HotelLandingStaticSingleData?>? failResult =
          await failureMock.getPlaylist(getSingleArg());

      expect(failResult?.isLeft, true);
    });
  });

  test('For HotelLandingDynamicPlaylistBloc ==> initiateApiCall()', () async {
    await bloc.initiateApiCall(getArgument());

    expect(bloc.state.playlistState, PlaylistViewModelState.internetFailure);
  });

  test('For HotelLandingDynamicPlaylistBloc ==> loadNextPage()', () async {
    bloc.state.playlist = [
      PlaylistCardViewModel(
          addressText: "AddressText",
          cityId: "cityId",
          countryId: "countryId",
          discountValue: "2",
          hotelId: "hotelId",
          hotelName: "hotelName",
          image: "image",
          offerValue: "2",
          promotionText1: "p1",
          promotionText2: "p2",
          rating: "4",
          reviewText: "review",
          reviewTitle: "revtitle",
          locationName: "locationName",
          aminities: ["amini1", "amini2"],
          score: "5"),
    ];
    await bloc.loadNextPage(getArgument());

    expect(bloc.state.playlistState, PlaylistViewModelState.success);
  });
}

HotelLandingStaticArgumentModel getArgument() {
  return HotelLandingStaticArgumentModel(
    userId: '',
    playlistId: '',
    playlistName: '',
  );
}

HotelLandingStaticSingleDataArgument getSingleArg() {
  return HotelLandingStaticSingleDataArgument(
    userId: '',
    playlistId: '',
  );
}
