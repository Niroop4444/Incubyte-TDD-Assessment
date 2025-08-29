class StringCalculator {
  final RegExp defaultDelimiter = RegExp(r'[,\n]');
  final RegExp customDelimiterRegEx = RegExp(r'^//(.+)\n([\s\S]*)$');

  int add(String input) {
    if (input.trim().isEmpty) return 0;

    input = input.replaceAll(r'\n', '\n');

    RegExp activeDelimiter = defaultDelimiter;
    String numbersPart = input;

    final match = customDelimiterRegEx.firstMatch(input);
    if (match != null) {
      String delimiterSection = match.group(1)!;
      numbersPart = match.group(2)!;

      List<String> delimiters = [];
      final bracketRegEx = RegExp(r'\[(.+?)\]');
      final bracketMatches = bracketRegEx.allMatches(delimiterSection);

      if (bracketMatches.isNotEmpty) {
        delimiters = bracketMatches.map((m) => m.group(1)!).toList();
      } else {
        delimiters = [delimiterSection];
      }

      final escaped = delimiters.map(RegExp.escape).join('|');
      activeDelimiter = RegExp('($escaped|,|\n)');
    }

    final numbers = numbersPart
        .split(activeDelimiter)
        .where((s) => s.trim().isNotEmpty)
        .map(int.parse)
        .toList();

    final negatives = numbers.where((n) => n < 0).toList();
    if (negatives.isNotEmpty) {
      throw FormatException(
        'negative numbers not allowed: ${negatives.join(",")}',
      );
    }

    final validNumbers = numbers.where((n) => n <= 1000);

    return validNumbers.fold(0, (sum, n) => sum + n);
  }
}
