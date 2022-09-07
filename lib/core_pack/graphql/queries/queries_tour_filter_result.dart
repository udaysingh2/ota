class QueriesTourFilterResult {
  static String getTourSortFilterData(String serviceType) {
    return '''
      query {
        getSortCriteriaForService(
          sortCriteriaRequest: { serviceType: "$serviceType" }
        ) {
          data {
            sortInfo {
              displayTitle
              sortSeq
              value
            }
            criteria {
              displayTitle
              sortSeq
              value
              description
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
