import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/answer_model.dart';
import 'package:studyQ/models/question_model.dart';
import 'package:studyQ/models/quiz_model.dart';

class QuizView extends StatefulWidget {
  QuizView({Key key, this.quiz}) : super(key: key) {
    shuffledQuestions = quiz.questions;
    shuffledQuestions.shuffle();
    shuffledQuestions[currentQuestion].answers.shuffle();
  }

  final Quiz quiz;

  List<Question> shuffledQuestions;
  int currentQuestion = 0;

  Color incorrectColor = Colors.transparent;
  Color correctColor = Colors.transparent;

  List<Colors> colours;

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  Widget build(BuildContext context) {

    List<Widget> content;
    if (widget.currentQuestion < widget.shuffledQuestions.length) {
      Question question = widget.shuffledQuestions[widget.currentQuestion];

      List<Answer> shuffledAnswers = question.answers;
      
      Column answers = Column(
        children: shuffledAnswers.map((answer) =>
          Padding(
            padding: const EdgeInsets.all(16),
            child: FlatButton(
              color: answer.isCorrect ? widget.correctColor : widget.incorrectColor,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(answer.answer, style: TextStyle(fontSize: 20)),
                    fit: FlexFit.loose,
                  )
                ]
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                setState(() {
                  widget.correctColor = Colors.green.shade500;
                  widget.incorrectColor = Colors.red.shade500;
                });
              },
            ),
          )
        ).toList()
      );

      content = [
        Column(
          children: <Widget>[
            Text(question.question, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            answers
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