import 'package:flutter/material.dart';
import 'package:quiz_app/api/quiz_api.dart';
import 'package:quiz_app/models/quiz/quiz_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QuizModel>? quizzes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  void loadQuiz() async {
    setState(() => isLoading = true);
    final quizResponse  = await QuizApi.getQuizzes();
    setState(() => isLoading = false);

    if (!quizResponse.result) {
      return;
    }

    setState(() => quizzes = quizResponse.value);

    QuizApi.getCategories().then((value) => print(value.value?[0].questionsCount));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Test'),
            if (isLoading)
              const CircularProgressIndicator(value: 18),
            if (quizzes != null)
              Text(quizzes!.length.toString()),
          ]
        ),
      ),
    );
  }
}