class QueriesCarSearchFilter {
  static String getCarSearchFilterData() {
    return '''  
query {
  getSortCriteriaForService(sortCriteriaRequest: {
    serviceType: "CARRENTAL"
  }) 
  {
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
