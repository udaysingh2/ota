class QueriesPreferencePopup {
  static String getPopUpState(String id, String type, String endDate) {
    return ''' mutation {
  userPreferencePopup(
    userPreferencePopupRequest: {
      popupId:"$id"
      intentType:"$type"
      endDate:"$endDate"
    }
  ) {
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
