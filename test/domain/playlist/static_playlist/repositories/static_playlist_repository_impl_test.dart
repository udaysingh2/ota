import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/playlist/static_playlist/data_sources/static_playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/domain/playlist/static_playlist/repositories/static_playlist_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

class StaticPlaylistRemoteDataSourceFailureMock
    implements StaticPlayListRemoteDataSource {
  Future<StaticPlaylistModelDomain> getPlaylistCards(
      StaticPlaylistModelDomain argument) {
    throw Future.value(Exception());
  }

  @override
  Future<StaticPlaylistModelDomain> getStaticPlayListData() {
    throw Future.value(Exception());
  }
}

class _MockStaticPlaylistRemoteDataSource
    implements StaticPlayListRemoteDataSource {
  Future<StaticPlaylistModelDomain> getPlaylistCards(
      StaticPlaylistModelDomain argument) {
    Map<String, dynamic> map =
        json.decode(fixture("playlist/static_playlist_model_domain.json"));
    return Future.value(StaticPlaylistModelDomain.fromMap(map));
  }

  @override
  Future<StaticPlaylistModelDomain> getStaticPlayListData() {
    Map<String, dynamic> map =
        json.decode(fixture("playlist/static_playlist_model_domain.json"));
    return Future.value(StaticPlaylistModelDomain.fromMap(map));
  }
}

void main() {
  group('For StaticPlaylistRepository group Test', () {
    test("Static Playlist Repository" 'With Success response', () async {
      StaticPlaylistRepositoryImpl();
      StaticPlaylistRepository repository = StaticPlaylistRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: _MockStaticPlaylistRemoteDataSource(),
      );

      repository.getStaticPlayListData();
    });

    test("Static Playlist Repository" 'With Failure response data', () async {
      StaticPlaylistRepositoryImpl();
      StaticPlaylistRepository repository = StaticPlaylistRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: _MockStaticPlaylistRemoteDataSource(),
      );

      repository.getStaticPlayListData();
    });
  });
}
