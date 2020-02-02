import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyQ/service/service.dart';
import 'package:studyQ/views/home/home_view.dart';

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
      body: Container(
        padding: EdgeInsets.fromLTRB(32, 69, 0, 32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Please Log in",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter your username",
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
                child: RaisedButton(
                  child: Text("Login/Sign up"),
                  color: Colors.green,
                  onPressed: () {
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
