class QueriesGeneralAutomation {
  static String getSplashScreenData() {
    return '''
        query {
          getSplashScreen {
            status {
              code
              header
            }
            data {
              splashScreenUrl
            }
          }
        }
    ''';
  }
}
