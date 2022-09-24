import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/base/log_service.dart';
import 'package:quiz_app/base/request_result.dart';
import 'package:quiz_app/models/quiz/quiz_model.dart';

class QuizApi {
  static const apiKey = 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa';

  static Future<RequestResult<QuizModel>> getQuiz() async {
    try {
        final response = await http.get(
          Uri.parse('https://quizapi.io/api/v1/questions'),
          headers: {
            'apiKey': apiKey,
          }
        );

        if (response.statusCode < 200 || response.statusCode >= 300) {
          throw Exception('status code: ${response.statusCode}');
        }

        final json = jsonDecode(response.body);
        final quizModel = QuizModel.fromJson(json);

        return RequestResult(true, value: quizModel);
    } catch(e) {
      LogService.logError(e.toString());
      return RequestResult(false);
    }
  }
}