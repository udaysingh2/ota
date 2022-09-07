import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/usecases/hotel_dynamic_playlist_usecase.dart';

///For Recent playlist true
class HotelDynamicPlayListRecentSuccessMock
    extends HotelDynamicPlaylistUseCases {
  @override
  Future<Either<Failure, HotelDynamicPlayListModelDomainData>?>
      getDynamicPlayListData({
    HotelDynamicPlayListDataArgumentModelDomain? argument,
  }) async {
    return Right(
      HotelDynamicPlayListModelDomainData(
        getRecentViewPlaylist: GetRecentViewPlaylist(
          listType: 'vertical',
          dynamicPlaylist: DynamicPlaylist(
            source: 'dynamic',
            serviceName: 'hotel',
            playlist: [
              Playlist(
                playlistId: 'playlistId',
                playlistName: 'playlistName',
                cardList: [CardList()],
              ),
            ],
          ),
          recentViewPlaylist: [
            RecentViewPlaylist(),
          ],
        ),
      ),
    );
  }
}

///For Dynamic playlist true
class HotelDynamicPlayListDynamicSuccessMock
    extends HotelDynamicPlaylistUseCases {
  @override
  Future<Either<Failure, HotelDynamicPlayListModelDomainData>?>
      getDynamicPlayListData({
    HotelDynamicPlayListDataArgumentModelDomain? argument,
  }) async {
    return Right(
      HotelDynamicPlayListModelDomainData(
        getRecentViewPlaylist: GetRecentViewPlaylist(
          listType: 'vertical',
          dynamicPlaylist: DynamicPlaylist(
            source: 'dynamic',
            serviceName: 'hotel',
            playlist: [
              Playlist(
                playlistId: 'playlistId',
                playlistName: 'playlistName',
                cardList: [CardList()],
              ),
            ],
          ),
          recentViewPlaylist: [],
        ),
      ),
    );
  }
}

///For (Recent + dynamic both empty) else true
class HotelDynamicPlayListElseSuccessMock
    extends HotelDynamicPlaylistUseCases {
  @override
  Future<Either<Failure, HotelDynamicPlayListModelDomainData>?>
      getDynamicPlayListData({
    HotelDynamicPlayListDataArgumentModelDomain? argument,
  }) async {
    return Right(
      HotelDynamicPlayListModelDomainData(
        getRecentViewPlaylist: GetRecentViewPlaylist(
          listType: 'vertical',
          dynamicPlaylist: DynamicPlaylist(
            source: 'dynamic',
            serviceName: 'hotel',
            playlist: [],
          ),
          recentViewPlaylist: [],
        ),
      ),
    );
  }
}
