import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/answer_model.dart';
import 'package:studyQ/models/question_model.dart';
import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/views/home/components/question_card_component.dart';

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

      /*
      Map<Answer, Color> shuffledAnswers = Map.fromIterables(
        question.answers, 
        List.generate(question.answers.length, (color) => Colors.transparent)
      );
      question.answers.shuffle();
      question.answers.forEach((answer) =>
        shuffledAnswers.putIfAbsent(answer, () => Colors.transparent)
      );
      */
      List<Answer> shuffledAnswers = question.answers;
      //shuffledAnswers.shuffle();
      
      Column answers = Column(
        children: shuffledAnswers/*.keys*/.map((answer) =>
          Padding(
            padding: const EdgeInsets.all(16),
            child: FlatButton(
              //color: shuffledAnswers[answer],
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
                  //shuffledAnswers[answer] = answer.isCorrect ? Colors.green.shade500 : Colors.red.shade500;
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