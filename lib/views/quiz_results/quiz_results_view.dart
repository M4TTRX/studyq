import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/answer_model.dart';
import 'package:studyQ/models/question_model.dart';
import 'package:studyQ/models/quiz_model.dart';

class QuizResultsView extends StatefulWidget {
  QuizResultsView({Key key, this.quiz, this.score}) : super(key: key) {

  }

  final Quiz quiz;
  final int score;

  @override
  _QuizResultsViewState createState() => _QuizResultsViewState();
}

class _QuizResultsViewState extends State<QuizResultsView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.name)
      ),
      body: Row(
        children: <Widget>[
          Spacer(flex: 1),
          Column(
            children: <Widget>[
              Spacer(flex: 1),
              Text((widget.score / widget.quiz.questions.length * 100).round().toInt().toString() + "%", style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold)),
              Text(widget.score.toString() + " / " + widget.quiz.questions.length.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Spacer(flex: 3)
            ]
          ),
          Spacer(flex: 1)
        ]
      ),
    );
  }

  void updateState() {
    setState(() {
      return;
    });
  }
}