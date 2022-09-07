import 'package:ota/domain/insurance/models/insurance_argument_domain.dart';
import 'package:ota/domain/insurance/models/insurance_model_domain.dart';

import 'insurance_data_source.dart';

class InsuranceMockDataSourceImpl implements InsuranceRemoteDataSource {
  InsuranceMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  static String getMockData1899() {
    return _response1899;
  }

  static String getMockData1999() {
    return _response1999;
  }

  static String getEmptyList() {
    return _emptyList;
  }

  @override
  Future<InsuranceModelDomain> getInsuranceData(
      InsuranceArgumentDomain argumentModel) async {
    await Future.delayed(const Duration(seconds: 1));
    return InsuranceModelDomain.fromJson(_responseMock);
  }
}

var _responseMock = """
 {
	"getInsurance": {
		"data": {
			"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/5.jpg",
			"insuranceHeaderTitle": "recommended",
			"insuranceFooterTitle": "*Buyers should understand the details of coverage and conditions before deciding to purchase insurance every time.",
			"insurances": [{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},
				{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},
				{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},
				{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},
				{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},
				{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},
				{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},
				{
					"insuranceId": 101,
					"sortSeqNo": 1,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"HOTEL",
						"TOUR",
						"TRAVEL"
					]
				},
				{
					"insuranceId": 100,
					"sortSeqNo": 2,
					"insuranceImage": "https://ota.robinhood.co.th/insurance/insurance1.png",
					"insuranceTitle": "กรุงเทพประกันภัย",
					"insuranceDetail": "คุ้มครองครอบคลุมการเกิดอุบัติเหตุขณะเดินทาง",
					"promotions": {
						"type": "OVERLAY",
						"promotionTextLine1": "ใหม่"
					},
					"popup": {
						"body": "หากคุณต้องการออกจากแอป Robinhood เพื่อเข้าสู่เว็ปไซต์แอกซ่าประกันภัย กรุณากด ตกลง เพื่อดำเนินการต่อ สอบถามเพิ่มเติมกรุณาติดต่อแอกซ่าประกันภัยโทร 1159",
						"actionType": "WEBVIEW",
						"actionUrl": "https://www.axa.co.th/travel-accident-protection"
					},
					"insuranceCategories": [
						"Cate1",
						"Cate2",
						"Cate3"
					],
					"recommendedForServices": [
						"TOUR"
					]
				}
			]
		},
		"status": {
			"code": "1000",
			"header": "success"
		}
	}
}
""";

var _response1899 = """
{
	"getInsurance": {
		"status": {
			"code": "1899",
			"header": "success"
		}
	}
}
""";

var _response1999 = """
{
	"getInsurance": {
		"status": {
			"code": "1999",
			"header": "success"
		}
	}
}
""";

var _emptyList = """
 {
	"getInsurance": {
		"data": {
			"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/5.jpg",
			"insuranceHeaderTitle": "recommended",
			"insuranceFooterTitle": "*Buyers should understand the details of coverage and conditions before deciding to purchase insurance every time.",
			"insurances": [
			]
		},
		"status": {
			"code": "1000",
			"header": "success"
		}
	}
}
""";
