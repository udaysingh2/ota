enum PlaylistType { all, tour, ticket, location }

extension PlaylistTypeExtension on PlaylistType {
  String get value {
    return toString().split('.').last;
  }
}
