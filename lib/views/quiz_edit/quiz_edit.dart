import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/service/service.dart';
import 'package:studyQ/views/quiz_edit/components/question_card_component.dart';

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
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            children: widget.quiz.questions
                .map((question) =>
                    QuestionCard(question, updateState: updateState))
                .toList()),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: FloatingActionButton.extended(
              onPressed: () {
                HapticFeedback.lightImpact();
                AppService.uploadQuiz(widget.quiz);
              },
              label: new Text("Save Changes")),
        ));
  }

  void updateState() {
    setState(() {
      return;
    });
  }
}
