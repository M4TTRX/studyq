import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/views/home/components/question_card_component.dart';

class EditQuizView extends StatefulWidget {
  EditQuizView({Key key, this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  _EditQuizViewState createState() => _EditQuizViewState();
}

class _EditQuizViewState extends State<EditQuizView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(widget.quiz.name),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
        children: widget.quiz.questions.map((question) => QuestionCard(question)).toList()
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: FloatingActionButton.extended(
            onPressed: () {
              HapticFeedback.lightImpact();
            },
            label: new Text("Save Changes", style: TextStyle(fontSize: 16))),
      )
    );
  }
}