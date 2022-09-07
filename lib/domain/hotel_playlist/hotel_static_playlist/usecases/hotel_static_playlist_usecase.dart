import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/repositories/hotel_static_playlist_repository_impl.dart';

/// Interface for Playlist use cases.
abstract class HotelStaticPlaylistUseCases {
  /// Call API to get the Playlist Screen details.
  ///
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  Future<Either<Failure, HotelStaticPlayListModelDomain>?> getHotelStaticPlayListData(
      {HotelStaticPlayListArgumentModelDomain argument});
}

/// HotelStaticPlaylistUseCasesImpl will contain the HotelStaticPlaylistUseCases implementation.
class HotelStaticPlaylistUseCasesImpl implements HotelStaticPlaylistUseCases {
  HotelStaticPlayListRepository? hotelStaticPlayListRepository;

  /// Dependence injection via constructor
  HotelStaticPlaylistUseCasesImpl({HotelStaticPlayListRepository? repository}) {
    if (repository == null) {
      hotelStaticPlayListRepository = HotelStaticPlayListRepositoryImpl();
    } else {
      hotelStaticPlayListRepository = repository;
    }
  }

  @override
  Future<Either<Failure, HotelStaticPlayListModelDomain>?> getHotelStaticPlayListData(
      {HotelStaticPlayListArgumentModelDomain? argument}) async {
    return await hotelStaticPlayListRepository
        ?.getHotelStaticPlayListData(argument!);
  }
}
