import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:studyQ/models/question_model.dart';

class QuestionCard extends Card {

  final Question question;

  QuestionCard(this.question, {Future<void> Function(Question question) startQuestion}) 
  : super(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color: Colors.grey.shade300,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(question.question, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    CupertinoSwitch(value: answer.isCorrect, onChanged: null)
                  ]
                ),
              )
            ).toList()
          )
        ]
      ),
    )
  );
}
