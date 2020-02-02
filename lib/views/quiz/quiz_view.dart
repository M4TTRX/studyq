import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/answer_model.dart';
import 'package:studyQ/models/question_model.dart';
import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/views/quiz_results/quiz_results_view.dart';
import 'package:studyQ/views/shared/primary_button.dart';
import 'package:studyQ/views/shared/whitespace.dart';

class QuizView extends StatefulWidget {
  QuizView({Key key, this.quiz}) : super(key: key) {
    shuffledQuestions = quiz.questions;
    shuffledQuestions.shuffle();
    shuffledQuestions[currentQuestion].answers.shuffle();
  }

  final Quiz quiz;

  List<Question> shuffledQuestions;
  int currentQuestion = 0;
  int score = 0;

  Color incorrectColor = Colors.transparent;
  Color correctColor = Colors.transparent;

  List<Colors> colours;

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  bool hasAnswered = false;
  bool hasFinished = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> content;

    Widget nextQuestionButton = hasAnswered
        ? PrimaryButton(
            "Next Question",
            () => {
                  hasAnswered = false,
                  widget.currentQuestion += 1,
                  widget.correctColor = Colors.transparent,
                  widget.incorrectColor = Colors.transparent,
                  updateState()
                })
        : Container();

    Widget viewResultsButton = hasFinished
        ? PrimaryButton("View Results",
            () => {hasFinished = false, viewResults(widget.quiz, widget.score)})
        : Container();

    if (widget.currentQuestion < widget.shuffledQuestions.length) {
      Question question = widget.shuffledQuestions[widget.currentQuestion];

      List<Answer> shuffledAnswers = question.answers;

      Column answers = Column(
          children: shuffledAnswers
              .map((answer) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: answer.isCorrect
                          ? widget.correctColor
                          : widget.incorrectColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(children: <Widget>[
                          Flexible(
                            child: Text(answer.answer,
                                style: TextStyle(fontSize: 20)),
                            fit: FlexFit.loose,
                          )
                        ]),
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        if (widget.currentQuestion + 1 ==
                            widget.shuffledQuestions.length) {
                          hasFinished = true;
                          nextQuestionButton = MaterialButton(
                              child: Text("View Results"),
                              onPressed: () =>
                                  {viewResults(widget.quiz, widget.score)});
                        }
                        setState(() {
                          if (!hasAnswered) {
                            widget.correctColor = Colors.green.shade200;
                            widget.incorrectColor = Colors.red.shade200;
                            if (answer.isCorrect) {
                              widget.score += 1;
                            }
                          }
                        });
                        hasAnswered = true;
                      },
                    ),
                  ))
              .toList());

      content = [
        Column(
          children: <Widget>[
            Text(question.question,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            answers
          ],
        )
      ];
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.quiz.name)),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(32),
          child: Column(children: content ?? <Widget>[]),
        ),
        Text(widget.score.toString() +
            " / " +
            widget.shuffledQuestions.length.toString()),
        WhiteSpace(),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: hasFinished ? viewResultsButton : nextQuestionButton,
        )
      ]),
    );
  }

  void updateState() {
    setState(() {
      return;
    });
  }

  Future<void> viewResults(Quiz quiz, int score) async {
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return QuizResultsView(quiz: quiz, score: score);
    }));
  }
}
