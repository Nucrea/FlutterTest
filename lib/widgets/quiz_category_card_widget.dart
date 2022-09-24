import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_category/quiz_category_model.dart';

class QuizCategoryCardWidget extends StatelessWidget {
  final QuizCategoryModel quizCategory;
  final Function(String category) onClicked;

  const QuizCategoryCardWidget({
    super.key, 
    required this.quizCategory,
    required this.onClicked,
  });
  
  @override
  Widget build(BuildContext context) {
    
    // return InkWell(
    //   onTap: () => onClicked(quizCategory.name),
    //   child: Card(
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(16))
    //     ),
    //     margin: const EdgeInsets.all(10),
    //     child: Text(quizCategory.name),
    //   )
    // );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: InkWell(
        onTap: () => onClicked(quizCategory.name),
        child: Text(quizCategory.name),
      )
    );
  }
}