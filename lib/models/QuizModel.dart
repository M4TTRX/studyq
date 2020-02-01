import 'package:studyQ/model/quiz/question.dart';
import 'package:uuid/uuid.dart';

class Quiz {
  String id;
  String quiz;
  List<Question> questions;

  Quiz({ this.quiz, this.questions }) {
    id = Uuid().v4();
  }

  // Mapping
  static final String _idKey = "id";
  static final String _quizKey = "quiz";
  static final String _questionsKey = "questions";

  Quiz.fromMap(Map<String, dynamic> m) {
    this.id = m[_idKey] as String;
    this.quiz = m[_quizKey] as String;
    this.questions = List<Question>();
    var questions = m[_questionsKey] as List;
    for (var option in questions) {
      this.questions.add(Question.fromMap(option));
    }
  }

  Map<String, dynamic> toMap() {
    var questions = List<Map<String, Object>>();
    for (var option in this.questions) {
      questions.add(option.toMap());
    }
    var map = {_idKey: id, _quizKey: quiz, _questionsKey: questions};
    return map;
  }
}
