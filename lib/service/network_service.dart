import 'dart:developer';

import 'package:http/http.dart' as http;

class NetworkService {
  static Future<String> getQuizItemsForAccount() async {
    var url = 'https://studyq-backend-6cmwkb4jva-ue.a.run.app/studyQ/datastore_fetch';
    var response = await http.get(url);
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    return response.body;
  }
}
