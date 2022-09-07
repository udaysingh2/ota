import 'package:intl/intl.dart';
import 'package:ota/core/app_config.dart';

class CurrencyUtil {
  final String? currency;
  late NumberFormat _numberFormat;
  CurrencyUtil({this.currency, int decimalDigits = 2}) {
    _numberFormat = NumberFormat.simpleCurrency(
        name: currency ?? AppConfig().currency, decimalDigits: decimalDigits);
  }

  String getFormattedPrice(num price) {
    return _numberFormat.format(price);
  }
}
