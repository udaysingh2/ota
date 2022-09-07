import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/domain/playlist/static_playlist/repositories/static_playlist_repository_impl.dart';

/// Interface for Playlist use cases.
abstract class StaticPlaylistUseCases {
  /// Call API to get the Playlist Screen details.
  ///
  /// [Either<Failure, StaticPlaylistModel>] to handle the Failure or result data.
  Future<Either<Failure, StaticPlaylistModelDomain>?> getStaticPlayListData();
}

/// StaticPlaylistUseCasesImpl will contain the StaticPlaylistUseCases implementation.
class StaticPlaylistUseCasesImpl implements StaticPlaylistUseCases {
  StaticPlaylistRepository? staticPlaylistRepository;

  /// Dependence injection via constructor
  StaticPlaylistUseCasesImpl({StaticPlaylistRepository? repository}) {
    if (repository == null) {
      staticPlaylistRepository = StaticPlaylistRepositoryImpl();
    } else {
      staticPlaylistRepository = repository;
    }
  }

  /// Call API to get the Playlist Screen Details details.
  ///
  /// [Either<Failure, StaticPlaylistModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, StaticPlaylistModelDomain>?> getStaticPlayListData() async {
    return await staticPlaylistRepository?.getStaticPlayListData();
  }
}
