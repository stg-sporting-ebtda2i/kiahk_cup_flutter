class StringUtils {

  static String capitalizeWords(String input) {
    if (input.isEmpty) {
      return input;
    }

    return input.split('.').map((sentence) {
      if (sentence.isEmpty) {
        return sentence;
      }
      sentence = sentence.trim();

      if (sentence.isNotEmpty) {
        sentence = sentence[0].toUpperCase() + sentence.substring(1).toLowerCase();
      }

      sentence = sentence.split(' ').map((word) {
        if (word.isEmpty) {
          return word;
        }
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');

      return sentence;
    }).join('.');
  }

}