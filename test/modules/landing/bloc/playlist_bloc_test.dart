import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/repositories/playlist_repository_impl.dart';
import 'package:ota/domain/playlist/usecases/playlist_use_cases.dart';
import 'package:ota/modules/landing/bloc/playlist_bloc.dart';
import 'package:ota/modules/landing/view_model/playlist_card_view_model.dart';
import 'package:ota/modules/landing/view_model/playlist_data_view_model.dart';
import 'package:ota/modules/landing/view_model/playlist_view_model.dart';

import '../../../domain/playlist/repositories/playlist_remote_datasource_impl_moc.dart';
import '../../../domain/playlist/repositories/playlist_repository_impl_success_mock.dart';
import '../../hotel/repositories/internet_failure_mock.dart';

void main() {
  PlayListBloc bloc = PlayListBloc();
  PlayListDataArgument argument = PlayListDataArgument(
      userId: "1", lat: 14.040885, long: 100.614385, epoch: "1629791595");

  test("PlayList Bloc with mocked repository with null data pass", () {
    bloc.playlistUseCases =
        PlayListUseCasesImpl(repository: PlayListRepositoryImplSuccessMock());
    bloc.getPlayListData(argument: argument);
    expect(bloc.state.playListViewModelState, PlayListViewModelState.loading);
  });

  test("PlayList Bloc with mocked repository with Internet Failure", () {
    bloc.playlistUseCases = PlayListUseCasesImpl(
        repository: PlayListRepositoryImpl(
            remoteDataSource: PlayListRemoteDataSourceImplSuccessMock(),
            internetInfo: InternetFailureMock()));
    bloc.getPlayListData(argument: argument);
    expect(bloc.state.playListViewModelState, PlayListViewModelState.loading);
  });

  test("PlayList Bloc with mocked repository", () {
    bloc.playlistUseCases =
        PlayListUseCasesImpl(repository: PlayListRepositoryImplSuccessMock());
    bloc.getPlayListData(argument: argument);
    expect(bloc.state.playListViewModelState, PlayListViewModelState.loading);
  });

  test("PlayList Bloc with null argument", () {
    bloc.getPlayListData(argument: null);
    expect(bloc.state.playListViewModelState, PlayListViewModelState.failure);
  });

  test("PlayList Bloc with mocked repository and PlayList data", () {
    final playListData = PlayListDataViewModel(
      playList: [
        OtaLandingPlayListModel(
          cardList: [
            PlaylistCardViewModel(
              addressText: "89 Soi Wat Suan Phu New",
              discount: "10",
              headerText: "Shangri La Bangkok",
              imageUrl:
                  "https://manage.robinhood.in.th/ImageData/Hotel/Amora_Neoluxe_Bangkok-general1.jpg",
              offerPercent: "test",
              ratingText: "4",
              ratingTitle: "test",
              reviewText: "test",
              score: "10",
            ),
          ],
        )
      ],
      name: "specials deals",
      serviceName: "hotels",
      source: "static",
    );
    bloc.playlistUseCases =
        PlayListUseCasesImpl(repository: PlayListRepositoryImplSuccessMock());
    bloc.getPlayListData(argument: argument);
    expect(bloc.state.playListViewModelState, PlayListViewModelState.loading);
    bloc.state.staticPlaylist = playListData;
    bloc.state.dynamicPlaylist = playListData;
    expect(bloc.state.staticPlaylist.playList.length, 1);
    expect(bloc.state.dynamicPlaylist.playList.length, 1);
  });
}