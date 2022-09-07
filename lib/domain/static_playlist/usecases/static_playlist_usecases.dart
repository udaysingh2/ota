import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/domain/static_playlist/repositories/static_playlist_repository_impl.dart';

/// Interface for Hotel addon services use cases.
abstract class OtaStaticPlaylistUseCases {
  /// Call API to get the Static playlist on Landing Page.
  ///
  /// [staticPlaylistArgumentData] to get the Static playlist on Landing Page.
  /// [Either<Failure, StaticPlayListModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, StaticPlayListModelDomain>?> getOtaStaticPlaylist(
      StaticPlaylistArgumentDomain staticPlaylistArgumentData);
}

/// OtaStaticPlaylistUseCasesImpl will contain the OtaStaticPlaylistUseCases implementation.
class OtaStaticPlaylistUseCasesImpl implements OtaStaticPlaylistUseCases {
  OtaStaticPlaylistRepository? staticPlaylistRepository;

  /// Dependence injection via constructor
  OtaStaticPlaylistUseCasesImpl({OtaStaticPlaylistRepository? repository}) {
    if (repository == null) {
      staticPlaylistRepository = OtaStaticPlaylistRepositoryImpl();
    } else {
      staticPlaylistRepository = repository;
    }
  }

  /// Call API to get the Static playlist on Landing Page.
  ///
  /// [staticPlaylistArgumentData] to get the Static playlist on Landing Page.
  /// [Either<Failure, StaticPlayListModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, StaticPlayListModelDomain>?> getOtaStaticPlaylist(
      StaticPlaylistArgumentDomain staticPlaylistArgumentData) async {
    return await staticPlaylistRepository
        ?.getOtaStaticPlaylist(staticPlaylistArgumentData);
  }
}
