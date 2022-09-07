class QueriesTourServiceCard {
  static String getServiceCardData() {
    return '''
          query {
      getTourServiceCards {
        data {
          ticket {
            imageTitle
            imageUrl
            title
            description
            deeplinkUrl
            sortSeq
          }
          tour {
            imageTitle
            imageUrl
            title
            description
            deeplinkUrl
            sortSeq
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
