class QueriesLoading {
  static String getLoadingScreenData(String serviceName) {
    return '''
        query {
    getLoadScreen(service: "$serviceName") {
      data{
        loadScreenUrl
      }
      status {
        code
        header
      }
    }
}
    ''';
  }
}
