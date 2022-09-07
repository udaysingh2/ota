import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/usecases/playlist_use_cases.dart';
import 'package:ota/modules/landing/bloc/dynamic_playlist_bloc.dart';
import 'package:ota/modules/landing/view_model/playlist_view_model.dart';

import 'mocks/dynamic_playlist_use_cases_mock.dart';

void main() {
  DynamicPlayListBloc bloc = DynamicPlayListBloc();
  PlayListUseCasesImpl successMock = PlayListUseCasesAllSuccessMock();
  PlayListUseCasesImpl playListNULLMock =
      PlayListUseCasesPlayListEmptyMock();
  PlayListUseCasesImpl dynamicListNULLMock =
      PlayListUseCasesDynamicListNULLMock();
  PlayListUseCasesImpl failureMock = PlayListUseCasesFailureMock();

  test('For DynamicPlayListBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.playListViewModelState, PlayListViewModelState.none);
    expect(actual.dynamicPlaylist.playList.isEmpty, true);
    expect(actual.staticPlaylist.playList.isEmpty, true);
  });

  group('For DynamicPlayListBloc class ==> getDynamicPlayListData()', () {
    test('if argument is NULL then', () async {
      await bloc.getDynamicPlayListData(argument: null);

      expect(bloc.state.playListViewModelState, PlayListViewModelState.failure);
    });

    test('if Failure case then', () async {
      bloc.playlistUseCases = failureMock;
      await bloc.getDynamicPlayListData(argument: getArgument());

      Either<Failure, PlaylistResultModelDomain>? result =
          await failureMock.getPlayListData();

      expect(result?.isLeft, true);
      expect(bloc.state.playListViewModelState, PlayListViewModelState.failure);
    });

    test('if playlist is empty then', () async {
      bloc.playlistUseCases = playListNULLMock;
      await bloc.getDynamicPlayListData(argument: getArgument());

      Either<Failure, PlaylistResultModelDomain>? result =
          await playListNULLMock.getPlayListData();

      expect(result?.isRight, true);
      expect(bloc.state.playListViewModelState, PlayListViewModelState.failure);
    });

    test('if dynamicPlaylist is NULL then', () async {
      bloc.playlistUseCases = dynamicListNULLMock;
      await bloc.getDynamicPlayListData(argument: getArgument());

      Either<Failure, PlaylistResultModelDomain>? result =
          await dynamicListNULLMock.getPlayListData();

      expect(result?.isRight, true);
      expect(bloc.state.playListViewModelState, PlayListViewModelState.loading);
    });

    test('if argument has all valid data then', () async {
      bloc.playlistUseCases = successMock;
      await bloc.getDynamicPlayListData(argument: getArgument());

      Either<Failure, PlaylistResultModelDomain>? result =
          await successMock.getPlayListData();

      expect(result?.isRight, true);
      expect(bloc.state.playListViewModelState, PlayListViewModelState.success);
    });
  });
}

PlayListDataArgument getArgument() {
  return PlayListDataArgument(
    userId: '',
    lat: 0.0,
    long: 0.0,
    epoch: '',
  );
}
