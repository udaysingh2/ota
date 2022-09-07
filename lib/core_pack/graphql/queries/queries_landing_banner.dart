class QueriesLandingBanner {
  static String getLandingBannerData(String bannerType) {
    return '''
      query {
  getBanners(bannerFunction: "$bannerType") {
    data {
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
