import 'package:uuid/uuid.dart';

class Account {
  String id;
  String name;
  List<String> quizIDs;

  Account({this.name}) {
    this.id = Uuid().v4();
    this.quizIDs = [];
  }

  // Mapping
  static final String _idKey = "id";
  static final String _nameKey = "name";
  static final String _quizIDsKey = "quizzes";

  Account.fromMap(Map<String, dynamic> m) {
    this.id = m[_idKey] as String;
    this.name = m[_nameKey] as String;
    this.quizIDs = List<String>();
    var ids = m[_quizIDsKey] as List;
    for (var quizID in ids) {
      this.quizIDs.add(quizID);
    }
  }

  Map<String, dynamic> toMap() {
    var quizIDs = List<String>();
    for (var qID in this.quizIDs) {
      quizIDs.add(qID);
    }
    var map = {
      _idKey: id,
      _nameKey: name,
      _quizIDsKey: quizIDs,
    };
    return map;
  }
}
