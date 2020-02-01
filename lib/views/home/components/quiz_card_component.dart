import 'package:flutter/cupertino.dart';
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
    color: Colors.grey.shade300,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Spacer(flex: 2),
          Column(
            children: <Widget>[
              Text(quiz.name, style: TextStyle(fontWeight: FontWeight.bold),),
              Text("Scored " + quiz.getScoreFraction())
            ],
          ),
          Spacer(flex: 2),
          CupertinoButton(
            child: Text("View", style: TextStyle(fontSize: 20)),
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
