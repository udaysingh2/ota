class QueriesServiceCard {
  static String getServiceCard() {
    return '''query Data {
  getServiceCard {
    data {
      defaultCustomText
      backgroundUrl
      businessCards {
        title
        serviceText
        description
        imageUrl
        largeImageUrl
        serviceBackgroundUrl
        sortSeq
        service
        deeplinkUrl
      }
    }
    status {
      code
      header
      description
    }
  }
}
''';
  }
}
