class Option {
  final String text;
  final bool isCorrect;

  Option(this.text, this.isCorrect);

  // Mapping
  static final String _textKey = "text";
  static final String _isCorrectKey = "isCorrect";
  Option.fromMap(Map<String, dynamic> m)
      : text = m[_textKey],
        isCorrect = m[_isCorrectKey];

  Map<String, dynamic> toMap() => {_textKey: text, _isCorrectKey: isCorrect};
}
