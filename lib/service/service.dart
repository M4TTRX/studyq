import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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

  static void setAccount(String userName) async {
    var account = Account(userName: userName);
    await SharedPreferencesService.putAccount(account);
    await NetworkService.putAccount(account.userName);
  }

  static Future<List<Quiz>> _getQuizItems() async {
    // get accountID
    var account = await SharedPreferencesService.getAccount();
    if (account.userName == null) {
      return List<Quiz>();
    }
    String rawJson =
        await NetworkService.getQuizItemsForAccount(account.userName);
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

  static void setQuiz(Quiz quiz) async {
    // get accountID
    var account = await SharedPreferencesService.getAccount();
    if (account.userName == null) {
      log("No username found");
      return;
    }
    NetworkService.newQuizItem(account.userName, quiz.toJson());
  }

  static Future<Quiz> uploadImage(File image) async {
    if (image == null) {
      return Quiz();
    }
    String rawJson = await NetworkService.uploadCloudFile(image);
    return Quiz.fromJson(rawJson);
  }
}
