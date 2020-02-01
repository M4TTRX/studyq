import 'dart:convert';

import 'package:studyQ/model/quiz/QuestionModel.dart';
import 'package:uuid/uuid.dart';

class Quiz {
  String id;
  String name;
  List<Question> questions;
  int highScore;

  Quiz({this.name, this.questions, this.highScore}) {
    id = Uuid().v4();
    // prevent highScore from being above max score
    this.highScore =
        this.questions.length >= this.highScore ? this.highScore : 0;
  }

  // Mapping
  static final String _idKey = "id";
  static final String _nameKey = "name";
  static final String _questionsKey = "questions";
  static final String _highScoreKey = "highScore";

  Quiz.fromMap(Map<String, dynamic> m) {
    this.id = m[_idKey] as String ?? "<no_id>";
    this.name = m[_nameKey] as String ?? "<no_name>";
    this.highScore = m[_highScoreKey] as int ?? 0;
    this.questions = List<Question>();
    var questions = m[_questionsKey] as List;
    for (var option in questions) {
      this.questions.add(Question.fromMap(option));
    }
  }

  Map<String, dynamic> toMap() {
    var questions = List<Map<String, Object>>();
    for (var question in this.questions) {
      questions.add(question.toMap());
    }
    var map = {
      _idKey: id,
      _nameKey: name,
      _questionsKey: questions,
      _highScoreKey: highScore
    };
    return map;
  }

  Quiz.fromJson(String s) {
    var map = json.decode(s);
    Quiz.fromMap(map);
  }

  String toJson() {
    var map = toMap();
    return json.encode(map);
  }
}
