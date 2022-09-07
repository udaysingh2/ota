class QueriesPaymentMethodAutomation {
  static String getPaymentMethodListData() {
    return '''
          query {
            getCustomerPaymentMethodDetails {
              data {
                cardCurrent
                cardMaximum
                paymentList {
                  paymentMethodId
                  sortSequence
                  cardMask
                  cardType
                  cardBank
                  defaultMethodFlag
                  nickname
                  paymentStatus
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
