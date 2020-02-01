import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizStartView extends StatefulWidget {
  QuizStartView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuizStartViewState createState() => _QuizStartViewState();
}

class _QuizStartViewState extends State<QuizStartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
        children: <Widget>[
          Text("Hello")
        ]
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