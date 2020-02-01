class Account {
  String userName;
  List<String> quizIDs;

  Account({this.userName}) {
    this.quizIDs = [];
  }

  // Mapping
  static final String _userNameKey = "userName";
  static final String _quizIDsKey = "quizzes";

  Account.fromMap(Map<String, dynamic> m) {
    this.userName = m[_userNameKey] as String;
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
      _userNameKey: userName,
      _quizIDsKey: quizIDs,
    };
    return map;
  }
}
