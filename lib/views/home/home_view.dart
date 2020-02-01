import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/service/service.dart';

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
  AppService service = AppService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: FloatingActionButton.extended(
            onPressed: () {
              HapticFeedback.lightImpact();
            },
            label: new Text("New Quiz", style: TextStyle(fontSize: 16))),
      ),
      body: StreamBuilder<Object>(
        stream: service.allQuizItems,
        builder: (context, snapchot) {
          return _buildHomeBody(snapchot.data);
        },
      ),
    );
  }

  Widget _buildHomeBody(List<Quiz> quizList) {
    // Generate list of cards
    var quizCardList = List<QuizCard>();
    if (quizList != null) {
      quizList.forEach(
          (quiz) => quizCardList.add(QuizCard(quiz, viewQuiz: viewQuiz)));
    }
    // Return in listview
    return ListView(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
      children: quizCardList,
    );
  }

  Future<void> viewQuiz(Quiz quiz) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return QuizStartView(quiz: quiz);
    }));
  }
}
