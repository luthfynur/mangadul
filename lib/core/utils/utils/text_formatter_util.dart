class TextFormatter {
  static String slicedText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }

  static String uppercaseFirstLetter(String text) {
    String firstLetter = text.split("").first;
    return text.replaceFirst(firstLetter, firstLetter.toUpperCase());
  }
}
