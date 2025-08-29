import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_string_calculator/string_calculator.dart';

void main() {
  group("Step7. Delimiters can be of any length with format //[delimiter]\\n", () {

    final calculator = StringCalculator();

    test('Single custom delimiter of length > 1', () {
      expect(calculator.add("//[***]\n1***2***3"), 6);
    });

    test('Another multi-character delimiter', () {
      expect(calculator.add("//[abc]\n4abc5abc6"), 15);
    });

    test('Works with numbers bigger than 1000 too (ignored)', () {
      expect(calculator.add("//[***]\n2***1001***3"), 5);
    });

    test('Handles when only one number given', () {
      expect(calculator.add("//[***]\n7"), 7);
    });

    test('Throws for negatives with multi-char delimiter', () {
      expect(() => calculator.add("//[***]\n1***-2***3"), throwsFormatException);
    });
  });
}
