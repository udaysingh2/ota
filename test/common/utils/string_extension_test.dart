import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/string_extension.dart';

void main() {
  group('String Extension Tests', () {
    String testString = "hello";
    test('String extension addLeadingSpace', () async {
      expect(testString.addLeadingSpace(), " hello");
    });
    test('String extension addTrailingSpace', () async {
      expect(testString.addTrailingSpace(), "hello ");
    });
    test('String extension addLeadingSlash', () async {
      expect(testString.addLeadingSlash(), "/hello");
    });
    test('String extension addTrailingSlash', () async {
      expect(testString.addTrailingSlash(), "hello/");
    });
    test('String extension addLeadingPlus', () async {
      expect(testString.addLeadingPlus(), " + hello");
    });
    test('String extension addTrailingPlus', () async {
      expect(testString.addTrailingPlus(), "hello + ");
    });
    test('String extension addOpeningParenthesis', () async {
      expect(testString.addOpeningParenthesis(), " (hello");
    });
    test('String extension addClosingParenthesis', () async {
      expect(testString.addClosingParenthesis(), "hello) ");
    });
    test('String extension addNextLine', () async {
      expect(testString.addNextLine(), "hello" "\n");
    });
    test('String extension addLeadingComma', () async {
      expect(testString.addLeadingComma(), ", " "hello");
    });

    test('String extension addTrailingComma', () async {
      expect(testString.addTrailingComma(), "hello" ", ");
    });
    test('String extension addTrailingDash', () async {
      expect(testString.addTrailingDash(), "hello" " - ");
    });
  });
}
