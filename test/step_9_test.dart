import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_string_calculator/string_calculator.dart';

void main() {
  group("Step 9 . Handle multiple delimiters of any length", () {
    final calculator = StringCalculator();

    test('Two delimiters * and %', () {
      expect(calculator.add("//[*][%]\n1*2%3"), 6);
    });

    test('Three delimiters: @, ##, ;', () {
      expect(calculator.add("//[@][##][;]\n4@5##6;7"), 22);
    });

    test('Different length delimiters mixed', () {
      expect(calculator.add("//[***][%%]\n1***2%%3"), 6);
    });

    test('Numbers > 1000 are ignored', () {
      expect(calculator.add("//[*][%]\n2*1001%3"), 5);
    });

    test('Negative numbers across multiple delimiters throws', () {
      expect(() => calculator.add("//[*][%]\n1*-2%3"), throwsFormatException);
    });

    test('Single number with multiple delimiters defined', () {
      expect(calculator.add("//[*][%]\n9"), 9);
    });
  });
}
