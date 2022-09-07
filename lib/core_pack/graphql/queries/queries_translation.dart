class QueriesTranslation {
  static String getEnglishTranslationData() {
    return '''
        query{
          loadTranslation{
            data {
                en {
                      name
                      value
                }
            }
          }
        }
    ''';
  }

  static String getThaiTranslationData() {
    return '''
        query{
          loadTranslation{
            data {
                th {
                      name
                      value
                }
            }
          }
        }
    ''';
  }
}
