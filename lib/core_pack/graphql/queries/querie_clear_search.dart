class QueryClearSearch {
  static String clearRecentSearchData(
      String serviceType, String dataSearchType) {
    return '''  
   mutation clearCarrentalSearchPlaylist {
  clearSearchPlaylist(
    clearSearchPlaylistRequest: {
      serviceType: "$serviceType"
      dataSearchType: "$dataSearchType"
    }
  ) {
    status {
      code
      header
    }
  }
}

    ''';
  }
}
