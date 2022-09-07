class QueriesUserData {
  static String get() {
    return '''
        query{
  getCustomerDetails{
    data{
     firstName
     lastName
     email
     phoneNumber
    }
  }
}
    ''';
  }
}
