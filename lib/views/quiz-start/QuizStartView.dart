import 'package:flutter/material.dart';

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
    );
  }
}