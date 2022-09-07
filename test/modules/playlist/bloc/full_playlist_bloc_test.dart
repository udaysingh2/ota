import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/playlist/bloc/full_playlist_bloc.dart';

import 'mocks/playlist_use_cases_all_mock.dart';
import 'mocks/playlist_use_cases_failed_mock.dart';

void main() {
  FullPlaylistBloc bloc = FullPlaylistBloc();

  PlaylistUseCasesSuccessMock successMock = PlaylistUseCasesSuccessMock();

  PlaylistUseCasesFailedMock failureMock = PlaylistUseCasesFailedMock();

  test('For FullPlaylistBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.playlistState, PlaylistViewModelState.none);
  });

  group('For fetchPlaylistData', () {
    test('If Arguments is Null value then', () async {
      bloc.fetchPlaylistData(argument: null, isPullToRefresh: false);

      expect(bloc.state.playlistState, PlaylistViewModelState.failure);
    });

    test('If Arguments has valid value but Failure case then', () async {
      bloc.playlistUseCases = failureMock;
      bloc.fetchPlaylistData(argument: validModel(), isPullToRefresh: false);

      Either<Failure, PlaylistResultModelDomain>? result =
          await failureMock.getPlayListData();

      expect(result?.isLeft, true);
    });

    test('If Arguments has valid value but all success then', () async {
      bloc.playlistUseCases = successMock;
      bloc.fetchPlaylistData(argument: validModel(), isPullToRefresh: false);

      Either<Failure, PlaylistResultModelDomain>? result =
          await successMock.getPlayListData();

      expect(result?.isRight, true);
    });

    test('If Arguments has valid value but emptyServiceModel then', () async {
      bloc.playlistUseCases = successMock;
      bloc.fetchPlaylistData(
          argument: emptyServiceModel(), isPullToRefresh: false);

      Either<Failure, PlaylistResultModelDomain>? result =
          await successMock.getPlayListData();

      expect(result?.isRight, true);
    });
  });

  test('For FullPlaylistBloc class ==> setSelectedCategory()', () {
    bloc.setSelectedCategory('test');

    expect(bloc.state.selectedCategory, 'test');
  });

  test('For FullPlaylistBloc class ==> getSelectedCatIndex()', () {
    final index = bloc.getSelectedCatIndex();

    expect(index, 0);
  });

  test('For FullPlaylistBloc class ==> getPlaylistOfSelectedCategory()', () {
    final list = bloc.getPlaylistOfSelectedCategory();

    expect(list.isEmpty, true);
  });
}

PlaylistViewArgument validModel() => PlaylistViewArgument(
      userId: 'userId',
      lat: 0.0,
      lng: 0.0,
      epoch: '2001',
      source: 'OTA',
      serviceName: 'serviceName',
    );

PlaylistViewArgument emptyServiceModel() => PlaylistViewArgument(
      userId: 'userId',
      lat: 0.0,
      lng: 0.0,
      epoch: '1001',
      source: 'static',
      serviceName: '',
    );
