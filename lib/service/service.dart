import 'dart:convert';
import 'dart:developer';

import 'package:studyQ/models/quiz_model.dart';

import 'network_service.dart';

class AppService {
  Stream<List<Quiz>> get allQuizItems async* {
    var workouts = await _getQuizItems();
    yield workouts;
  }

  static Future<List<Quiz>> _getQuizItems() async {
    // get accountID
    var accountID = "2";
    String rawJson = await NetworkService.getQuizItemsForAccount(accountID);
    var quizList = List<Quiz>();
    try {
      var quizListMap = json.decode(rawJson);

      for (var m in quizListMap) {
        quizList.add(Quiz.fromMap(m));
      }
      return quizList;
    } catch (e) {
      log("Error parsing json:" + rawJson);
      return [];
    }
  }
}
