class VirtualPaymentViewModel {
  VirtualPaymentState state;
  WalletState walletState;
  double? walletPaidAmmount;
  double? balance;
  String? pocketStatus;
  String? balanceStatus;
  String? currency;

  VirtualPaymentViewModel({
    required this.state,
    required this.walletState,
    this.balance,
    this.balanceStatus,
    this.currency,
    this.pocketStatus,
    this.walletPaidAmmount,
  });
}

enum VirtualPaymentState { none, loading, success, failure }

enum WalletState { disabled, on, off }
