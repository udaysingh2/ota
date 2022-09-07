class QueriesConfigApi {
  static String getConfigData() {
    return '''
      query {
              getConfigDetails {
                data {
                  name
                  value
                  type
                }
                status {
                  code
                  header
                }
              }
            }
    ''';
  }
}
