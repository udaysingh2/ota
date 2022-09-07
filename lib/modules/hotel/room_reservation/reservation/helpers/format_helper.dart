import 'package:flutter/services.dart';
import 'package:ota/modules/tours/reservation/helper/upper_case_text_formatter.dart';

class FormatHelper {
  static List<TextInputFormatter> getInputFormatter() {
    const String searchFormatter =
        r'([A-Za-z\u0E00-\u0E7F0-9-’#_"&()@ *:,./ ]{0,5})' r"([']{0,5})";
    const int characterLimit = 50;
    List<TextInputFormatter> formatterList = [
      LengthLimitingTextInputFormatter(characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(searchFormatter),
      ),
    ];
    return formatterList;
  }

  static List<TextInputFormatter> getMobileNumberFormatter() {
    // const String _searchFormatter =
    //     r'((\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+))|\d{5}([- ]*)\d{6}';
    const String searchFormatter = '^\$|^(([0-9]{0,10}))';

    const int characterLimit = 10;
    List<TextInputFormatter> formatterList = [
      LengthLimitingTextInputFormatter(characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(searchFormatter),
      ),
    ];
    return formatterList;
  }

  static List<TextInputFormatter> getWeightFormatter() {
    const String searchFormatter = '^\$|^(([1-9][0-9]{0,2}))(\\.[0-9]{0,2})?';
    const int characterLimit = 6;
    List<TextInputFormatter> formatterList = [
      LengthLimitingTextInputFormatter(characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(searchFormatter),
      ),
    ];
    return formatterList;
  }

  static List<TextInputFormatter> getPassportIdFormatter() {
    const String searchFormatter = r'([A-Za-z0-9]{0,5})';
    const int characterLimit = 20;
    List<TextInputFormatter> formatterList = [
      LengthLimitingTextInputFormatter(characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(searchFormatter),
      ),
      UpperCaseTextFormatter(),
    ];
    return formatterList;
  }

  static List<TextInputFormatter> getNameFormatter() {
    const String nameFormatter = r'[A-Za-z0-9-*_#()@:./ ]';
    const int characterLimit = 50;
    List<TextInputFormatter> formatterList = [
      LengthLimitingTextInputFormatter(characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(nameFormatter),
      ),
    ];
    return formatterList;
  }

  static List<TextInputFormatter> getPhoneNumberFormatter() {
    const String nameFormatter = r'[0-9]';
    const int characterLimit = 10;
    List<TextInputFormatter> formatterList = [
      LengthLimitingTextInputFormatter(characterLimit),
      FilteringTextInputFormatter.allow(
        RegExp(nameFormatter),
      ),
    ];
    return formatterList;
  }
}
