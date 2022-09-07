import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/hotel_landing_static_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/usecases/hotel_landing_static_room_usecases.dart';

class StaticPlayListSuccessMock extends HotelLandingStaticUseCase {
  @override
  Future<Either<Failure, HotelLandingStaticSingleData>?> getPlaylist(
      HotelLandingStaticSingleDataArgument argument) async {
    return Right(
      HotelLandingStaticSingleData(
        getPlaylists: GetPlaylists(
          staticPlaylist: StaticPlaylist(
            playlist: [
              Playlist(
                playlistName: '',
                playlistId: '',
                cardList: [
                  StaticCardList(
                    cityId: "cityId",
                    countryId: "countryId",
                    rating: 4,
                    locationId: '',
                    productType: '',
                  ),
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

class StaticPlayListEmptyMock extends HotelLandingStaticUseCase {
  @override
  Future<Either<Failure, HotelLandingStaticSingleData>?> getPlaylist(
      HotelLandingStaticSingleDataArgument argument) async {
    return Right(
      HotelLandingStaticSingleData(
        getPlaylists: GetPlaylists(
          staticPlaylist: StaticPlaylist(
            playlist: [],
            serviceName: '',
            source: '',
          ),
        ),
      ),
    );
  }
}

class StaticPlayListFailureMock extends HotelLandingStaticUseCase {
  @override
  Future<Either<Failure, HotelLandingStaticSingleData?>?> getPlaylist(
      HotelLandingStaticSingleDataArgument argument) async {
    return Left(InternetFailure());
  }
}
