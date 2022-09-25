import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/base/log_service.dart';
import 'package:quiz_app/base/request_result.dart';
import 'package:quiz_app/models/quiz/quiz_model.dart';
import 'package:quiz_app/models/quiz_category/quiz_category_model.dart';
import 'package:quiz_app/utils/quiz_categories_parser.dart';

class QuizApi {
  static const apiKey = 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa';
  static const baseUrl = 'quizapi.io';

  static Map<String, String> getAuthHeader() {
    return { 'X-Api-Key': apiKey };
  }

  static Future<RequestResult<List<QuizModel>>> getQuizzes({
    int? limit,
    String? difficulty,
    String? category,
  }) async {
    try {
      final params = <String, String>{};
      if (limit != null) {
        params['limit'] = limit.toString();
      }
      if (category != null) {
        params['category'] = category;
      }
      if (difficulty != null) {
        params['difficulty'] = difficulty;
      }

      final response = await http.get(
        Uri.https(baseUrl, '/api/v1/questions', params),
        headers: getAuthHeader(),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception('status code: ${response.statusCode}');
      }

      final body = jsonDecode(response.body);
      final quizesList = List.from(body);

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

  static Future<RequestResult<List<QuizCategoryModel>>> getCategories() async {
    try {
        final response = await http.get(
          Uri.parse('https://quizapi.io/categories'),
          headers: getAuthHeader(),
        );

        final parsedModels = QuizCategoriesParser.parse(response.body);

        return RequestResult(true, value: parsedModels);
    } catch(e) {
      LogService.logError(e.toString());
      return RequestResult(false);
    }
  }
}