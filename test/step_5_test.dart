import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_string_calculator/string_calculator.dart';

void main() {
  group("Step5. Adding a negative number will throw an exception", () {

    final calculator = StringCalculator();

    test('Throws FormatException for one negative number', () {
      expect(() => calculator.add("1,-3,2"), throwsFormatException);
    });

    test('Throws FormatException for multiple negative numbers', () {
      expect(() => calculator.add("4,-1,-6"), throwsFormatException);
    });

    test('Throws for negative numbers with custom delimiter', () {
      expect(() => calculator.add("//;\n1;-2;3;-7"), throwsFormatException);
    });

    test('Returns sum when no negatives', () {
      expect(calculator.add("1,2,3"), 6);
    });
  });
}