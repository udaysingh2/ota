import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart'
    as utc_landing;
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/usecases/hotel_landing_dynamic_room_usecases.dart';

class DynamicPlayListSuccessMock extends HotelLandingDynamicUseCase {
  @override
  Future<Either<Failure, utc_landing.HotelLandingDynamicSingleData?>?>
      getPlaylist(HotelLandingDynamicSingleDataArgument argument) async {
    return Right(
      utc_landing.HotelLandingDynamicSingleData(
        getPlaylists: utc_landing.GetPlaylists(
          dynamicPlaylist: utc_landing.DynamicPlaylist(
            playlist: [
              utc_landing.Playlist(
                playlistName: '',
                playlistId: '',
                cardList: [
                  utc_landing.DynamicCardList(
                    cityId: '',
                    countryId: '',
                  ),
                ],
              ),
            ],
            source: '',
            serviceName: '',
          ),
        ),
      ),
    );
  }
}

class DynamicPlayListEmptyMock extends HotelLandingDynamicUseCase {
  @override
  Future<Either<Failure, utc_landing.HotelLandingDynamicSingleData?>?>
      getPlaylist(HotelLandingDynamicSingleDataArgument argument) async {
    return Right(
      utc_landing.HotelLandingDynamicSingleData(
        getPlaylists: utc_landing.GetPlaylists(
          dynamicPlaylist: utc_landing.DynamicPlaylist(
            playlist: [],
            source: '',
            serviceName: '',
          ),
        ),
      ),
    );
  }
}

class DynamicPlayListFailureMock extends HotelLandingDynamicUseCase {
  @override
  Future<Either<Failure, utc_landing.HotelLandingDynamicSingleData?>?>
      getPlaylist(HotelLandingDynamicSingleDataArgument argument) async {
    return Left(
      InternetFailure(),
    );
  }
}
