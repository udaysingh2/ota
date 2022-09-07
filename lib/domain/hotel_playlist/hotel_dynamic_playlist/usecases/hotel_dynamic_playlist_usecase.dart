import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/repositories/hotel_dynamic_playlist_repository_impl.dart';

import '../models/hotel_dynamic_playlist_argument_model.dart';
import '../models/hotel_dynamic_playlist_model_domain.dart';

/// Interface for Playlist use cases.
abstract class HotelDynamicPlaylistUseCases {
  /// Call API to get the Playlist Screen details.
  ///
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  Future<Either<Failure, HotelDynamicPlayListModelDomainData>?>
      getDynamicPlayListData(
          {HotelDynamicPlayListDataArgumentModelDomain argument});
}

/// HotelDynamicPlaylistUseCasesImpl will contain the HotelDynamicPlaylistUseCases implementation.
class HotelDynamicPlaylistUseCasesImpl implements HotelDynamicPlaylistUseCases {
  HotelDynamicPlaylistRepository? hotelDynamicPlaylistRepository;

  /// Dependence injection via constructor
  HotelDynamicPlaylistUseCasesImpl(
      {HotelDynamicPlaylistRepository? repository}) {
    if (repository == null) {
      hotelDynamicPlaylistRepository = HotelDynamicPlaylistRepositoryImpl();
    } else {
      hotelDynamicPlaylistRepository = repository;
    }
  }

  /// Call API to get the Playlist Screen Details details.
  ///
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, HotelDynamicPlayListModelDomainData>?>
      getDynamicPlayListData({
    HotelDynamicPlayListDataArgumentModelDomain? argument,
  }) async {
    return await hotelDynamicPlaylistRepository
        ?.getDynamicPlayListData(argument!);
  }
}
