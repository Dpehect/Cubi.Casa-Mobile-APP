extension StringExtensions on String {
  bool get isValidEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(this);
  }

  bool get isValidPassword {
    return length >= 6;
  }

  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  String get capitalizeEachWord {
    return split(' ')
        .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  bool get isNumeric {
    return RegExp(r'^\d+$').hasMatch(this);
  }

  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  String get trimBoth {
    return trim();
  }

  String truncate(int length, {String ellipsis = '...'}) {
    if (this.length <= length) return this;
    return substring(0, length - ellipsis.length) + ellipsis;
  }
}
