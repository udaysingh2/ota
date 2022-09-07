class QueriesOtaLoading {
  static String getTourLoadingScreenData() {
    return '''
        query{
    getTourServiceCards{
      data{
      serviceBackgroundUrl
      }status{
        code
		  header
		  description
      }
    }
  }
    ''';
  }
}
