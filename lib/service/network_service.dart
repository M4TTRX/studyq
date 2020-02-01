import 'package:http/http.dart' as http;

class NetworkService {
  static Future<String> getQuizItemsForAccount() async {
    var url = 'https://studyq-backend-6cmwkb4jva-ue.a.run.app/studyQ/mattest';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read('https://example.com/foobar.txt'));
    return response.body;
  }
}
