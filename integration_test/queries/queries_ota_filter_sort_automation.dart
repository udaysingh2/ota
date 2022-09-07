class QueriesOtaFilterSortAutomation {
  static String getOtaFilterSortData() {
    return '''
         query{
getSortCriteriaDetails{
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
  }
}
status{
  code
  header
  description
}
}
}
    ''';
  }
}
