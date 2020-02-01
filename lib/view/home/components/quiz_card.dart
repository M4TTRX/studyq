import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizCard extends Card {
  QuizCard()
      : super(
            child: Column(
          children: <Widget>[
            Text("Great Quiz"),
            RaisedButton(
              child: Text("Start"),
              onPressed: () {
                HapticFeedback.lightImpact();
              },
            ),
          ],
        ));
}
