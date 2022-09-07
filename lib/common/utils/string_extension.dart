extension StringUpdate on String {
  String addLeadingSpace() {
    return " ${this}";
  }

  String addLeadingDash() {
    return "- ${this}";
  }

  String addTrailingSpace() {
    return "${this} ";
  }

  String addLeadingSlash() {
    return "/${this}";
  }

  String addTrailingSlash() {
    return "${this}/";
  }

  String addTrailingPercent() {
    return "${this}%";
  }

  String addLeadingPlus() {
    return " + ${this}";
  }

  String addTrailingPlus() {
    return "${this} + ";
  }

  String addLeadingComma() {
    return ", ${this}";
  }

  String addTrailingComma() {
    return "${this}, ";
  }

  String addParenthesis() {
    return "(${this})";
  }

  String addOpeningParenthesis() {
    return " (${this}";
  }

  String addClosingParenthesis() {
    return "${this}) ";
  }

  String addNextLine() {
    return "${this}\n";
  }

  String addTrailingDash() {
    return "${this} - ";
  }

  String addTrailingColon() {
    return "${this} : ";
  }

  String surroundWithDoubleQuote() {
    return "\"${this}\"";
  }

  String surroundWithSingleQuote() {
    return "'${this}'";
  }

  String addTrailingDot() {
    return "${this} • ";
  }

  double? toDouble() {
    return double.tryParse(this);
  }

  String replaceLast(String from, String replace) {
    return replaceFirst(
        from, replace, lastIndexOf(from) <= 0 ? 0 : lastIndexOf(from));
  }
}
