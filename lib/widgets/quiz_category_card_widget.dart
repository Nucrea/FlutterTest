import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_category/quiz_category_model.dart';

class QuizCategoryCardWidget extends StatelessWidget {
  final QuizCategoryModel quizCategory;
  final Function(QuizCategoryModel category) onClicked;

  const QuizCategoryCardWidget({
    super.key, 
    required this.quizCategory,
    required this.onClicked,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Card(
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: InkWell(
          onTap: () => onClicked(quizCategory),
          child: Center(
            child: Text(quizCategory.name)
          ),
        )
      ),
    );
  }
}