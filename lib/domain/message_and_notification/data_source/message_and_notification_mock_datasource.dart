import 'package:ota/domain/message_and_notification/data_source/message_and_notification_data_source.dart';
import 'package:ota/domain/message_and_notification/models/message_model_domain.dart';

class MessageAndNotificationMockDataSource
    implements MessageAndNotificationRemoteDataSource {
  static String getMockNewsData() {
    return _newsData;
  }

  static String getMockReceiptData() {
    return _receiptData;
  }

  @override
  Future<MessageModelDomain> getNewsData(int offset) async {
    return MessageModelDomain.fromJson(_newsData);
  }

  @override
  Future<MessageModelDomain> getReceiptsData(int offset) async {
    return MessageModelDomain.fromJson(_receiptData);
  }

  @override
  Future<bool> readMessage(
      {required String type, required int messageId}) async {
    return true;
  }

  @override
  Future<bool> deleteMessage(
      {required String type, required int messageId}) async {
    return true;
  }
}

String _newsData = '''{
	"notificationInquiry": {
		"data": {
			"messageList": [{
					"messageId": 787798000,
					"bookingUrn": null,
					"confirmationNo": null,
					"bookingStatus": "CONFIRMED",
					"subject": "Promotion to your satisfaction",
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"category": "ANNOUNCEMENT",
					"promotionType": "HOTEL",
					"readFlag": false,
					"createDate": null,
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"priority": "High"
				},
				{
					"messageId": 787798002,
					"bookingUrn": null,
					"confirmationNo": null,
					"bookingStatus": "CONFIRMED",
					"subject": "Promotion to your satisfaction",
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"category": "PROMOTION",
					"promotionType": "HOTEL",
					"readFlag": false,
					"createDate": null,
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"priority": "High"
				},
				{
					"messageId": 787798003,
					"bookingUrn": null,
					"confirmationNo": null,
					"bookingStatus": "CONFIRMED",
					"subject": "Promotion to your satisfaction",
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"category": "ANNOUNCEMENT",
					"promotionType": "HOTEL",
					"readFlag": false,
					"createDate": null,
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"priority": "High"
				},
				{
					"messageId": 787798004,
					"bookingUrn": null,
					"confirmationNo": null,
					"bookingStatus": "CONFIRMED",
					"subject": "Promotion to your satisfaction",
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"category": "PROMOTION",
					"promotionType": "HOTEL",
					"readFlag": false,
					"createDate": null,
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"priority": "High"
				},
				{
					"messageId": 787798005,
					"bookingUrn": null,
					"confirmationNo": null,
					"bookingStatus": "CONFIRMED",
					"subject": "Promotion to your satisfaction",
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"category": "PROMOTION",
					"promotionType": "HOTEL",
					"readFlag": false,
					"createDate": null,
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"priority": "High"
				},
				{
					"messageId": 787798007,
					"bookingUrn": null,
					"confirmationNo": null,
					"bookingStatus": "CONFIRMED",
					"subject": "Promotion to your satisfaction",
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"category": "PROMOTION",
					"promotionType": "HOTEL",
					"readFlag": false,
					"createDate": null,
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"priority": "High"
				},
				{
					"messageId": 787798008,
					"bookingUrn": null,
					"confirmationNo": null,
					"bookingStatus": "CONFIRMED",
					"subject": "Promotion to your satisfaction",
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"category": "PROMOTION",
					"promotionType": "HOTEL",
					"readFlag": false,
					"createDate": null,
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"priority": "High"
				},
				{
					"messageId": 787798009,
					"bookingUrn": null,
					"confirmationNo": null,
					"bookingStatus": "CONFIRMED",
					"subject": "Promotion to your satisfaction",
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"category": "PROMOTION",
					"promotionType": "HOTEL",
					"readFlag": false,
					"createDate": null,
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"priority": "High"
				},
				{
					"messageId": 787798010,
					"bookingUrn": null,
					"confirmationNo": null,
					"bookingStatus": "CONFIRMED",
					"subject": "Promotion to your satisfaction",
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"category": "ANNOUNCEMENT",
					"promotionType": "HOTEL",
					"readFlag": false,
					"createDate": null,
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"priority": "High"
				},
				{
					"messageId": 787798011,
					"bookingUrn": null,
					"confirmationNo": null,
					"bookingStatus": "CONFIRMED",
					"subject": "Promotion to your satisfaction",
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"category": "ANNOUNCEMENT",
					"promotionType": "FOOD",
					"readFlag": false,
					"createDate": null,
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"priority": "High"
				}
			]
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}''';

String _receiptData = '''{
	"notificationInquiry": {
		"data": {
			"messageList": [{
					"messageId": 5663534501,
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"subject": "Promotion to your satisfaction",
					"category": "E_RECEIPT",
					"createDate": null,
					"priority": null,
					"promotionType": "HOTEL",
					"readFlag": false,
					"bookingUrn": "H20211020AA0260",
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"confirmationNo": "B2CMMA211186301",
					"bookingStatus": "CONFIRMED"
				},
				{
					"messageId": 5663534502,
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"subject": "Promotion to your satisfaction",
					"category": "E_RECEIPT",
					"createDate": null,
					"priority": null,
					"promotionType": "HOTEL",
					"readFlag": false,
					"bookingUrn": "H20211020AA0260",
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"confirmationNo": "B2CMMA211186301",
					"bookingStatus": "CONFIRMED"
				},
				{
					"messageId": 5663534503,
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"subject": "Promotion to your satisfaction",
					"category": "E_RECEIPT",
					"createDate": null,
					"priority": null,
					"promotionType": "HOTEL",
					"readFlag": false,
					"bookingUrn": "H20211020AA0260",
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"confirmationNo": "B2CMMA211186301",
					"bookingStatus": "CONFIRMED"
				},
				{
					"messageId": 5663534504,
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"subject": "Promotion to your satisfaction",
					"category": "E_RECEIPT",
					"createDate": null,
					"priority": null,
					"promotionType": "HOTEL",
					"readFlag": false,
					"bookingUrn": "H20211020AA0260",
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"confirmationNo": "B2CMMA211186301",
					"bookingStatus": "CONFIRMED"
				},
				{
					"messageId": 5663534505,
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"subject": "Promotion to your satisfaction",
					"category": "E_RECEIPT",
					"createDate": null,
					"priority": null,
					"promotionType": "HOTEL",
					"readFlag": false,
					"bookingUrn": "H20211020AA0260",
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"confirmationNo": "B2CMMA211186305",
					"bookingStatus": "CONFIRMED"
				},
				{
					"messageId": 5663534506,
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"subject": "Promotion to your satisfaction",
					"category": "E_RECEIPT",
					"createDate": null,
					"priority": null,
					"promotionType": "HOTEL",
					"readFlag": false,
					"bookingUrn": "H20211020AA0260",
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"confirmationNo": "B2CMMA211186306",
					"bookingStatus": "CONFIRMED"
				},
				{
					"messageId": 5663534507,
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"subject": "Promotion to your satisfaction",
					"category": "E_RECEIPT",
					"createDate": null,
					"priority": null,
					"promotionType": "HOTEL",
					"readFlag": false,
					"bookingUrn": "H20211020AA0260",
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"confirmationNo": "B2CMMA211186307",
					"bookingStatus": "CONFIRMED"
				},
				{
					"messageId": 5663534508,
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"subject": "Promotion to your satisfaction",
					"category": "E_RECEIPT",
					"createDate": null,
					"priority": null,
					"promotionType": "HOTEL",
					"readFlag": false,
					"bookingUrn": "H20211020AA0260",
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"confirmationNo": "B2CMMA211186308",
					"bookingStatus": "CONFIRMED"
				},
				{
					"messageId": 5663534509,
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"subject": "Promotion to your satisfaction",
					"category": "E_RECEIPT",
					"createDate": null,
					"priority": null,
					"promotionType": "HOTEL",
					"readFlag": false,
					"bookingUrn": "H20211020AA0260",
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"confirmationNo": "B2CMMA211186309",
					"bookingStatus": "CONFIRMED"
				},
				{
					"messageId": 5663534510,
					"body": "Pay ฿20 get Robinhood discount Total ฿100 baht",
					"subject": "Promotion to your satisfaction",
					"category": "E_RECEIPT",
					"createDate": null,
					"priority": null,
					"promotionType": "HOTEL",
					"readFlag": false,
					"bookingUrn": "H20211020AA0260",
					"deeplink": "scbeasy://payments/creditcard/review/id/1234",
					"confirmationNo": "B2CMMA211186310",
					"bookingStatus": "CONFIRMED"
				}
			]
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
''';
