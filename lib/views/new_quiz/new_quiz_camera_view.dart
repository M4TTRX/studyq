import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/service/service.dart';
import 'package:studyQ/views/quiz_edit/quiz_edit.dart';
import 'package:studyQ/views/shared/primary_button.dart';

const _imageBorderRadius = 16.0;

class NewQuizCamera extends StatefulWidget {
  NewQuizCamera({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _NewQuizCameraState createState() => _NewQuizCameraState();
}

class _NewQuizCameraState extends State<NewQuizCamera> {
  File _image;
  bool _tookPicture = false;
  Future<void> _takePic() async {
    File image;
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  _submitImage() async {
    Quiz quiz = await AppService.uploadImage(_image);
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return EditQuizView(quiz: quiz);
    }));
  }

  @override
  Widget build(BuildContext context) {
    if (!_tookPicture) {
      _tookPicture = true;
      _takePic();
    } else if (_tookPicture && _image == null) {
      Navigator.of(context).pop();
    }
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 32.0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_imageBorderRadius),
                ),
                child: _image == null
                    ? Container()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(_imageBorderRadius),
                        child: Image.file(_image, fit: BoxFit.scaleDown))),
            Padding(
                padding: const EdgeInsets.only(top: 16),
                child: PrimaryButton("Submit", () {
                  _submitImage();
                })),
            Padding(
                padding: const EdgeInsets.only(top: 16),
                child: MaterialButton(
                  child: Text(
                    "AGAIN",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    _tookPicture = false;
                    _takePic();
                  },
                )),
          ],
        ),
      ],
    ));
  }
}
