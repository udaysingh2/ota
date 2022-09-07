class QueriesVirtualPayment {
  static String getVirtualWalletBalance() {
    return '''
        query{
    getVaBalance{
        data {
            pocketStatus
            balance
            currency
            balanceStatus
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
