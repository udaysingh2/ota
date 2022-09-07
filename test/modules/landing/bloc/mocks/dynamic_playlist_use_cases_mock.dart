import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/usecases/playlist_use_cases.dart';

class PlayListUseCasesAllSuccessMock extends PlayListUseCasesImpl {
  @override
  Future<Either<Failure, PlaylistResultModelDomain>?> getPlayListData({
    PlayListDataArgument? argument,
  }) async {
    return Right(
      PlaylistResultModelDomain(
        getPlaylists: GetPlaylists(
          dynamicPlaylist: IcPlaylist(
            playlist: [
              Playlist(
                playlistId: '',
                playlistName: '',
                cardList: [
                  CardList(),
                ],
              ),
            ],
            serviceName: '',
            source: '',
          ),
          staticPlaylist: IcPlaylist(
            playlist: [
              Playlist(
                playlistId: '',
                playlistName: '',
                cardList: [
                  CardList(),
                ],
              ),
            ],
            serviceName: '',
            source: '',
          ),
        ),
      ),
    );
  }
}

class PlayListUseCasesPlayListEmptyMock extends PlayListUseCasesImpl {
  @override
  Future<Either<Failure, PlaylistResultModelDomain>?> getPlayListData({
    PlayListDataArgument? argument,
  }) async {
    return Right(
      PlaylistResultModelDomain(
        getPlaylists: null,
      ),
    );
  }
}

class PlayListUseCasesDynamicListNULLMock extends PlayListUseCasesImpl {
  @override
  Future<Either<Failure, PlaylistResultModelDomain>?> getPlayListData({
    PlayListDataArgument? argument,
  }) async {
    return Right(
      PlaylistResultModelDomain(
        getPlaylists: GetPlaylists(
          dynamicPlaylist: null,
          staticPlaylist: null,
        ),
      ),
    );
  }
}

class PlayListUseCasesFailureMock extends PlayListUseCasesImpl {
  @override
  Future<Either<Failure, PlaylistResultModelDomain>?> getPlayListData({
    PlayListDataArgument? argument,
  }) async {
    return Left(InternetFailure());
  }
}