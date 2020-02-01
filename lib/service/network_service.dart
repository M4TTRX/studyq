import 'dart:developer';

import 'package:http/http.dart' as http;

class NetworkService {
  static Future<String> getQuizItemsForAccount() async {
    var url =
        "https://studyq-backend-6cmwkb4jva-ue.a.run.app/studyQ/get_quiz?userID=2";
    var response = await http.get(url);
    log('Response status: ${response.statusCode}');

    return response.body;
  }
}
