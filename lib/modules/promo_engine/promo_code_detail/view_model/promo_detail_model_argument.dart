class PromoDetailModelArgument {
  final String? webViewUrl;
  final bool isPromoCodeAvailable;
  final bool isInternetAvailable;

  PromoDetailModelArgument(
      {this.webViewUrl,
      required this.isPromoCodeAvailable,
      this.isInternetAvailable = false});
}
