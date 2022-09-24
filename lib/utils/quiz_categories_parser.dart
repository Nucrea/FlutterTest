import 'package:html/parser.dart' as parser;
import 'package:quiz_app/models/quiz_category/quiz_category_model.dart';

class QuizCategoriesParser {
  static List<QuizCategoryModel> parse(String html) {
    final models = <QuizCategoryModel>[];

    final document = parser.parse(html);
    final catElements = document.querySelectorAll('.col-lg-3');

    for (var catElement in catElements) {
      final name = catElement.querySelectorAll('h5').elementAt(0).innerHtml.toLowerCase();
      final count = int.parse(catElement.querySelectorAll('strong')[0].innerHtml);

      models.add(QuizCategoryModel(name, count));
    }

    return models;
  }
}