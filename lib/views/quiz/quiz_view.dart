import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/question_model.dart';
import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/views/home/components/question_card_component.dart';

class QuizView extends StatefulWidget {
  QuizView({Key key, this.quiz}) : super(key: key) {
    orderedQuestions = quiz.questions;
    orderedQuestions.shuffle();
  }

  final Quiz quiz;

  List<Question> orderedQuestions;
  int currentQuestion = 0;

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  Widget build(BuildContext context) {

    List<Widget> content;
    if (widget.currentQuestion < widget.orderedQuestions.length) {
      Question question = widget.orderedQuestions[widget.currentQuestion];

      Column answers = Column(
        children: question.answers.forEach((answer) =>
        
        )
      );

      content = [
        Column(
          children: <Widget>[
            Text(question.question, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        )
      ];
    }

    return Scaffold(
       appBar: AppBar(
        title: Text(widget.quiz.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: content
        ),
      ),
    );
  }
}