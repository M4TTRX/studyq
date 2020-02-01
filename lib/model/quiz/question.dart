import 'package:studyQ/model/quiz/option.dart';
import 'package:uuid/uuid.dart';

class Question {
  String id;
  String question;
  List<Option> options;

  Question({this.question, this.options}) {
    id = Uuid().v4();
  }

  // Mapping
  static final String _idKey = "id";
  static final String _questionKey = "question";
  static final String _optionsKey = "options";

  Question.fromMap(Map<String, dynamic> m) {
    this.id = m[_idKey] as String;
    this.question = m[_questionKey] as String;
    this.options = List<Option>();
    var options = m[_optionsKey] as List;
    for (var option in options) {
      this.options.add(Option.fromMap(option));
    }
  }

  Map<String, dynamic> toMap() {
    var options = List<Map<String, Object>>();
    for (var option in this.options) {
      options.add(option.toMap());
    }
    var map = {_idKey: id, _questionKey: question, _optionsKey: options};
    return map;
  }
}
