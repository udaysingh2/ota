class QueriesPopup {
  static String getPopupData() {
    return '''
      query {
        getPopups {
          data {
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
