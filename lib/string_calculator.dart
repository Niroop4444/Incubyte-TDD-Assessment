class StringCalculator {
  final RegExp commaNewLineRegEx = RegExp(r'[,]');

  int add(String input) {
    if (input.trim().isEmpty) return 0;

    final numbers = input.split(commaNewLineRegEx);

    if (numbers.length > 2) {
      throw FormatException("Only up to two numbers are allowed");
    }

    return numbers.map(int.parse).fold(0, (a, b) => a + b);
  }
}