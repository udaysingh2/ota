import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/playlist/dynamic_playlist/data_sources/dynamic_playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_data_argument_domain.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

class DynamicPlayListRemoteDataSourceImplSuccessMock
    implements DynamicPlayListRemoteDataSourceImpl {
  @override
  GraphQlResponse? graphQlResponse;

  @override
  Future<DynamicPlaylistModel> getDynamicPlayListData(
      DynamicPlayListDataArgumentModelDomain argument) async {
    String json = fixture("playlist/dynamic_playlist_result_model.json");

    ///Convert into Model
    DynamicPlaylistModel model = DynamicPlaylistModel.fromJson(json);
    return model;
  }
}
