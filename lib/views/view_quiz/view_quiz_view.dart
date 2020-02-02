import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/views/quiz/quiz_view.dart';
import 'package:studyQ/views/quiz_edit/quiz_edit.dart';

class ViewQuizView extends StatefulWidget {
  ViewQuizView({Key key, this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  _ViewQuizViewState createState() => _ViewQuizViewState();
}

class _ViewQuizViewState extends State<ViewQuizView> {
  @override
  Widget build(
    BuildContext context) {
      return Scaffold(
       appBar: AppBar(
        title: Text(widget.quiz.name),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Start Quiz"),
            onPressed: () {
              HapticFeedback.lightImpact();
              startQuiz(widget.quiz);
            },
          ),
          RaisedButton(
            child: Text("Edit Quiz"),
            onPressed: () {
              HapticFeedback.lightImpact();
              editQuiz(widget.quiz);
            }
          )
        ]
      )
    );
  }

  Future<void> startQuiz(Quiz quiz) async {
    await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return QuizView(quiz: quiz);
    }));
  }

  Future<void> editQuiz(Quiz quiz) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditQuizView(quiz: quiz);
    }));
  }
}