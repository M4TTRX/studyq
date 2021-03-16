import 'dart:convert';
import 'dart:math';

import 'package:studyQ/models/friend_score_model.dart';
import 'package:studyQ/models/question_model.dart';
import 'package:uuid/uuid.dart';

class Quiz {
  String id;
  String name;
  List<Question> questions;
  int _highScore;
  List<FriendScore> leaderboard;

  Quiz({this.name, this.questions}) {
    id = Uuid().v4();
    var rng = new Random();
    leaderboard = [
      FriendScore(username: "Johnny", highscore: rng.nextInt(14)),
      FriendScore(username: "Matt", highscore: rng.nextInt(14)),
      FriendScore(username: "Tom", highscore: rng.nextInt(14)),
    ];
  }

  int getHighScore() {
    var rng = new Random();
    return rng.nextInt(14);
  }

  String getScoreFraction() {
    if (questions == null) {
      return "0 / 0";
    }

    if (questions.length == 0) {
      return "0 / 0";
    }

    return getHighScore().toString() + " / " + questions.length.toString();
  }

  int getPercentage() {
    if (questions == null) {
      return 0;
    }

    return getHighScore() / questions.length == 0 ? 1 : questions.length;
  }

  void setHighScore({highScore: int}) {
    // prevent highScore from being above max score
    this._highScore = this.questions.length >= highScore ? highScore : 0;
  }

  // Mapping
  static final String _idKey = "id";
  static final String _nameKey = "name";
  static final String _questionsKey = "questions";
  static final String _highScoreKey = "highScore";
  static final String _leaderboardKey = "leaderboard";

  Quiz.fromMap(Map<String, dynamic> m) {
    this.id = m[_idKey] as String ?? "<no_id>";
    this.name = m[_nameKey] as String ?? "<no_name>";
    this._highScore = m[_highScoreKey] as int ?? 0;

    // questions
    this.questions = List<Question>();
    var questions = m[_questionsKey] as List;
    for (var option in questions) {
      this.questions.add(Question.fromMap(option));
    }
    // leaderboard
    this.leaderboard = List<FriendScore>();
    if (m[_leaderboardKey] != null) {
      var friendScores = m[_leaderboardKey] as List;
      for (var f in friendScores) {
        this.leaderboard.add(FriendScore.fromMap(f));
      }
    }
  }

  Map<String, dynamic> toMap() {
    // questions
    var questions = List<Map<String, Object>>();
    for (var question in this.questions) {
      questions.add(question.toMap());
    }
    // leaderboard
    var leaderboard = List<Map<String, Object>>();
    for (var friendScore in this.leaderboard) {
      leaderboard.add(friendScore.toMap());
    }
    var map = {
      _idKey: id,
      _nameKey: name,
      _questionsKey: questions,
      _leaderboardKey: leaderboard,
      _highScoreKey: _highScore
    };
    return map;
  }

  Quiz.fromJson(String s) : this.fromMap(json.decode(s));

  String toJson() {
    var map = toMap();
    return json.encode(map);
  }
}
