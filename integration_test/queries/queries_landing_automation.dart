class QueriesLandingAutomation {
  ///Change the argument model
  static String getLandingPageData() {
    return '''query {
  getLandingPageDetails {
    data {
      defaultCustomText
      backgroundUrl
      businessCards {
        serviceText
        title
        description
        imageUrl  
        largeImageUrl
        serviceBackgroundUrl
        sortSeq
        service
        deeplinkUrl
      }
      banner {
        bannerId
        type
        startDate
        endDate
        priority
        imageFilename
        deeplinkUrl
        deeplinkType
        function
        orderSection
      }
      popups {
        popupId
        type
        startDate
        endDate
        priority
        imageFilename
        deeplinkUrl
        deeplinkType
        function
        orderSection
      }
      promotions {
        hotelId
        promotionText
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
