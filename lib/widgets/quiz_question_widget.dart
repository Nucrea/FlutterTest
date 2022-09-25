import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz/quiz_model.dart';

class QuizQuestionWidget extends StatelessWidget {
  final QuizModel quiz;
  final Function(QuizModel quiz, String answer) onAnswered;

  const QuizQuestionWidget({
    super.key,
    required this.quiz,
    required this.onAnswered,
  });
  
  @override
  Widget build(BuildContext context) {
    final filteredAnswers = { 
      for (var element in quiz.answers.entries.where((e) => e.value != null)) 
        element.key : element.value as String
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          quiz.question, 
          textScaleFactor: 1.2, 
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        ...filteredAnswers.entries.map((entry) => ElevatedButton(
          onPressed:() => onAnswered(quiz, entry.key),
          child: Text(entry.value),
        )).toList()

        // GridView.builder(
        //   shrinkWrap: true,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //   ),
        //   itemCount: 1,
        //   itemBuilder: (ctx, index) => ElevatedButton(
        //     onPressed: () {},
        //     child: Text(quiz.answers.entries.elementAt(index).value!)
        //   ),
        // )

        // Wrap(
        //   children: quiz.answers.entries.map((entry) => ElevatedButton(
        //     onPressed: () {},
        //     child: Text(entry.value ?? 'null'),
        //   )).toList()
        // )
      ],
    );
  }

  
}