import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/usecases/playlist_use_cases.dart';
import 'package:ota/modules/landing/bloc/static_playlist_bloc.dart';
import 'package:ota/modules/landing/view_model/playlist_view_model.dart';

import 'mocks/dynamic_playlist_use_cases_mock.dart';

void main() {
  StaticPlayListBloc bloc = StaticPlayListBloc();
  PlayListUseCasesImpl successMock = PlayListUseCasesAllSuccessMock();
  PlayListUseCasesImpl staticListNULLMock =
      PlayListUseCasesDynamicListNULLMock();
  PlayListUseCasesImpl failureMock = PlayListUseCasesFailureMock();

  test('For StaticPlayListBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.playListViewModelState, PlayListViewModelState.none);
  });

  group('For StaticPlayListBloc class ==> getPlayListData()', () {
    test('If Failure then', () async {
      bloc.playlistUseCases = failureMock;
      await bloc.getPlayListData(argument: getArgument());

      Either<Failure, PlaylistResultModelDomain>? result =
          await failureMock.getPlayListData();

      expect(result?.isLeft, true);
      expect(bloc.state.playListViewModelState, PlayListViewModelState.failure);
    });

    test('if argument has all valid data then', () async {
      bloc.playlistUseCases = staticListNULLMock;
      await bloc.getPlayListData(argument: getArgument());

      Either<Failure, PlaylistResultModelDomain>? result =
          await staticListNULLMock.getPlayListData();

      expect(result?.isRight, true);
      expect(bloc.state.playListViewModelState, PlayListViewModelState.failure);
    });

    test('if argument has all valid data then', () async {
      bloc.playlistUseCases = successMock;
      await bloc.getPlayListData(argument: getArgument());

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
