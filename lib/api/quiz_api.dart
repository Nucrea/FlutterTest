import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/base/log_service.dart';
import 'package:quiz_app/base/request_result.dart';
import 'package:quiz_app/models/quiz/quiz_model.dart';

class QuizApi {
  // static const apiKey = 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa'; 401 unauthorized
  static const apiKey = 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa';

  static Future<RequestResult< List<QuizModel> >> getQuizzes() async {
    try {
        final response = await http.get(
          Uri.parse('https://quizapi.io/api/v1/questions?limit=1'),
          headers: {
            'X-Api-Key': apiKey,
          }
        );

        if (response.statusCode < 200 || response.statusCode >= 300) {
          throw Exception('status code: ${response.statusCode}');
        }

        final body = jsonDecode(response.body);
        final quizesList = List.from(body);
        print(body);

        final quizzes = <QuizModel>[];
        for (var element in quizesList) {
          quizzes.add(QuizModel.fromJson(element));
        }

        

        return RequestResult(true, value: quizzes);
    } catch(e) {
      LogService.logError(e.toString());
      return RequestResult(false);
    }
  }
}