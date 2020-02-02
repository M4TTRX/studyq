import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/service/service.dart';
import 'package:studyQ/views/home/home_view.dart';
import 'package:studyQ/views/quiz_edit/components/question_card_component.dart';
import 'package:uuid/uuid.dart';

class EditQuizView extends StatefulWidget {
  EditQuizView({Key key, this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  _EditQuizViewState createState() => _EditQuizViewState();
}

class _EditQuizViewState extends State<EditQuizView> {
  @override
  Widget build(BuildContext context) {
    String quizName = "My Quiz";
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            children: [
              TextFormField(
                onChanged: (input) {
                  quizName = input;
                },
              ),
              Column(
                  children: widget.quiz.questions
                      .map((question) =>
                          QuestionCard(question, updateState: updateState))
                      .toList())
            ]),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: FloatingActionButton.extended(
              onPressed: () {
                HapticFeedback.lightImpact();
                widget.quiz.name = quizName;
                widget.quiz.id = Uuid().v4();
                AppService.setQuiz(widget.quiz);
                Navigator.of(context).pop();
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
