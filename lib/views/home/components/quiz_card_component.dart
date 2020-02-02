import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/friend_score_model.dart';

import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/views/shared/whitespace.dart';

class QuizCard extends Card {
  final Quiz quiz;

  QuizCard(this.quiz, {Future<void> Function(Quiz quiz) viewQuiz})
      : super(
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  quiz.name.toUpperCase(),
                  style: TextStyle(fontSize: 24),
                ),
                _getLeaderBoard(quiz.leaderboard),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: Colors.green,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "View",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      viewQuiz(quiz);
                    },
                  ),
                ),
              ],
            ),
          ),
        );

  static Widget _getLeaderBoard(List<FriendScore> leaderboard) {
    var table = List<Widget>();
    leaderboard.forEach((s) => {
          table.add(Divider()),
          table.add(Row(
            children: <Widget>[
              Text(s.username),
              WhiteSpace(),
              Text(s.highscore.toString()),
            ],
          ))
        });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        children: table,
      ),
    );
  }
}
