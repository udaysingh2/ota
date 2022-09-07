import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/usecases/hotel_static_playlist_usecase.dart';

class HotelPlayListUseCasesSuccessMock extends HotelStaticPlaylistUseCases {
  @override
  Future<Either<Failure, HotelStaticPlayListModelDomain>?>
  getHotelStaticPlayListData(
      {HotelStaticPlayListArgumentModelDomain? argument}) async {
    return Right(
      HotelStaticPlayListModelDomain(
        getPlaylists: HotelStaticGetPlaylists(
          staticPlaylist: StaticPlaylist(
            source: '',
            serviceName: 'hotel',
            playlist: [
              Playlist(
                playlistId: '111',
                playlistName: 'static',
                cardList: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}