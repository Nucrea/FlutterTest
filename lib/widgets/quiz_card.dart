import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz/quiz_model.dart';

class QuizCardWidget extends StatelessWidget {
  final QuizModel quiz;

  const QuizCardWidget({
    super.key, 
    required this.quiz,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      margin: const EdgeInsets.all(10),
      child: Text(quiz.category),
    );
  }
}