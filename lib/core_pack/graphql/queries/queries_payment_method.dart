class QueriesPaymentMethod {
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
                  cardRef
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
