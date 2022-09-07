import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/usecases/hotel_static_playlist_usecase.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_playlist_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_playlist_view_model.dart';

import 'mocks/hotel_playlist_usesases_failure_mock.dart';
import 'mocks/hotel_playlist_usesases_success_mock.dart';

void main() {
  HotelPlaylistBloc bloc = HotelPlaylistBloc();
  HotelStaticPlaylistUseCases successMock = HotelPlayListUseCasesSuccessMock();
  HotelStaticPlaylistUseCases failureMock = HotelPlayListUseCasesFailedMock();

  test('For HotelPlaylistBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.hotelStaticPlayListViewModelState,
        HotelStaticPlayListViewModelState.none);
    expect(actual.playList.isEmpty, true);
    expect(actual.playList.length, 0);
  });

  group('For HotelPlaylistBloc class ==> getPlayListData()', () {
    test('If argument is Null data then', () async {
      ///setup
      await bloc.getPlayListData(null);

      expect(bloc.state.hotelStaticPlayListViewModelState,
          HotelStaticPlayListViewModelState.failure);
    });

    group('For HotelPlayListBloc class ==> getHotelStaticPlayListData()', () {
      test('If argument has all data then "isRight" is Success', () async {
        bloc.playlistUseCases = successMock;
        await bloc.getPlayListData(getArgument());

        Either<Failure, HotelStaticPlayListModelDomain>? result =
            (await successMock.getHotelStaticPlayListData());

        ///Check if result is "isRight"
        expect(result?.isRight, true);
        expect(bloc.state.hotelStaticPlayListViewModelState,
            HotelStaticPlayListViewModelState.success);
      });

      test('If case for "Failure"', () async {
        bloc.playlistUseCases = failureMock;
        await bloc.getPlayListData(getArgument());

        Either<Failure, HotelStaticPlayListModelDomain>? result =
            (await failureMock.getHotelStaticPlayListData());

        ///Check if result is "isRight"
        expect(result?.isLeft, true);
        expect(bloc.state.hotelStaticPlayListViewModelState,
            HotelStaticPlayListViewModelState.failure);
      });
    });
  });
}

HotelStaticPlayListArgumentModelDomain getArgument() {
  return HotelStaticPlayListArgumentModelDomain(
    userId: '1',
    lat: 0,
    long: 0,
    epoch: Helpers.getEpochTime().toString(),
    playlistId: '1111',
    source: 'static',
    serviceName: 'hotels',
    limit: 20,
    offset: 0,
  );
}
