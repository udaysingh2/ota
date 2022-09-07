import 'package:flutter/foundation.dart';

printDebug(text, {String header = ''}) {
  if (kDebugMode) print('$header: $text');
}

printWarning(String text) {
  printDebug('\x1B[33m$text\x1B[0m');
}

printError(String text) {
  printDebug('\x1B[31m$text\x1B[0m');
}
