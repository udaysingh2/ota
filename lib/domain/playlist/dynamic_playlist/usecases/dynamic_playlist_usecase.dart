import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_data_argument_domain.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_model_domain.dart';
import 'package:ota/domain/playlist/dynamic_playlist/repositories/dynamic_playlist_repository_impl.dart';

/// Interface for Playlist use cases.
abstract class DynamicPlaylistUseCases {
  /// Call API to get the Playlist Screen details.
  ///
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  Future<Either<Failure, DynamicPlaylistModel>?> getDynamicPlayListData(
      {DynamicPlayListDataArgumentModelDomain argument});
}

/// DynamicPlaylistUseCasesImpl will contain the DynamicPlaylistUseCases implementation.
class DynamicPlaylistUseCasesImpl implements DynamicPlaylistUseCases {
  DynamicPlaylistRepository? dynamicPlaylistRepository;

  /// Dependence injection via constructor
  DynamicPlaylistUseCasesImpl({DynamicPlaylistRepository? repository}) {
    if (repository == null) {
      dynamicPlaylistRepository = DynamicPlaylistRepositoryImpl();
    } else {
      dynamicPlaylistRepository = repository;
    }
  }

  /// Call API to get the Playlist Screen Details details.
  ///
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, DynamicPlaylistModel>?> getDynamicPlayListData({
    DynamicPlayListDataArgumentModelDomain? argument,
  }) async {
    return await dynamicPlaylistRepository?.getDynamicPlayListData(argument!);
  }
}
