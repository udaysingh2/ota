class QueriesMessage {
  static String getNewsData(int offset) {
    return '''
              mutation {
                notificationInquiry(
                    notificationInquiryRequest: {
                    offset:$offset,
                    notificationType:"GLOBAL"
                    }
                  ) {
                    data {
                      messageList
                      {
                        messageId
                        bookingUrn
                        confirmationNo
                        bookingStatus
                        subject
                        body
                        category
                        promotionType
                        readFlag
                        createDate
                        deeplink
                        priority
                      }
                    }
                    status {
                      code
                      header
                      description
                      }
                    }
              }''';
  }

  static String getReceiptsData(int offset) {
    return '''
            mutation {
              notificationInquiry(
                notificationInquiryRequest: {
                  offset: $offset
                  notificationType: "INDIVIDUAL"
                }
              ) {
                data {
                  messageList {
                    messageId
                    body
                    subject
                    category
                    createDate
                    priority
                    promotionType
                    readFlag
                    bookingUrn
                    deeplink
                    confirmationNo
                    bookingStatus
                  }
                }
                status {
                  code
                  header
                  description
                }
              }
            }''';
  }

  static String markMessagesRead(String type, int messageId) {
    return '''
            mutation {
          notificationRead(
            notificationReadRequest: {
                messageId:$messageId
                notificationType:"$type"
            }
          ) {
            data {
                messageId
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

  static String deleteMessage(String type, int messageId) {
    return '''
            mutation {
          notificationRemove(
            notificationRemoveRequest: {
                messageId:$messageId
                notificationType:"$type"
            }
          ) {
            data {
                messageId
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
