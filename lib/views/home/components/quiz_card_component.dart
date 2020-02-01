import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:studyQ/models/quiz_model.dart';

class QuizCard extends Card {

  final Quiz quiz;

  QuizCard(this.quiz, {Future<void> Function(Quiz quiz) startQuiz}) 
  : super(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(quiz.name),
          RaisedButton(
            child: Text("Start"),
            onPressed: () {
              HapticFeedback.lightImpact();
              startQuiz(quiz);
            },
          ),
        ],
      ),
    )
  );
}
