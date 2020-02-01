class Answer {
  final String answer;
  final bool isCorrect;

  Answer(this.answer, this.isCorrect);

  // Mapping
  static final String _answerKey = "answer";
  static final String _isCorrectKey = "isCorrect";
  Answer.fromMap(Map<String, dynamic> m)
      : answer = m[_answerKey],
        isCorrect = m[_isCorrectKey];

  Map<String, dynamic> toMap() =>
      {_answerKey: answer, _isCorrectKey: isCorrect};
}
