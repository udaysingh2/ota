enum StaticPlaylistType { all, tour, ticket, hotel, car }

extension StaticPlaylistTypeExtension on StaticPlaylistType {
  String get value {
    return toString().split('.').last;
  }
}
