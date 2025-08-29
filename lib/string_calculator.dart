class StringCalculator {
  final RegExp commaNewLineRegEx = RegExp(r'[,\n]');

  int add(String input) {
    if (input.trim().isEmpty) return 0;

    input = input.replaceAll(r'\n', '\n');

    return input
        .split(commaNewLineRegEx)
        .where((numbers) => numbers.trim().isNotEmpty)
        .map(int.parse)
        .fold(0, (a, b) => a + b);
  }
}
