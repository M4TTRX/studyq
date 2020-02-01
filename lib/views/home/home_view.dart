import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:studyQ/views/quiz_start/quiz_start_view.dart';

import 'package:studyQ/views/home/components/quiz_card_component.dart';

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
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
          child: ListView.separated(
            padding: const EdgeInsets.all(0),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return QuizCard(startQuiz);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: FloatingActionButton.extended(
              onPressed: () {
                HapticFeedback.lightImpact();
              },
              label: new Text("New Quiz", style: TextStyle(fontSize: 16))),
        ));
  }

  void startQuiz() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return QuizStartView(title: "Start Quiz");
    }));
  }
}
