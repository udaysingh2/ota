import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/repositories/playlist_repository_impl.dart';

/// Interface for Playlist use cases.
abstract class PlayListUseCases {
  /// Call API to get the Playlist Screen details.
  ///
  /// [Either<Failure, PlaylistResultModel>] to handle the Failure or result data.
  Future<Either<Failure, PlaylistResultModelDomain>?> getPlayListData(
      {PlayListDataArgument argument});
}

/// PlayListUseCasesImpl will contain the PlayListUseCases implementation.
class PlayListUseCasesImpl implements PlayListUseCases {
  PlayListRepository? playListRepository;

  /// Dependence injection via constructor
  PlayListUseCasesImpl({PlayListRepository? repository}) {
    if (repository == null) {
      playListRepository = PlayListRepositoryImpl();
    } else {
      playListRepository = repository;
    }
  }

  /// Call API to get the Playlist Screen Details details.
  ///
  /// [Either<Failure, PlaylistResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, PlaylistResultModelDomain>?> getPlayListData({
    PlayListDataArgument? argument,
  }) async {
    return await playListRepository?.getPlayListData(argument!);
  }
}
