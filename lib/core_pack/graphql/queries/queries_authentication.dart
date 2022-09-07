class QueriesAuth {
  static String getLoginDetail(
      {required String username, required String password}) {
    return """
      mutation {
        getLoginDetails(loginRequest: { username: "$username", password: "$password" }) {
          data {
            accessToken
            refreshToken
            expiresIn
            refreshExpiresIn
            scope
            idToken
          }
          status {
            code
            header
            description
          }
        }
      }
    """;
  }

  static String getRefreshDetail(String refreshToken) {
    return """
      mutation {
        getRefreshToken(refreshToken: { refreshToken: "$refreshToken" }) {
          data {
            accessToken
            refreshToken
            expiresIn
            refreshExpiresIn
            scope
            idToken
          }
          status {
            code
            header
            description
          }
        }
      }
    """;
  }

  static String getLogOutDetail(String username) {
    return """
      mutation{
        getLogoutDetails(logoutRequest:{
          username: "$username"
        })
        {
          status{
            code
            header
            description
          }
        }
      }
    """;
  }
}
