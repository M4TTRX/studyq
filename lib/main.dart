import 'package:flutter/material.dart';
import 'package:studyQ/view/home/main_view.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(title: 'Flutter Demo Home Page'),
    );
  }
}
