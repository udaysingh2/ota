import 'package:ota/modules/car_rental/contact_information/view_model/contact_information_argument_model.dart';

class CarQueriesUpdateCustomer {
  static String updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData) {
    return '''
    mutation {
  updateCustomerDetails(
    customerDetailsRequest: {
      firstName: "${contactInformationArgumentData.firstName}"
      lastName: "${contactInformationArgumentData.lastName}"
      email: "${contactInformationArgumentData.email}"
      phoneNumber: "${contactInformationArgumentData.phoneNumber}"
    }
  ) {
    data {
     firstName
     lastName
     email
     phoneNumber
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
