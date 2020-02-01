import 'package:uuid/uuid.dart';

import 'answer_model.dart';

class Question {
  String id;
  String question;
  List<Answer> answers;

  Question({this.question, this.answers}) {
    id = Uuid().v4();
  }

  // Mapping
  static final String _idKey = "id";
  static final String _questionKey = "question";
  static final String _answersKey = "answers";

  Question.fromMap(Map<String, dynamic> m) {
    this.id = m[_idKey] as String;
    this.question = m[_questionKey] as String;
    this.answers = List<Answer>();
    var answers = m[_answersKey] as List;
    for (var answer in answers) {
      this.answers.add(Answer.fromMap(answer));
    }
  }

  Map<String, dynamic> toMap() {
    var answers = List<Map<String, Object>>();
    for (var answer in this.answers) {
      answers.add(answer.toMap());
    }
    var map = {_idKey: id, _questionKey: question, _answersKey: answers};
    return map;
  }
}
