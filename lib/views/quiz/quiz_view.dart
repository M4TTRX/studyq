import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/views/home/components/question_card_component.dart';

class QuizStartView extends StatefulWidget {
  QuizStartView({Key key, this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  _QuizStartViewState createState() => _QuizStartViewState();
}

class _QuizStartViewState extends State<QuizStartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(widget.quiz.name),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: FloatingActionButton.extended(
            onPressed: () {
              HapticFeedback.lightImpact();
            },
            label: new Text("Start Quiz", style: TextStyle(fontSize: 16))),
      )
    );
  }
}