import 'package:ota/domain/insurance/models/insurance_argument_domain.dart';

class QueriesInsurance {
  static String getInsurance(InsuranceArgumentDomain argument) {
    return '''
    query{
  getInsurance(insuranceRequestObject: { 
	  offset: ${argument.offset}
	  limit: ${argument.limit}
	  recommendedServices: "${argument.recommendedServices}" 
  }){
    data {
      serviceBackgroundUrl
      insuranceHeaderTitle
      insuranceFooterTitle
      insurances{
        insuranceId
        sortSeqNo
		insuranceImage
		insuranceTitle
		insuranceDetail
		promotions{
			type
			promotionTextLine1
		}
		popup{
			body
			actionType
			actionUrl
		}
		insuranceCategories
		recommendedForServices
      }
    }  
    status{
      code
      header
      description
    }
  }
}
''';
  }
}
