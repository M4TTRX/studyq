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
      )
    );
  }

  void updateState() {
    setState(() {
      return;
    });
  }
}