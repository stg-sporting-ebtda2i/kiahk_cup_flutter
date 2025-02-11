class Question {
  final String question;
  final List<String> options;
  int selected;

  Question({
    required this.question,
    required this.options,
    this.selected = -1,
  });
}