import 'package:ota/modules/ota_common/model/ota_service_type.dart';

class QueriesOtaFilterSort {
  static String getOtaFilterSortData() {
    return '''
query {
  getSortCriteriaForService(
  sortCriteriaRequest: { serviceType: "${OtaServiceType.hotel}" }) {
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
        description
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
