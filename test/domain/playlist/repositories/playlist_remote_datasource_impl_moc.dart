import 'package:ota/domain/playlist/data_sources/playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

class PlayListRemoteDataSourceImplSuccessMock
    implements PlayListRemoteDataSource {
  @override
  Future<PlaylistResultModelDomain> getPlayListData(
      PlayListDataArgument argument) async {
    String json = fixture("playlist/playlist_result_model.json");

    ///Convert into Model
    PlaylistResultModelDomain model = PlaylistResultModelDomain.fromJson(json);
    return model;
  }
}
