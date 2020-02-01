import 'package:studyQ/models/quiz_model.dart';

import 'network_service.dart';

class AppService {
  Stream<List<Quiz>> get allQuizItems async* {
    var workouts = await _getQuizItems();
    yield workouts;
  }

  static Future<List<Quiz>> _getQuizItems() async {
    String json = await NetworkService.getQuizItemsForAccount();
    Quiz quiz = Quiz.fromJson(json);
    return [quiz];
  }
}
