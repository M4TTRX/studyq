import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:studyQ/models/account_model.dart';

const QUIZZES_URL =
    "https://studyq-backend-6cmwkb4jva-ue.a.run.app/studyQ/datastore_fetch_quizzes?username=";

const ACCOUNT_URL =
    "https://studyq-backend-6cmwkb4jva-ue.a.run.app/studyQ/account?username=anotherone";

class NetworkService {
  static Future<String> getQuizItemsForAccount(String userName) async {
    var url = QUIZZES_URL + userName;
    log(url);
    var response = await http.get(url);
    log('Response status: ${response.statusCode}');

    return response.body;
  }

  static putAccount(String userName) async {
    var url = ACCOUNT_URL + userName;
    log(url);
    var response = await http.post(url);
    log('Response status: ${response.statusCode}');

    return response.body;
  }

  static uploadCloudFile(File file) {}
}
