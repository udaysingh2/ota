import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/playlist/data_sources/playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';

class PlayListRemoteDataSourceFailureMock implements PlayListRemoteDataSource {
  @override
  Future<PlaylistResultModelDomain> getPlayListData(PlayListDataArgument argument) {
    throw exp.ServerException(null);
  }
}
