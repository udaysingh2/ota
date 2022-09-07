import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_argument_model.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_model_domain.dart';
import 'package:ota/domain/tours/tour_recent_playlist/repositories/tour_recent_playlist_repository_impl.dart';

/// Interface for TourDetail use cases.
abstract class TourRecentPlaylistUseCases {
  Future<Either<Failure, TourRecentPlaylistModelDomain>?> getTourRecentPlaylist(
      TourRecentPlaylistArgumentDomain argument);
}

class TourRecentPlaylistUseCasesImpl implements TourRecentPlaylistUseCases {
  TourRecentPlaylistRepository? tourRecentPlaylistRepository;

  /// Dependence injection via constructor
  TourRecentPlaylistUseCasesImpl({TourRecentPlaylistRepository? repository}) {
    if (repository == null) {
      tourRecentPlaylistRepository = TourRecentPlaylistRepositoryImpl();
    } else {
      tourRecentPlaylistRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TourRecentPlaylistModelDomain>?> getTourRecentPlaylist(
      TourRecentPlaylistArgumentDomain argument) async {
    return await tourRecentPlaylistRepository?.getTourRecentPlaylist(argument);
  }
}
