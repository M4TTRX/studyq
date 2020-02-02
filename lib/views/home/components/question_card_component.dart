import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyQ/models/answer_model.dart';

import 'package:studyQ/models/question_model.dart';

class QuestionCard extends Card {

  final Question question;

  QuestionCard(this.question, {Future<void> Function(Question question) startQuestion, void Function() updateState}) : super(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(question.question, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Column(
            children: question.answers.map((answer) =>
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(answer.answer, style: TextStyle()),
                      fit: FlexFit.tight
                    ),
                    Checkbox(value: answer.isCorrect, onChanged: (bool newValue) {
                      newValue = setCorrectAnswer(question, answer);
                      updateState();
                    })
                  ]
                ),
              )
            ).toList()
          )
        ]
      ),
    )
  );

  static bool setCorrectAnswer(Question question, Answer correctAnswer) {
    question.answers.forEach((answer) => answer.isCorrect = answer == correctAnswer);
    question.setCorrectAnswer(correctAnswer);
    return true;
  }
}