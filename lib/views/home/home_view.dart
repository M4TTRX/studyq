import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:studyQ/views/quiz_start/quiz_start_view.dart';

import 'package:studyQ/views/home/components/quiz_card_component.dart';

import 'package:studyQ/models/quiz_model.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [/* Add account and settings buttons here */],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
        children: <Widget>[
          QuizCard(
            Quiz(
              name: "Name of the First Quiz",
              questions: null), 
            startQuiz: startQuiz
          )
        ]
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: FloatingActionButton.extended(
            onPressed: () {
              HapticFeedback.lightImpact();
            },
            label: new Text("Create Quiz", style: TextStyle(fontSize: 16))),
      )
    );
  }

  Future<void> startQuiz(Quiz quiz) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return QuizStartView(title: quiz.name);
    }));
  }
}