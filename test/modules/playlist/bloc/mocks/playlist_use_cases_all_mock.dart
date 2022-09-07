import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/usecases/playlist_use_cases.dart';

class PlaylistUseCasesSuccessMock extends PlayListUseCases {
  @override
  Future<Either<Failure, PlaylistResultModelDomain>?> getPlayListData(
      {PlayListDataArgument? argument}) async {
    return Right(
      PlaylistResultModelDomain(
        getPlaylists: GetPlaylists(
          staticPlaylist: IcPlaylist(
            source: '',
            serviceName: 'serviceName',
            playlist: [
              Playlist(
                playlistId: 'playlistId',
                playlistName: 'playlistName',
                cardList: [
                  CardList(
                    id: 'id',
                    name: 'name',
                  ),
                ],
              ),
            ],
          ),
          dynamicPlaylist: IcPlaylist(
            source: '',
            serviceName: 'serviceName',
            playlist: [
              Playlist(
                playlistId: 'playlistId',
                playlistName: 'playlistName',
                cardList: [
                  CardList(
                    id: 'id',
                    name: 'name',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
