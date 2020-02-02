import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/service/service.dart';
import 'package:studyQ/views/home/home_view.dart';
import 'package:studyQ/views/shared/primary_button.dart';

// That key is required for the form to work properly
final _formKey = GlobalKey<FormState>(debugLabel: '_formKey');

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    var userName = "";
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(32),
                  child:
                      Image(image: AssetImage('docres/logo.jpg'), width: 128)),
              Text(
                "Login / Create an Account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter your username...",
                  ),
                  onChanged: (input) {
                    userName = input;
                  },
                  validator: (workoutName) {
                    if (userName.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: PrimaryButton(
                  "login",
                  () {
                    HapticFeedback.lightImpact();
                    if (_formKey.currentState.validate()) {
                      AppService.setAccount(userName);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return HomeView();
                      }));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
