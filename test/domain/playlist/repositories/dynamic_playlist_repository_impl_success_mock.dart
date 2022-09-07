import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/network/failures.dart';
import 'package:either_dart/src/either.dart';
import 'package:ota/domain/playlist/dynamic_playlist/data_sources/dynamic_playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_data_argument_domain.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_model_domain.dart';
import 'package:ota/domain/playlist/dynamic_playlist/repositories/dynamic_playlist_repository_impl.dart';
import '../../../mocks/fixture_reader.dart';

class DynamicPlaylistRepositoryImplSuccessMock
    implements DynamicPlaylistRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  DynamicPlayListRemoteDataSource? dynamicPlaylistRemoteDataSource;

  @override
  Future<Either<Failure, DynamicPlaylistModel>> getDynamicPlayListData(
      DynamicPlayListDataArgumentModelDomain argument) async {
    String json = fixture("playlist/dynamic_playlist_result_model.json");

    ///Convert into Model
    DynamicPlaylistModel model = DynamicPlaylistModel.fromJson(json);
    return Right(model);
  }
}
