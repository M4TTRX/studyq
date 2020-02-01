import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizCard extends Card {
  QuizCard(Function start)
      : super(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("Quiz"),
              RaisedButton(
                child: Text("Start"),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  start();
                },
              ),
            ],
          ),
        )
      );
}
