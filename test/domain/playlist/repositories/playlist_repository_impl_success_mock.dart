import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/network/failures.dart';
import 'package:either_dart/src/either.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/data_sources/playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/domain/playlist/repositories/playlist_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

class PlayListRepositoryImplSuccessMock implements PlayListRepositoryImpl {
  @override
  PlayListRemoteDataSource? playListRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, PlaylistResultModelDomain>> getPlayListData(
      PlayListDataArgument argument) async {
    String json = fixture("playlist/playlist_result_model.json");

    ///Convert into Model
    PlaylistResultModelDomain model = PlaylistResultModelDomain.fromJson(json);
    return Right(model);
  }
}
