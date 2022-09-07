import 'package:ota/modules/hotel/room_reservation/contact_information/view_model/contact_information_argument_model.dart';

class QueriesUpdateCustomer {
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
