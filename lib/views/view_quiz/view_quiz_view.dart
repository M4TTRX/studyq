import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/quiz_model.dart';

class ViewQuizView extends StatefulWidget {
  ViewQuizView({Key key, this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  _ViewQuizViewState createState() => _ViewQuizViewState();
}

class _ViewQuizViewState extends State<ViewQuizView> {
  @override
  Widget build(BuildContext context, {Future<void> Function(Quiz quiz) startQuiz}) {
    return Scaffold(
       appBar: AppBar(
        title: Text(widget.quiz.name),
      ),
      body: Column(
        children: <Widget>[
          MaterialButton(
            child: Text("Start Quiz"),
            onPressed: () {
              
            },
          ),
          MaterialButton(
            child: Text("Edit Quiz"),
            onPressed: () {
              
            }
          )
        ]
      )
    );
  }
}