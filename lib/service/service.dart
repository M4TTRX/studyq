import 'dart:convert';
import 'dart:developer';

import 'package:studyQ/models/account_model.dart';
import 'package:studyQ/models/quiz_model.dart';
import 'package:studyQ/service/shared_preferences_service.dart';

import 'network_service.dart';

class AppService {
  Stream<List<Quiz>> get quizItemStream async* {
    var quizItems = await _getQuizItems();
    yield quizItems;
  }

  static Future<Account> getAccount() async {
    var account = await SharedPreferencesService.getAccount();
    return account;
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
