import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_string_calculator/string_calculator.dart';

void main() {
  group("Step 4. Support different delimiters", () {
    final calculator = StringCalculator();

    test('Custom delimiter ";" works: "//;\\n1;2" => 3', () {
      expect(calculator.add("//;\n1;2"), 3);
    });

    test('Custom delimiter ";" should still allow mixing with default delimiters', () {
      expect(calculator.add("//;\n1;2,4"), 7);
    });

    test('Custom delimiter "|" works: "//|\\n2|3|4" => 9', () {
      expect(calculator.add("//|\n2|3|4"), 9);
    });

    test('Custom delimiter "-" works: "//-\\n5-6" => 11', () {
      expect(calculator.add("//-\n5-6"), 11);
    });

    test('Should return 0 for empty string with custom delimiter', () {
      expect(calculator.add("//;\n"), 0);
    });

    test('Should still work with newline + custom delimiter: "//;\\n1;2\\n3"', () {
      expect(calculator.add("//;\n1;2\n3"), 6);
    });
  });
}
