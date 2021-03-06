import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/models/account_model.dart';
import 'package:studyQ/service/service.dart';
import 'package:studyQ/views/new_quiz/new_quiz_camera_view.dart';

import 'package:studyQ/views/view_quiz/view_quiz_view.dart';

import 'package:studyQ/views/home/components/quiz_card_component.dart';

import 'package:studyQ/models/quiz_model.dart';

import 'components/login_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AppService service = AppService();

  @override
  Widget build(BuildContext context) {
    _loadAndVerifyAccount();
    return Scaffold(
      appBar: AppBar(
        title: Text("studyQ"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            HapticFeedback.lightImpact();
            _takePic();
          },
          label: new Text("New Quiz", style: TextStyle(fontSize: 16))),
      body: StreamBuilder<Object>(
        stream: service.quizItemStream,
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      children: quizCardList,
    );
  }

  Future<void> viewQuiz(Quiz quiz) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ViewQuizView(quiz: quiz);
    }));
  }

  Future<void> _takePic() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewQuizCamera();
    }));
  }

  _loadAndVerifyAccount() async {
    Account account = await AppService.getAccount();
    if (account.userName == "<unknown>") {
      await Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginView();
      }));
    } else {
      log(account.userName);
    }
  }
}
