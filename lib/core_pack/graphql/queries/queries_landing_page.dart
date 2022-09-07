class QueriesLanding {
  ///Change the argument model
  static String getLandingPageData() {
    return '''query {
  getLandingPageDetails {
    data {
      defaultCustomText
      backgroundUrl
      userName
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
      preferences {
        questionId
        description1
        description2
        multiChoice
        backgroundImageUrl
        options {
          optionCode
          optionDesc
          imageUrl
          }
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
